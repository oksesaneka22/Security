# Define the registry key and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender"
$regName = "DisableAntiSpyware"
$regValue = 1

# Check if the registry key exists
if (-not (Test-Path $regPath)) {
    # Create the registry key if it does not exist
    New-Item -Path $regPath -Force | Out-Null
}

# Set or create the registry value
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWord -Force | Out-Null

# Inform the user to restart the computer
Write-Host "Registry modification completed. You need to restart your computer for the changes to take effect." -ForegroundColor Green