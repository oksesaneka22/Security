@echo off
REM Enable Remote Desktop Protocol (RDP)
echo Enabling Remote Desktop Protocol (RDP)...

REM Set the registry key to enable Remote Desktop
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

REM Allow Remote Desktop through Windows Firewall
netsh advfirewall firewall:enable rule name="Remote Desktop"

REM Enable SMBv1 (if necessary, SMBv1 is deprecated but some legacy systems require it)
echo Enabling SMBv1...
sc config lanmanworkstation start= auto
sc config lanmanserver start= auto
sc start lanmanworkstation
sc start lanmanserver

REM Restart the computer to apply changes (optional)
echo Restarting the computer to apply changes...
shutdown /r /t 10

echo Done.
pause
