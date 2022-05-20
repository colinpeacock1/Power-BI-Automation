Connect-AzAccount


Param (
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateNotNullOrEmpty()]
    [string]$UserOrGroup
)


if([string]::IsNullOrWhiteSpace($UserOrGroup))
{
   $UserOrGroup = "User"
}

if($UserOrGroup -eq "User")
{
    Write-Host "Started getting ADUsers details..."
    Get-AzADUser | ConvertTo-Csv | Out-File "C:\Users\PeacocCo\ADUsers.csv"
    Write-Host "Finished getting ADUsers details..."
}
else 
{
    Write-Host "Started getting ADGroup details..."
    Get-AzADUser | ConvertTo-Csv | Out-File "C:\Users\PeacocCo\ADGroup.csv"
    Write-Host "Finished getting ADGroup details..."
}