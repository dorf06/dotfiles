#   Installation script for Windows dotfiles
#-------------------------------------------

# Copies files over to Profile directory
$profileDir = Split-Path -parent $profile
New-Item $profileDir -ItemType Directory -Force -ErrorAction SilentlyContinue
Copy-Item -Path ./*.ps1 -Destination $profileDir -Exclude "install.ps1"
Remove-Variable profileDir

# Check to see if we are currently running "as Administrator"
if (!(Test-Elevated)) 
{
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;
    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);

    exit
}

### Update Help for Modules
Write-Host "Updating Help..." -ForegroundColor "Yellow"
Update-Help -Force