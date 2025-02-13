﻿<# 
This script helps you to get insights in the current refresh schedule for a Power BI dataset.
If you are not the owner of the dataset, you will not be able to see the refresh schedule configured in the Power BI Service. 
Use this code snippet instead to get insights!

More details about this script and the use case behind it, please read this blog post: 
https://data-marc.com/2021/10/13/insights-in-power-bi-dataset-parameters-and-refresh-schedule/
#>

# =================================================================================================================================================
# General parameters
# =================================================================================================================================================
# Specify Power BI parameters for workspace and dataset where the current dataset is stored
$WorkspaceID = "b459d9cd-174c-4f68-a807-7d9e129df8aa"
$DatasetID = "0f4c07f2-facb-4017-9cae-000259c02d08"

# =================================================================================================================================================
# Task execution
# =================================================================================================================================================

# Connect to Power BI Service using OAuth
Connect-PowerBIServiceAccount

# Get refreshschedule values
$GetRefreshSchedule = Invoke-PowerBIRestMethod -Method GET -Url "groups/$WorkspaceID/datasets/$DatasetID/refreshSchedule" | ConvertFrom-Json

# Display Refresh Schedule on screen
$GetRefreshSchedule