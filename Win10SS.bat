@ECHO off
REM	Name: Win10SS.bat
REM 	Author: Brandon Marcelle
REM	Copyright: (c) 2012 imbrankm.com
COLOR 4F
CLS
ECHO.
ECHO. *****Windows 10 Service Stripper, Windows Telemetry Service Disable and Bloatware Remover***** 
ECHO.
ECHO [NOTE:] REQUIRES ADMINISTRATIVE ACCESS!! USE AT OWN DISCRETION! This program will modify Windows Registry Keys, create DIR and log @ ("C:\Program Files\Win10SS"), Disable Windows Services. 
ECHO.
PAUSE
MKDIR "C:\Program Files\WInSecure"
DATE /T >> "C:\Program Files\bats\WinSS\WinSS.log"
TIME /T >> "C:\Program Files\bats\WinSS\WinSS.log"
ECHO. **** If Access is denied 3x, quit application, and open with ADMINISTRATIVE ACCESS! ****
PAUSE
ECHO.
CLS
GOTO BEGIN

:BEGIN
CLS 
COLOR 1F
ECHO ####Windows 10 Service Stripper####
ECHO Program Options
ECHO 1. Remove Bloatware
ECHO 2. Disable Telemetry (Enterprise v. ONLY)
ECHO 3.	Disable Bloat Services
ECHO 4. Disable Cortana Search
ECHO 5. Enable "GOD MODE"
ECHO 6. Exit Program
CHOICE /C 12345 /M "Enter Program Opition"
IF ERRORLEVEL 7 GOTO Leave_Program
IF ERRORLEVEL 6 GOTO GOD_MODE
IF ERRORLEVEL 5 GOTO Disable_CortanaSearch
IF ERRORLEVEL 4 GOTO Disable_Bloat_Services
IF ERRORLEVEL 3 GOTO Disable_Telemetry
IF ERRORLEVEL 2 GOTO 
IF ERRORLEVEL 1 GOTO Remove_Bloatware
:Remove_Bloatware
ECHO Processing...
powershell -command "Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage"
powershell -command "Get-AppxPackage xboxspeech | Remove-AppxPackage"
powershell -command "Get-AppxPackage xboxapp |  Remove-AppxPackage"
powershell -command "Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage"
powershell -command "Get-AppxPackage -name "Microsoft.BingTravel" | Remove-AppxPackage"
powershell -command "Get-AppxPackage -name "Microsoft.BingHealthAndFitness" | Remove-AppxPackage"
powershell -command "Get-AppxPackage -name "Microsoft.BingFoodAndDrink" | Remove-AppxPackage"
powershell -command "Get-AppxPackage -name "Microsoft.BingFinance" | Remove-AppxPackage"
powershell -command "Get-AppxPackage -name "Microsoft.BingNews" | Remove-AppxPackage"
powershell -command "Get-AppxPackage -name "Microsoft.BingWeather" | Remove-AppxPackage"
powershell -command "Get-AppxPackage *messaging* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *phone* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *windowsstore* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *getstarted* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *gethelp* | Remove-AppxPackage"
ECHO.
ECHO "Remove_Bloatware LASTRUN:" >> "C:\Program Files\bats\WinSS\WinSS.log"
powershell -command date >> "C:\Program Files\bats\WinSS\WinSS.log"
ECHO.
ECHO Process Completed Successfully!
PAUSE
GOTO BEGIN 

:Disable_Telemetry
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection /v AllowTelemetry /t REG_DWORD /d 0
powershell -command "Get-Service DiagTrack | Set-Service -StartupType Disabled"
powershell -command "Get-Service dmwappushservice | Set-Service -StartupType Disabled"
ECHO Telemetry had been disabled at %TIME% on %DATE%.
ECHO "Disable Telemetry LASTRUN:" >> "C:\Program Files\bats\WinSS\WinSS.log"
powershell -command date >> "C:\Program Files\bats\WinSS\WinSS.log"
ECHO.
ECHO Process Completed.
PAUSE
ECHO.
GOTO BEGIN 

:Disable_CortanaSearch
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"  /v AllowCortana /t REG_DWORD /d 0
ECHO Process Completed.
PAUSE
GOTO BEGIN

:Disable_Bloat_Services
ECHO ATTN: This will DISABLE Services associated to MS store, telephony, messaging, etc. See README for full list.
PAUSE
ECHO Processing...
powershell -command "Get-Service XboxGipSvc | Set-Service -StartupType Disabled"
powershell -command "Get-Service xbgm | Set-Service -StartupType Disabled"
powershell -command "Get-Service XblAuthManager | Set-Service -StartupType Disabled"
powershell -command "Get-Service XblGameSave | Set-Service -StartupType Disabled"
powershell -command "Get-Service XboxNetApiSvc | Set-Service -StartupType Disabled"
powershell -command "Get-Service InstallService | Set-Service -StartupType Disabled"
powershell -command "Get-Service TapiSrv | Set-Service -StartupType Disabled"
powershell -command "Get-Service MessagingService_203f9 | Set-Service -StartupType Disabled"
powershell -command "Get-Service SEMgrSvc | Set-Service -StartupType Disabled"
powershell -command "Get-Service PhoneSvc | Set-Service -StartupType Disabled"
powershell -command "Get-Service WalletService | Set-Service -StartupType Disabled"
ECHO.
ECHO Bloat Services have been disabled. View Win10ss_README.txt for full list.
ECHO Disble Bloat Services LAST RUN: >> "C:\Program Files\bats\WinSS\WinSS.log"
powershell -command date >> "C:\Program Files\bats\WinSS\WinSS.log"
ECHO Process Completed Successfully
PAUSE
GOTO BEGIN

:GOD_MODE
ECHO This process will enable "GOD MODE" App in (C:\). This is a access point to Admin Tools and their descriptions. 
PAUSE
mkdir C:\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}
ECHO Process completed
PAUSE
GOTO BEGIN

:Leave_Program
ECHO GOODBYE!
ECHO [Author: Brandon Marcelle, Web: imbrankm.com]
GOTO End 

:End
TIMEOUT /T 5
@exit