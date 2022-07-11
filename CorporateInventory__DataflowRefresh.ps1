

# =================================================================================================================================================
# Connect to Power BI Service
# =================================================================================================================================================
Login-PowerBI

# =================================================================================================================================================
# General parameters
# =================================================================================================================================================
# Specify Power BI parameters for workspace and dataset where the current dataset is stored
$WorkspaceID = "390504ca-dfe1-46c6-8c0c-b3aa50b114f5"
$df_global_inventory_dims_and_facts = "385bfd43-690c-4bed-8f08-cfaba6c693bf"


Write-Output $df_global_inventory_dims_and_facts
$uri = "https://api.powerbi.com/v1.0/myorg/groups/$WorkspaceID/Dataflows/$df_global_inventory_dims_and_facts/refreshes"

# Build JSON, convert back and forth as we're just defining it as a string.
$json = '{"notifyOption": "MailOnFailure"}' | ConvertFrom-Json
$body = $json | ConvertTo-Json

Invoke-PowerBIRestMethod -Url $uri -body $body -Method POST
Write-Output "Refresh invoked $df_global_inventory_dims_and_facts"




