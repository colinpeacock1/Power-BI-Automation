
# =================================================================================================================================================
# General parameters
# =================================================================================================================================================
# Run parameters, please specify below parameters
$WorkspaceId = "5bc65217-59aa-4e90-a82b-12c706a52c21"
$ReportId = "f2327a82-8997-4014-b8ae-fe101954a980"
$TargetDatasetId = "2675d05d-5299-431a-adc5-94a3b1c8ddfb"

# Base variables
$BasePowerBIRestApi = "https://api.powerbi.com/v1.0/myorg/"

# =================================================================================================================================================
# Check task for Power BI Module
# =================================================================================================================================================
# Check whether the Power bI module is installed. If not, it will be installed. 
$moduleName = Get-Module -ListAvailable -Verbose:$false | Where-Object { $_.Name -eq "MicrosoftPowerBIMgmt" } | Select-Object -ExpandProperty Name;
if ([string]::IsNullOrEmpty($moduleName)) {
    Write-Host -ForegroundColor White "==============================================================================";
    Write-Host -ForegroundColor White  "Install module MicrosoftPowerBIMgmt...";
    Install-Module MicrosoftPowerBIMgmt -SkipPublisherCheck -AllowClobber -Force
    Write-Host -ForegroundColor White "==============================================================================";
}

# =================================================================================================================================================
# Task execution
# =================================================================================================================================================
# Connect to Power BI service Account
Write-Host -ForegroundColor White "Connect to PowerBI service"
Connect-PowerBIServiceAccount

# Body to push in the Power BI API call
$body = @"
{datasetId: "$TargetDatasetId"}
"@ 

# Rebind report task
Write-Host -ForegroundColor White "Rebind report to specified dataset..."
Try {
    $RebindApiCall = $BasePowerBIRestApi + "groups/" + $WorkspaceId + "/reports/" + $ReportId + "/Rebind"
    Invoke-PowerBIRestMethod -Method POST -Url $RebindApiCall -Body $body -ErrorAction Stop
    # Write message if succeeded
    Write-Host "Report" $ReportId "successfully binded to dataset" $TargetDatasetId -ForegroundColor Green
}
Catch {
    # Write message if error
    Write-Host "Unable to rebind report. An error occured" -ForegroundColor Red
}