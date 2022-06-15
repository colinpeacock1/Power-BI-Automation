# Connect to Power BI Service using OAuth
Connect-PowerBIServiceAccount

function Get-WorkspaceId {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [object] $Workspace
    )

    if (!([string]::IsNullOrEmpty($Workspace.Name))) {
        return $workspace.Id
    }
}

function Get-DataflowId {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [object] $Workspace,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [object] $Dataflow
    )

    if (!([string]::IsNullOrEmpty($Workspace.Name))) {
        return $workspace.Id
    }
}

function Get-BIFlows {

    write-host "--------------------------------------------------------------"
    write-host "Starting... Get-PowerBIDataflow"
    write-host "--------------------------------------------------------------"

    $Dir = "C:\Users\PeacocCo\OneDrive - Coherent, Inc\Documents\PowerBIService\Workspaces\"
    $Workspace = Get-PowerBIWorkspace –All
    $DataSets =
    ForEach ($workspace in $Workspace) {
        Write-Host $workspace.Name
        ForEach ($dataset in (Get-PowerBIDataflow -WorkspaceId $workspace.Id)) {

            [pscustomobject]@{

                WorkspaceName = $Workspace.Name
                WorkspaceID   = $workspace.Id
                DatasetName   = $dataset.Name
                DatasetID     = $dataset.Id
                DatasetOwner  = $dataset.ConfiguredBy
                
            }
        }
    }

    $OutDir = Join-Path -Path $Dir -ChildPath "MyWorkspaceDataflows.csv"
    $DataSets | Export-Csv $OutDir -NoTypeInformation -Encoding UTF8

    write-host "--------------------------------------------------------------"
    write-host "Finished... Get-PowerBIDataflow"
    write-host "--------------------------------------------------------------"
}

# Export-PowerBIDataflow -WorkspaceId 5bc65217-59aa-4e90-a82b-12c706a52c21 -Id 33e96fae-7cb0-46c3-8fbb-19a823f768ca -OutFile .\dataflows\Sales.json

$Workspace = Get-PowerBIWorkspace –All
ForEach ($workspace in $Workspace) {
    [string] $WorkspaceId = Get-WorkspaceId -Workspace $workspace
    Write-Output $workspace.Name $WorkspaceId
    ForEach ($dataflow in (Get-PowerBIDataflow -WorkspaceId $workspace.Id)) {
        $DataFlow = [pscustomobject]@{
            WorkspaceName = $Workspace.Name
            WorkspaceID   = $workspace.Id
            Name          = $dataflow.Name
            ID            = $dataflow.Id
            Owner         = $dataflow.ConfiguredBy        
        }

        Write-Output $workspace.Name $WorkspaceId $dataflow.Name $dataflow.Id
        $jsonPath = ".\dataflows\" + $DataFlow.WorkspaceName + "_" + $DataFlow.Name + ".json"
        Export-PowerBIDataflow -WorkspaceId $WorkspaceId -Id $dataflow.Id -OutFile $jsonPath -WarningAction Continue
    }

}

