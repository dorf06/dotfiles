#   Application installs
# --------------------------

# Check to see if we are currently running "as Administrator"
if (!(Test-Elevated)) 
{
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;
    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);

    exit
}

### Chocolatey
Write-Host "Checking for Chocolatey..."
if ($null -eq (Get-Command cinst)) 
{
    Write-Host "Installing Chocolatey..." -ForegroundColor "Yellow"

    Invoke-Expression (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
    
    choco feature enable -n=allowGlobalConfirmation
}
else 
{
    Write-Host "Chocolatey found!" -ForegroundColor "Green"
}