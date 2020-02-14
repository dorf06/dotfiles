#   Functions file for profile building
# -----------------------------------
Function Start-SSMS
{
    $path = "C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\ssms.exe"

    if (Test-Path $path)
    {
        Start-Process -FilePath $path -Verb RunAsUser
    }
    else 
    {
        Write-Host "SSMS not installed" -ForegroundColor "Red"
    }
}

Function Invoke-SCCMActions
{
  $SCCMClient = New-Object -COM 'CPApplet.CPAppletMgr'
  $actions = $SCCMClient.GetClientActions()

  foreach ($action in $actions) {
    Write-Output "Running Action:`t$($action.name)"
    $action.PerformAction()
  }
}

Function Test-Elevated 
{
    # Get the ID and security principal of the current user account
    $myIdentity=[System.Security.Principal.WindowsIdentity]::GetCurrent()
    $myPrincipal=new-object System.Security.Principal.WindowsPrincipal($myIdentity)
    # Check to see if we are currently running "as Administrator"
    return $myPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}