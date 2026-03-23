Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force 


New-Item -Path $profile.CurrentUserAllHosts -Type File -Force

# 1. Copy the .config folder to your User Profile root
$configSrc = Join-Path $PSScriptRoot "../.config"
$configDest = $env:USERPROFILE

if (Test-Path $configSrc) {
    Copy-Item -Path $configSrc -Destination $configDest -Recurse -Force
    Write-Host "Successfully copied .config to $configDest" -ForegroundColor Cyan
} else {
    Write-Warning "Source .config folder not found at $configSrc"
}

# 2. Ensure the PowerShell profile directory exists
$profilePath = $PROFILE.CurrentUserAllHosts
$profileDir = Split-Path $profilePath -Parent

if (!(Test-Path $profileDir)) {
    New-Item -Path $profileDir -ItemType Directory -Force
}

# 3. Copy Profile.ps1 to the official PowerShell profile location
$psProfileSrc = Join-Path $PSScriptRoot "../PowerShellProfile/Profile.ps1"

if (Test-Path $psProfileSrc) {
    Copy-Item -Path $psProfileSrc -Destination $profilePath -Force
    Write-Host "Successfully updated PowerShell profile at $profilePath" -ForegroundColor Cyan
} else {
    Write-Warning "Source Profile.ps1 not found at $psProfileSrc"
}
