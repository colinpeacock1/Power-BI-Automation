
function Get-BIReports {

    write-host "--------------------------------------------------------------"
    write-host "Starting... Get-PowerBIReport"
    write-host "--------------------------------------------------------------"

    $Dir = "C:\Users\PeacocCo\OneDrive - Coherent, Inc\Documents\PowerBIService\Workspaces\"
    $Workspace = Get-PowerBIWorkspace –All
    $DataSets =
       ForEach ($workspace in $Workspace)
        {
        Write-Host $workspace.Name
        ForEach ($dataset in (Get-PowerBIReport -WorkspaceId $workspace.Id))
            {

            [pscustomobject]@{

                WorkspaceName = $Workspace.Name
                WorkspaceID = $workspace.Id
                DatasetName = $dataset.Name
                DatasetID = $dataset.Id
                DatasetOwner = $dataset.ConfiguredBy
                
                }
            }
        }

       $OutDir = Join-Path -Path $Dir -ChildPath "MyWorkspaceReports.csv"
       $DataSets | Export-Csv $OutDir -NoTypeInformation -Encoding UTF8

       write-host "--------------------------------------------------------------"
       write-host "Finished... Get-PowerBIReport"
       write-host "--------------------------------------------------------------"
}

function Get-BIFlows {

    write-host "--------------------------------------------------------------"
    write-host "Starting... Get-PowerBIDataflow"
    write-host "--------------------------------------------------------------"

    $Dir = "C:\Users\PeacocCo\OneDrive - Coherent, Inc\Documents\PowerBIService\Workspaces\"
    $Workspace = Get-PowerBIWorkspace –All
    $DataSets =
       ForEach ($workspace in $Workspace)
        {
        Write-Host $workspace.Name
        ForEach ($dataset in (Get-PowerBIDataflow -WorkspaceId $workspace.Id))
            {

            [pscustomobject]@{

                WorkspaceName = $Workspace.Name
                WorkspaceID = $workspace.Id
                DatasetName = $dataset.Name
                DatasetID = $dataset.Id
                DatasetOwner = $dataset.ConfiguredBy
                
                }
            }
        }

       $OutDir = Join-Path -Path $Dir -ChildPath "MyWorkspaceDataflows.csv"
       $DataSets | Export-Csv $OutDir -NoTypeInformation -Encoding UTF8

        write-host "--------------------------------------------------------------"
        write-host "Finished... Get-PowerBIDataflow"
        write-host "--------------------------------------------------------------"
}

function Get-BIDatasets {

    write-host "--------------------------------------------------------------"
    write-host "Starting... Get-PowerBIDataset"
    write-host "--------------------------------------------------------------"

    $Dir = "C:\Users\PeacocCo\OneDrive - Coherent, Inc\Documents\PowerBIService\Workspaces\"
    $Workspace = Get-PowerBIWorkspace –All
    $DataSets =
       ForEach ($workspace in $Workspace)
        {
        Write-Host $workspace.Name
        ForEach ($dataset in (Get-PowerBIDataset -WorkspaceId $workspace.Id))
            {

            [pscustomobject]@{

                WorkspaceName = $Workspace.Name
                WorkspaceID = $workspace.Id
                DatasetName = $dataset.Name
                DatasetID = $dataset.Id
                DatasetOwner = $dataset.ConfiguredBy
                
                }
            }
        }

       $OutDir = Join-Path -Path $Dir -ChildPath "MyWorkspaceDatasets.csv"
       $DataSets | Export-Csv $OutDir -NoTypeInformation -Encoding UTF8

    write-host "--------------------------------------------------------------"
    write-host "Finished... Get-PowerBIDataset"
    write-host "--------------------------------------------------------------"
}


function Get-BIDashboards {


    write-host "--------------------------------------------------------------"
    write-host "Starting... Get-PowerBIDashboard"
    write-host "--------------------------------------------------------------"


    $Dir = "C:\Users\PeacocCo\OneDrive - Coherent, Inc\Documents\PowerBIService\Workspaces\"
    $Workspace = Get-PowerBIWorkspace –All
    $DataSets =
       ForEach ($workspace in $Workspace)
        {
        Write-Host $workspace.Name
        ForEach ($dataset in (Get-PowerBIDashboard -WorkspaceId $workspace.Id))
            {

            [pscustomobject]@{

                WorkspaceName = $Workspace.Name
                WorkspaceID = $workspace.Id
                DatasetName = $dataset.Name
                DatasetID = $dataset.Id
                DatasetOwner = $dataset.ConfiguredBy
                
                }
            }
        }

       $OutDir = Join-Path -Path $Dir -ChildPath "MyWorkspaceDashboards.csv"
       $DataSets | Export-Csv $OutDir -NoTypeInformation -Encoding UTF8

    write-host "--------------------------------------------------------------"
    write-host "Finished... Get-PowerBIDashboard"
    write-host "--------------------------------------------------------------"
}
