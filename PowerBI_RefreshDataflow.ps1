

# =================================================================================================================================================
# Connect to Power BI Service
# =================================================================================================================================================
Login-PowerBI

# =================================================================================================================================================
# General parameters
# =================================================================================================================================================
# Specify Power BI parameters for workspace and dataset where the current dataset is stored
$WorkspaceID = "390504ca-dfe1-46c6-8c0c-b3aa50b114f5"
$df_global_inventory_item_attributes_staging = "3ddd6942-f407-4869-ab85-e4c927a4bc36"
$df_global_inventory_m20detail_staging = "086168b4-5809-46fa-a0ad-b1c24d3def4c"
$df_global_inventory_shipments_staging = "a13c7f2b-b1e4-4055-81f5-4671b8efd857"
$df_global_inventory_value_staging = "9be2d443-b30d-4ff4-a225-b0b2667406f3"
$df_global_inventory_dims_and_facts = "385bfd43-690c-4bed-8f08-cfaba6c693bf"


$ArrayOfStagingDataflows = @($df_global_inventory_item_attributes_staging,
    $df_global_inventory_m20detail_staging,
    $df_global_inventory_shipments_staging,
    $df_global_inventory_value_staging
)


foreach ($Dataflow in $ArrayOfStagingDataflows) {
    Write-Output $Dataflow
    $uri = "https://api.powerbi.com/v1.0/myorg/groups/$WorkspaceID/Dataflows/$Dataflow/refreshes"

    # Build JSON, convert back and forth as we're just defining it as a string.
    $json = '{"notifyOption": "MailOnFailure"}' | ConvertFrom-Json
    $body = $json | ConvertTo-Json
    
    Invoke-PowerBIRestMethod -Url $uri -body $body -Method POST
    Write-Output "Refresh invoked $Dataflow"
}



