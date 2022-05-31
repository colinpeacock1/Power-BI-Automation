let
    Source =
        SnowflakeQuery(
            "SELECT
    ENTITY,
    DEPT,
    ACCT,
    PROJ,
    INTERCO,
    ACCOUNT_DESC,
    GL_PERIOD,
    PERIOD_START_DATE,
    PERIOD_END_DATE,
    ITEM_NUMBER,
    ITEM_DESCRIPTION,
    TRANSACTION_SOURCE,
    TRANS_DATE,
    ACCOUNTED_DR,
    ACCOUNTED_CR,
    NET_ACCOUNTED_AMT,
    ACCOUNTED_NET_USD,
    CURRENCY_CODE,
    VENDOR_NAME,
    VENDOR_NUMBER,
    ORDER_LINE_TYPE,
    ORDER_NUMBER,
    TRX_TYPE_NAME,
    ORDER_TYPE,
    SALES_SERVICE_CODE,
    TRAN_QTY,
    TRX_NUMBER,
    EXTERNAL_SO_NUMBER,
    EXTERNAL_CUSTOMER,
    WIP_JOB_NO,
    PERIOD_YEAR,
    PO_NUMBER,
    JE_NAME,
    JE_LINE_NUM,
    INTERNAL_PO_NUMBER,
    COMMODITY_CATEGORY,
    FORECAST_CATEGORY,
    SUBINVENTORY_CODE,
    ACCOUNT_ALIAS_NAME,
    PLANNER_CODE,
    BUYER_ID,
    ACCOUNTING_LINE_TYPE,
    TRAN_SOURCE_NAME,
    MATERAIL_TRAN_REFERENCE,
    JE_LINE_DESCRIPTION,
    CREATION_DATE,
    WIP_ACCOUNTING_CLASS,
    ALLOCATION_PERCENT,
    MARKET_CODE,
    ITEM_TBU,
    ITEM_PFC,
    ITEM_PRODUCT_LINE,
    ITEM_ORG_TBU,
    ITEM_ORG_PFC,
    M20_TBU,
    M20_PFC,
    HFM_PRODUCT,
    ALT_HFM_PRODUCT,
    --COST_ELEMENT,
    TRANS_DIFF_START,
    MONTH_DAYS,
    REV_TRANS_DATE,
    M2_DETAIL_KEY
    FROM PROD_DB.APPS.XXREP_M20_DETAIL_V as m2
    --WHERE
    --((ACCT >= '40000' AND ACCT <= '49999') OR       -- COGS
    --(ACCT >= '50000' AND ACCT <= '89999'))          -- Department Expenses
    --AND UPPER(M20_TBU) = 'DPSS_GERMANY'
    --AND regexp_instr(GL_PERIOD, '21') > 0"
        ),
    FilterRows = FilterNRows(Source, pSetMaxRows),
    FilterTBUs =
        FilterRowsbyColumn(
            FilterRows,
            pTBU,
            "M20_TBU"
        ),
    ColumnText =
        SetColumnType(
            FilterTBUs,
            pTextColumns,
            "text"
        ),
    ColumnInt =
        SetColumnType(
            ColumnText,
            pNumberColumns,
            "number"
        ),
    ColumnDate =
        SetColumnType(
            ColumnInt,
            pDateColumns,
            "date"
        ),
    IncrementalRefresh =
        Table.SelectRows(
            ColumnDate,
            each
                DateTime.From([REV_TRANS_DATE])
                >= RangeStart and DateTime.From([REV_TRANS_DATE])
                < RangeEnd
        ),
    IncrementalRefreshCanary =
        DateTime.ToText(
            Table.Max(
                IncrementalRefresh,
                each [REV_TRANS_DATE],
                [REV_TRANS_DATE = #datetime(0001, 01, 01, 00, 00, 00)]
            )
                [REV_TRANS_DATE]
        )
in
    IncrementalRefreshCanary