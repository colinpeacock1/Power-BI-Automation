# connect using credentials
# $myCred = Get-Credential
Connect-PowerBIServiceAccount #$myCred

$Workspaces = Get-PowerBIWorkspace

<#
    1. Set-up export file
    2. Remove any existing refresh history file
#>

$ExportFile = 'C:\Users\PeacocCo\OneDrive - Coherent, Inc\Documents\PowerBiRefreshHistoryDataFlows.csv'
Remove-Item $ExportFile -Force -ErrorAction SilentlyContinue


<#
    1. Loop through each workspace where the credentials have read access
    2. For each workspace get a dataset that is refreshable
    3. Loop through datasets that are identified as refreshable
    4. Set the URI to connect the REST API
    5. Use the PowerBI Rest method to get the results of the refresh
    6. For each refresh result get the key attributes and add to a new object
    7. Write the results object to a csv file with name $ExportFile
#>

foreach ($workspace in $Workspaces) {
    try {

        $DataSets = Get-PowerBIDataflow -WorkspaceId $workspace.Id
        foreach ($dataset in $DataSets) {
            $URI = "groups/" + $workspace.id + "/dataflows/" + $dataset.id + "/transactions"
            $Results = Invoke-PowerBIRestMethod -Url $URI -Method Get | ConvertFrom-Json
            write-host $workspace.name $dataset.name

            <# 
            remove this comment to show the results information
            write-host $Results.value
             #>
            foreach ($result in $Results.value) {
                $errorDetails = $result.serviceExceptionJson | ConvertFrom-Json -ErrorAction SilentlyContinue
                
                $row = New-Object psobject
                $row | Add-Member -Name "Workspace" -Value $workspace.Name -MemberType NoteProperty
                $row | Add-Member -Name "Dataset" -Value $dataset.Name -MemberType NoteProperty
                $row | Add-Member -Name "ConfiguredBy" -Value $dataset.ConfiguredBy -MemberType NoteProperty
                $row | Add-Member -Name "refreshType" -Value $result.refreshType -MemberType NoteProperty
                $row | Add-Member -Name "startTime" -Value $result.startTime -MemberType NoteProperty
                $row | Add-Member -Name "endTime" -Value $result.endTime -MemberType NoteProperty
                $row | Add-Member -Name "status" -Value $result.status -MemberType NoteProperty
                $row | Add-Member -Name "errorCode" -Value $errorDetails.errorCode -MemberType NoteProperty
                $row | Add-Member -Name "errorDescription" -Value $errorDetails.errorDescription -MemberType NoteProperty

                write-host $row

                $row | Export-Csv -Path $ExportFile -Append -Delimiter ';' -NoTypeInformation

            }

        }

    }
    catch {

        write-host "error..."

    }
}

# Disconect the service account
Disconnect-PowerBIServiceAccount