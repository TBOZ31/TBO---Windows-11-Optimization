@echo off
Pushd "%~dp0"
set WorkDir=%CD%

:OSCHECK
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OSARCH=32BIT || set OSARCH=64BIT
If Not %OSARCH% == 64BIT (
 Cls & Echo You must have a x64 architecture to run THE BIG ONE's Windows 11 Optimization Script.
 Goto END
)

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment" > nul
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to run THE BIG ONE's Windows 11 Optimization Script.
 Goto END
)

cls
:
echo				THE BIG ONE's WINDOWS 11 OPTIMIZIATION SCRIPT v12.7
echo				===================================================
echo.
:STEP1
echo.
echo 1)		Disabling UAC [User Account Control] - Elevated Administrator Privledges
REM Disable User Account Control, Run Applications as Administrator:
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f > nul


:STEP2
echo 2)		Installing / Updating Open-Shell
REM Install Open-Shell Explorer & Start Menu:
start /WAIT "Open-Shell" "%WorkDir%\Open-Shell\OpenShellSetup_4_4_191.exe" /qn ADDLOCAL=StartMenu,ClassicExplorer,Update
ping 127.0.0.1 -n 2 > nul 2>&1


:STEP3
echo 3)		Configuring Open-Shell Settings
REM Import TBO Pre-configured Open-Shell Start Menu Settings:
GOTO :OS.START


:STEP4
echo 4)		Configuring GUI visual effects settings for performance and speed
REM Set Windows "Performance" Visual Effects settings to Custom:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "3" /f > nul
REM Disable Animating & Delaying Minimizing and Maximizing Windows:
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f > nul
REM Disable Animations in Taskbar:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "0" /f > nul
REM Disable "Aero-Peek" (Preview Desktop when moving mouse to 'Show Desktop' button at end/corner of taskbar:
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f > nul
REM Enable: "Smooth-scroll list boxes", "Show Window Contents While Dragging"	Disable: "Slide open combo boxes", "Fade or slide menus into view", "Fade or slide ToolTips into view", "Fade out menu items after clicking", "Show shadows under mouse pointer":
Reg.exe add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9812068010000000" /f > nul
REM Disable Application Rounded Corners 
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "UseWindowFrameStagingBuffer" /t REG_DWORD /d "0" /f > nul


:STEP5
echo 5)		Configuring Taskbar Interface Settings
REM Use Small Icons in Taskbar:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSmallIcons" /t REG_DWORD /d "1" /f > nul
REM Don't Combine (Uncombine) Taskbar Applications:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d "2" /f > nul
REM Lock Taskbar:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSizeMove" /t REG_DWORD /d "0" /f > nul
REM Always Show All Icons in System Tray:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "EnableAutoTray" /t REG_DWORD /d "0" /f > nul
REM Disable Searchbox in Taskbar:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f > nul
REM Disable Task View Button:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f > nul
REM Disable "People" icon on Taskbar:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d "0" /f > nul
REM Disable "Aero Peek" preview of desktop when mousing over the "Show Desktop" Icon at the end of the Taskbar:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisablePreviewDesktop" /t REG_DWORD /d "1" /f > nul
REM Disable "News and Interests" from Taskbar
REM Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d "0" /f > nul


:STEP6
echo 6)		Configuring Windows Explorer GUI View, Navigation, and Start Menu settings
REM Start Menu Button Left Alignment
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAl" /t REG_DWORD /d "0" /f > nul
REM Disable Web Search Results in Start Menu::
Reg.exe add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d "1" /f > nul
REM Disable Start Menu "Suggested Applications":
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f > nul
REM Disable "Replace Command Prompt with Windows PowerShell in the Menu when right clicking start button / Pressing Win+X":
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DontUsePowerShellOnWinX" /t REG_DWORD /d "1" /f > nul
REM Always Show Menus in Windows Explorer (No Longer Valid, Re-Enable):
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "AlwaysShowMenus" /t REG_DWORD /d "0" /f > nul
REM Show Hidden Files:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f > nul
REM Always Show File Extensions:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f > nul
REM Windows Explorer will launch to "This PC" by default instead of "Quick Access":
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f > nul
REM Automatically Expand to Current Directory/Folder in Windows Explorer Navigation Pane:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NavPaneExpandToCurrentFolder" /t REG_DWORD /d "1" /f > nul
REM Show All Folders in Windows Explorer Navigation Pane:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NavPaneShowAllFolders" /t REG_DWORD /d "1" /f > nul
REM Show Status Bar at bottom of Windows Explorer:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowStatusBar" /t REG_DWORD /d "0" /f > nul
REM Show Hidden System Files in Windows Explorer:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d "1" /f > nul
REM Show Extended Details During File Transfer Dialog Box:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "EnthusiastMode" /t REG_DWORD /d "1" /f > nul
REM Disable "Show Frequently Used Files / Folders" in Windows Explorer Quick Access:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d "0" /f > nul
REM Disable "Show Recently Used Files / Folders" in Windows Explorer Quick Access:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d "0" /f > nul
REM Disable "Show Recently Opened Items in Jump Lists" on Start Menu & Windows Explorer Quick Access:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d "0" /f > nul
REM Disable "Use Sharing Wizard" in Windows Explorer File / Directory Sharing:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SharingWizardOn" /t REG_DWORD /d "0" /f > nul
REM Disable Window "Snapping" Arrangement:
Reg.exe add "HKCU\Control Panel\Desktop" /v "WindowArrangementActive" /t REG_SZ /d "0" /f > nul
REM Disable Showing ZIP files as directories in Windows Explorer:
Reg.exe delete "HKLM\CompressedFolder\CLSID" /f > nul 2>&1
Reg.exe delete "HKLM\SystemFileAssociations\.zip\CLSID" /f > nul 2>&1
REM Enable Confirmation Dialog When Deleting Files in Windows Explorer:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ConfirmFileDelete" /t REG_DWORD /d "1" /f > nul
REM Enable Compact View in Windows Explorer:
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "UseCompactMode" /t REG_DWORD /d "1" /f > nul

:STEP7
echo 7)		Disable Action Center and Unnecessary Notifications
REM Disable Get Even More out of Windows:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d "0" /f > nul
REM Disable Notification & Action Center: [------------REMOVE FROM SCRIPT UPON TESTING--------------]
REM Reg.exe add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d "1" /f > nul
REM Disable Tips About Windows 11:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f > nul
REM Disable "Toast" notifications:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d "0" /f > nul
REM Disable Lock Screen Notifications:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /t REG_DWORD /d "0" /f > nul
REM Disable "Show Recommendations for tips, shortcuts, new apps, and more"
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_IrisRecommendations" /t REG_DWORD /d "0" /f > nul
REM Disable "Show account related notifications occasionally in Start
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_AccountNotifications" /t REG_DWORD /d "0" /f > nul


:STEP8
echo 8)		Uninstall OneDrive
set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
REM 	Ending OneDrive process.
taskkill /f /im OneDrive.exe > NUL 2>&1
ping 127.0.0.1 -n 3 > NUL 2>&1
REM 	Run built in command-line uninstaller
if exist %x64% (
%x64% /uninstall > NUL 2>&1
) else (
%x86% /uninstall > NUL 2>&1
)
ping 127.0.0.1 -n 3 > NUL 2>&1
REM 	Delete remaining OneDrive files and registry entries.
rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1 
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1


:STEP9
echo 9)		Disable Windows Telemetry - Spybot AntiBeacon Immunization
REM Execute Spybot AntiBeacon Telemetry Neutralization:
start /WAIT "SpybotAntoBeaconPortable" "%WorkDir%\SpybotAntiBeaconPortable\App\SpybotAntiBeacon\SDAntiBeacon.exe" /silent /apply


:STEP10
echo 10)		Disable Windows Telemetry - Additional Settings


:STEP11
echo 11)		Disable and Stop Unnecessary Windows Services
REM Execute TBO Service Optimization Routine:
GOTO TBO.Services


:STEP12
REM Set Applications To Keep (Do Not Uninstall the following)
SET %winstore='*Microsoft.WindowsStore*'
SET %netflix='*Netflix*'
SET %wincalc='*Microsoft.WindowsCalculator*'
SET %NetFramework='*Microsoft.NET*'
SET %VCLibs='*VCLib*'
SET %Xbox='*Xbox*'
SET %Terminal='*Terminal*'
SET %nVidia='*NVIDIA*'
SET %Notepad='*Notepad*'
SET %Phone='*Phone*'
echo 12)		Uninstalling and Deleting Bloatware Metro Apps Shortcuts from User Profiles
REM Remove All Apps from User Profiles Except for Predefined Apps Set By Above Variables:
start /WAIT "AppUninstall" powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -Command "Get-AppxPackage -AllUsers | where-object {$_.name -notlike %winstore%} | where-object {$_.name -notlike %netflix%} | where-object {$_.name -notlike %wincalc%} | where-object {$_.name -notlike %NetFramework%} | where-object {$_.name -notlike %VCLibs%} | where-object {$_.name -notlike %Xbox%} | where-object {$_.name -notlike %Terminal%} | where-object {$_.name -notlike %nVidia%} | where-object {$_.name -notlike %Notepad%} | where-object {$_.name -notlike %Phone%} | Remove-AppxPackage"


:STEP13
echo 13)		Uninstalling and Deleting Bloatware Metro Apps from Provisioned Packages [Free Used Space]
REM Remove All Apps from Provisioned Package Storage Except for Predefined Apps Set By Above Variables:
start /WAIT "AppUninstall" powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -Command "Get-AppxProvisionedPackage -online | where-object {$_.packagename -notlike %winstore%} | where-object {$_.packagename -notlike %netflix%} | where-object {$_.packagename -notlike %wincalc%} | where-object {$_.packagename -notlike %NetFramework%} | where-object {$_.packagename -notlike %VCLibs%} | where-object {$_.packagename -notlike %Xbox%} | where-object {$_.packagename -notlike %Terminal%} | where-object {$_.packagename -notlike %nVidia%} | where-object {$_.packagename -notlike %Notepad%} | where-object {$_.packagename -notlike %Phone%} | Remove-AppxProvisionedPackage -online"


:STEP14
echo 14)		Configuring Windows Theme color settings
REM Enable Windows Desktop Composition Manager:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "Composition" /t REG_DWORD /d "1" /f > nul
REM Disable Start Menu / Windows Transparency:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationGlassAttribute" /t REG_DWORD /d "0" /f > nul
REM Disable "Automatically Pick Accent Color From My Background" setting:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColorBalance" /t REG_DWORD /d "89" /f > nul
REM Set Accent Colors to Gray:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d "3288334336" /f > nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglow" /t REG_DWORD /d "3296097910" /f > nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationAfterglowBalance" /t REG_DWORD /d "10" /f > nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorizationBlurBalance" /t REG_DWORD /d "1" /f > nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "AccentColor" /t REG_DWORD /d "7763574" /f > nul
REM Show Accent Color on Start Menu, Taskbar, Action Center, etc:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "ColorPrevalence" /t REG_DWORD /d "1" /f > nul
REM Disable "Aero-Peek" (Preview Desktop when moving mouse to 'Show Desktop' button at end/corner of taskbar:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f > nul
REM Disable Save Taskbar Thumbnail Previews to Cache:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d "0" /f > nul
REM Set Theme Accent Colors to Gray:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" /v "AccentPalette" /t REG_BINARY /d "cccccc00aeaeae0092929200767676004f4f4f003737370026262600d1343800" /f > nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" /v "StartColorMenu" /t REG_DWORD /d "4283387727" /f > nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" /v "AccentColorMenu" /t REG_DWORD /d "4285953654" /f > nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "ColorPrevalence" /t REG_DWORD /d "1" /f > nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SpecialColor" /t REG_DWORD /d "2721740" /f > nul
REM Disable Start Menu / Windows Transparency:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f > nul
REM Enable Dark Mode:
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d "0" /f > nul
REM Remove Thick Borders on Windows
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "BorderWidth" /t REG_SZ /d "0" /f > nul
Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "PaddedBorderWidth" /t REG_SZ /d "0" /f > nul

:STEP15
echo 15)		Windows Explorer - Remove All User Directories listing under 'This PC' in Explorer File Browser
GOTO Remove.AllUsers.Dirs


:STEP16
echo 16)		Disabling Windows Defender Services, SmartScreen, GPO, and Startup
REM Disable Windows Defender Tamper Protection
REM "%WorkDir%\Tools\PsExec.exe" -accepteula -s reg add "HKLM\Software\Microsoft\Windows Defender\Features" /v "TamperProtection" /t REG_DWORD /d "0" /f > nul 2>&1
"%WorkDir%\Tools\SetACL.exe" -on "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features\\" -ot reg -actn setowner -ownr "n:Administrators" > nul
"%WorkDir%\Tools\SetACL.exe" -on "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features\\" -ot reg -actn ace -ace "n:Administrators;p:full" > nul
"%WorkDir%\Tools\NSudoLC.exe" -U:T -P:E -wait -ShowWindowMode:Hide Reg.exe add "HKLM\Software\Microsoft\Windows Defender\Features" /v "TamperProtection" /t REG_DWORD /d "0" /f
REM Disable Windows Defender Services
"%WorkDir%\Tools\NSudoLC.exe" -U:T -P:E -wait -ShowWindowMode:Hide Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "4" /f
"%WorkDir%\Tools\NSudoLC.exe" -U:T -P:E -wait -ShowWindowMode:Hide Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "4" /f
"%WorkDir%\Tools\NSudoLC.exe" -U:T -P:E -wait -ShowWindowMode:Hide Reg.exe delete "HKLM\Software\Microsoft\Windows Defender\Features" /v "TamperProtectionSource" /f
"%WorkDir%\Tools\NSudoLC.exe" -U:T -P:E -wait -ShowWindowMode:Hide Reg.exe add "HKLM\System\CurrentControlSet\Services\WdFilter" /v "Start" /t REG_DWORD /d "4" /f
"%WorkDir%\Tools\NSudoLC.exe" -U:T -P:E -wait -ShowWindowMode:Hide Reg.exe add "HKLM\System\CurrentControlSet\Services\WdNisDrv" /v "Start" /t REG_DWORD /d "4" /f
"%WorkDir%\Tools\NSudoLC.exe" -U:T -P:E -wait -ShowWindowMode:Hide Reg.exe add "HKLM\System\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "4" /f
"%WorkDir%\Tools\NSudoLC.exe" -U:T -P:E -wait -ShowWindowMode:Hide Reg.exe add "HKLM\System\CurrentControlSet\Services\MDCoreSvc" /v "Start" /t REG_DWORD /d "4" /f
REM Disable Windows Defender GPO
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f > nul
REM Disable Autorun Startup of Windows Defender & Security Health Center:
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WindowsDefender" /f > NUL 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f > NUL 2>&1
taskkill /F /IM MSASCuiL.exe > NUL 2>&1
REM Disable Microsoft Defender Smart Screen
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /d "Off" /f > nul
Reg.exe add "HKCU\Software\Microsoft\Edge" /v "SmartScreenEnabled" /d "0" /f > nul
REM Disable Microsoft Defender Smart Screen for Microsoft Store Apps
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "PreventOverride" /t REG_DWORD /d "0" /f > nul
REM Disable Microsoft Defender Smart Screen for Microsoft Edge:
Reg.exe add "HKCU\Software\Microsoft\Edge\SmartScreenEnabled" /ve /t REG_SZ /d "0" /f > nul
Reg.exe add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v "PreventOverride" /t REG_DWORD /d "0" /f > nul
REM Disable Microsoft Defender Smart Screen for Apps & Files from Web:
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f > nul
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "ShellSmartScreenLevel" /f > NUL 2>&1


:STEP17
echo 17)		Disabling Automatic Updates, Automatic Store Updates, and Automatic Driver Downloads
REM Disable Automatic Windows Update Group Policy:
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "1" /f > nul
REM Disable Peer to Peer Update Sharing:
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization\DODownloadMode" /v "DODownloadMode" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d "0" /f > nul
REM Disable Automatic Download of Winodws Store / App Updates
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /t REG_DWORD /d "2" /f > nul
REM Disable "Allow Apps to Run in Background":
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f > nul
REM Do Not Include Drivers With Windows Updates:
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f > nul
REM Prevent Device Metadata Retrieval from the Internet:
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f > nul
REM Disable Microsoft Edge Automatic Updates
schtasks /delete /tn MicrosoftEdgeUpdateTaskMachineCore /f > NUL 2>&1
schtasks /delete /tn MicrosoftEdgeUpdateTaskMachineUA /f > NUL 2>&1

:STEP18
echo 18)		Disabling Cortana and Start Menu Web Search Suggestions
REM Disable Cortana
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f > nul
REM Disable Start Menu Web Searches and Suggestions
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f > nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "HideRecommendedPersonalizedSites" /t REG_DWORD /d "1" /f > nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "HideRecommendedPersonalizedSites" /t REG_DWORD /d "1" /f > nul


:STEP19
echo 19)		Add 'This PC', 'Network', and 'Recycle Bin' Icons to Desktop
REM Add "This PC" Icon to Desktop
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /t REG_DWORD /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /d "00000000" /f > nul
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu /t REG_DWORD /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /d "00000000" /f > nul
REM Add "Network" Icon to Desktop
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /t REG_DWORD /v "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /d "00000000" /f > nul
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu /t REG_DWORD /v "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /d "00000000" /f > nul
REM Add "Recycle Bin" Icon to Desktop
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /t REG_DWORD /v "{645FF040-5081-101B-9F08-00AA002F954E}" /d "00000000" /f > nul
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu /t REG_DWORD /v "{645FF040-5081-101B-9F08-00AA002F954E}" /d "00000000" /f > nul


:STEP20
echo 20)		Fix "MetaDataStaging failed" Errors in event log
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "DeviceMetadataServiceURL" /t REG_SZ /d "http://dmd.metaservices.microsoft.com/dms/metadata.svc" /f > nul


:STEP21
echo 21)		Disabling Windows Firewall on Internal Private Networks
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "EnableFirewall" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v "EnableFirewall" /t REG_DWORD /d "0" /f > nul


:STEP22
echo 22)		Restore Windows Photo Viewer as Default Image Viewer
Reg.exe add "HKCR\jpegfile\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > nul
Reg.exe add "HKCR\pngfile\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > nul
Reg.exe add "HKCR\Applications\photoviewer.dll\shell\open" /v "MuiVerb" /t REG_SZ /d "@photoviewer.dll,-3043" /f > nul
Reg.exe add "HKCR\Applications\photoviewer.dll\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f > nul
Reg.exe add "HKCR\Applications\photoviewer.dll\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Bitmap" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Bitmap" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3056" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Bitmap\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-70" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Bitmap\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Bitmap\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.JFIF" /v "EditFlags" /t REG_DWORD /d "65536" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.JFIF" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.JFIF" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3055" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.JFIF\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-72" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.JFIF\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.JFIF\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.JFIF\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Jpeg" /v "EditFlags" /t REG_DWORD /d "65536" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Jpeg" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Jpeg" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3055" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Jpeg\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-72" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Jpeg\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Jpeg\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Jpeg\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Gif" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Gif" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3057" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Gif\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-83" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Gif\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Gif\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Png" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Png" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3057" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Png\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-71" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Png\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Png\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Wdp" /v "EditFlags" /t REG_DWORD /d "65536" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Wdp" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Wdp\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\wmphoto.dll,-400" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Wdp\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Wdp\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f > nul
Reg.exe add "HKCR\PhotoViewer.FileAssoc.Wdp\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" /v "ApplicationDescription" /t REG_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3069" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" /v "ApplicationName" /t REG_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3009" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpg" /t REG_SZ /d "PhotoViewer.FileAssoc.Jpeg" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".wdp" /t REG_SZ /d "PhotoViewer.FileAssoc.Wdp" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jfif" /t REG_SZ /d "PhotoViewer.FileAssoc.JFIF" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".dib" /t REG_SZ /d "PhotoViewer.FileAssoc.Bitmap" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".png" /t REG_SZ /d "PhotoViewer.FileAssoc.Png" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jxr" /t REG_SZ /d "PhotoViewer.FileAssoc.Wdp" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".bmp" /t REG_SZ /d "PhotoViewer.FileAssoc.Bitmap" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpe" /t REG_SZ /d "PhotoViewer.FileAssoc.Jpeg" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpeg" /t REG_SZ /d "PhotoViewer.FileAssoc.Jpeg" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".gif" /t REG_SZ /d "PhotoViewer.FileAssoc.Gif" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".tif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".tiff" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul


:STEP23
echo 23)		Removing Unnecessary Driver Startup Entries (Onboard RealTek Audio Control Panel, etc)
REM Remove RealTek Audio Control Panel Auto-Start:
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "RTHDVCPL" /f > nul 2>&1


:STEP24
echo 24)		Enabling F8 Advanced Startup / Diagnostics Menu
REM Set BCDBoot "bootmenupolicy" to Legacy to invoke F8 Start-Up Menu:
bcdedit /set {current} bootmenupolicy Legacy > nul 2>&1


:STEP25
echo 25)		Removing Unnecessary Optional Features (Retail Demo Content, Contact Support, Quick Assist)
DISM /Online /Remove-Capability /CapabilityName:App.Support.ContactSupport~~~~0.0.1.0 > NUL
DISM /Online /Remove-Capability /CapabilityName:App.Support.QuickAssist~~~~0.0.1.0 > NUL
DISM /Online /Remove-Capability /CapabilityName:RetailDemo.OfflineContent.Content~~~~0.0.1.0 > NUL
DISM /Online /Remove-Capability /CapabilityName:RetailDemo.OfflineContent.Content~~~en-US~0.0.1.0 > NUL


:STEP26
echo 26)		Configuring Extended Windows Disk Cleanup Options and Add Shell Context Menu
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Active Setup Temp Folders" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\BranchCache" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Content Indexer Cleaner" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\D3D Shader Cache" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Delivery Optimization Files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Device Driver Packages" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Downloaded Program Files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\GameNewsFiles" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\GameStatisticsFiles" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\GameUpdateFiles" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Internet Cache Files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Offline Pages Files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Old ChkDsk Files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Previous Installations" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Recycle Bin" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\RetailDemo Offline Content" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Service Pack Cleanup" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Setup Log Files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error memory dump files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error minidump files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Setup Files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Sync Files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Update Cleanup" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Upgrade Discarded Files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\User file versions" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows ESD installation files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Upgrade Log Files" /v "StateFlags0999" /t REG_DWORD /d "2" /f > nul
Reg.exe add "HKCR\Drive\shell\runas" /ve /t REG_SZ /d "Extended Disk Cleanup" /f > nul
Reg.exe add "HKCR\Drive\shell\runas" /v "HasLUAShield" /t REG_SZ /d "" /f > nul
Reg.exe add "HKCR\Drive\shell\runas" /v "MultiSelectModel" /t REG_SZ /d "Single" /f > nul
Reg.exe add "HKCR\Drive\shell\runas" /v "Icon" /t REG_EXPAND_SZ /d "%%windir%%\system32\cleanmgr.exe,0" /f > nul
Reg.exe add "HKCR\Drive\shell\runas\Command" /ve /t REG_SZ /d "cmd.exe /c cleanmgr.exe /sagerun:999" /f > nul


:STEP27
echo 27)		Disabling Background Applications (UWP Apps, Edge, Meet Now, etc)
REM Disable "Allow Apps to Run in Background":
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f > nul
REM Disable Microsoft Edge From Running in Background During Boot or After Exiting Application:
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v "AllowPrelaunch" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "StandaloneHubsSidebarEnabled" /t REG_DWORD /d "0" /f > nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d "0" /f > nul
REM Disable Windows Ink Workspace:
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v "AllowWindowsInkWorkspace" /t REG_DWORD /d "0" /f > nul
REM Disable Windows Meet Now
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d "1" /f > nul


:STEP28
echo 28)		Set Desktop Icons to Small Icon Size
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\Shell\Bags\1\Desktop" /V IconSize /T REG_DWORD /D 32 /F > nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\Shell\Bags\1\Desktop" /V Mode /T REG_DWORD /D 1 /F > nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\Shell\Bags\1\Desktop" /V LogicalViewMode /T REG_DWORD /D 3 /F > nul
taskkill /f /im explorer.exe > nul
start explorer.exe > nul


:STEP29
echo 29)		Disable "Show More Options" Context Menu (Always Show All Options Right Click Context Menu)
"%WorkDir%\Tools\SetACL.exe" -on "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\\" -ot reg -actn setowner -ownr "n:Administrators" > nul
"%WorkDir%\Tools\SetACL.exe" -on "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\\" -ot reg -actn ace -ace "n:Administrators;p:full" > nul
"%WorkDir%\Tools\SetACL.exe" -on "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InProcServer32\\" -ot reg -actn setowner -ownr "n:Administrators" > nul
"%WorkDir%\Tools\SetACL.exe" -on "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InProcServer32\\" -ot reg -actn ace -ace "n:Administrators;p:full" > nul
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /ve /t REG_SZ /d "File Explorer Context Menu" /f > nul
Reg.exe delete "HKLM\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InProcServer32" /f > nul
Reg.exe add "HKLM\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InProcServer32" /ve /t REG_SZ /d "" /f > nul


:STEP30
echo 30)		Install ExplorerPatcher (Windows 10 Taskbar)
REM Import Explorer Patcher Windows 10 Taskbar Settings
Reg.exe add "HKEY_CURRENT_USER\Software\ExplorerPatcher" /V ImportOK /T REG_DWORD /D 1 /F > nul
Reg.exe add "HKEY_CURRENT_USER\Software\ExplorerPatcher" /V OldTaskbar /T REG_DWORD /D 2 /F > nul
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /V SearchboxTaskbarMode /T REG_DWORD /D 0 /F > nul
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V ShowTaskViewButton /T REG_DWORD /D 0 /F > nul
Reg.exe add "HKEY_CURRENT_USER\Software\ExplorerPatcher" /V OrbStyle /T REG_DWORD /D 0 /F > nul
Reg.exe add "HKEY_CURRENT_USER\Software\ExplorerPatcher" /V OldTaskbarAl /T REG_DWORD /D 0 /F > nul
Reg.exe add "HKEY_CURRENT_USER\Software\ExplorerPatcher" /V MMOldTaskbarAl /T REG_DWORD /D 0 /F > nul
Reg.exe add "HKEY_CURRENT_USER\Software\ExplorerPatcher" /V TaskbarGlomLevel /T REG_DWORD /D 2 /F > nul
Reg.exe add "HKEY_CURRENT_USER\Software\ExplorerPatcher" /V MMTaskbarGlomLevel /T REG_DWORD /D 2 /F > nul
Reg.exe add "HKEY_CURRENT_USER\Software\ExplorerPatcher" /V TaskbarSmallIcons /T REG_DWORD /D 1 /F > nul
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V TaskbarSizeMove /D 1 /F > nul
REM Copy ExplorerPatcher Updated Win10 Taskbar DLL into Install Location
mkdir "C:\Program Files\ExplorerPatcher" > NUL 2>&1
copy "%WorkDir%\ExplorerPatcher\ep_taskbar.2.amd64.dll" "C:\Program Files\ExplorerPatcher\ep_taskbar.2.dll" /y > nul
REM Install Explorer Patcher (Windows 10 Taskbar)
start /WAIT "ExplorerPatcher" "%WorkDir%\ExplorerPatcher\ep_setup.exe" > nul
REM Move Taskbar to Top (TBO Preference)
taskkill /F /IM explorer.exe > NUL 2>&1
powershell -Command "& {$path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3'; $objName = 'Settings';$getObj = Get-ItemProperty -path $path -name $objName; $getObj.Settings[12] = 1; $objValue = $getObj.Settings; Set-ItemProperty -path $path -name $objName -Value $objValue;}" > NUL 2>&1
powershell -Command "& {$path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRectsLegacy'; $objName = 'Settings';$getObj = Get-ItemProperty -path $path -name $objName; $getObj.Settings[12] = 1; $objValue = $getObj.Settings; Set-ItemProperty -path $path -name $objName -Value $objValue;}" > NUL 2>&1
start explorer.exe


:STEP31
echo 31)		Disable Application Rounded Corners (Patch uDWM.dll)
REM Check for old backup of uDWM.dll and delete to prepare for patch installation and new backup.
IF exist %WINDIR%\System32\uDWM_win11drc.bak (
	del %WINDIR%\System32\uDWM_win11drc.bak > nul
	)
REM Patch uDWM.dll and save original backup to C:\Windows\System32\uDWM_win11drc.bak
start /WAIT "Win11DisableRoundedCorners" "%WorkDir%\Win11DisableRoundedCorners\Win11DisableOrRestoreRoundedCorners.exe" > nul


:STEP32
GOTO EOF


REM	============================================================================================================================================

:OS.START
REM				Open-Shell Configuration
setlocal ENABLEEXTENSIONS
set KEY_NAME="HKEY_LOCAL_MACHINE\SOFTWARE\OpenShell\OpenShell"
set VALUE_NAME=Path

FOR /F "usebackq skip=2 tokens=1-2*" %%A IN (`REG QUERY %KEY_NAME% /v %VALUE_NAME% 2^>nul`) DO (
    set ValueName=%%A
    set ValueType=%%B
    set ValueValue=%%C
)


if defined ValueName (
	set OSMEXE=%ValueValue%StartMenu.exe
	set OSEEXE=%ValueValue%ClassicExplorerSettings.exe
)


IF exist "%OSMEXE%" (
	echo 		Open-Shell Installed: %OSMEXE%
	echo 		Importing Open-Shell Configuration
	GOTO OS.Settings.Import
	
) else (
	echo 		Open-Shell not installed.
	echo 		Skipping settings import.
	GOTO OS.END
)

:OS.Settings.Import 
REM echo [DEBUG] Registry Key:			%KEY_NAME%
REM echo [DEBUG] Registry Value:			%ValueName%	%ValueType%	%ValueValue%
"%OSMEXE%" -xml "%WorkDir%\Open-Shell\TBO-OSM.xml"
"%OSEEXE%" -xml "%WorkDir%\Open-Shell\TBO-OSE.xml"
Reg.exe add "HKCU\Software\OpenShell\ClassicExplorer" /v "ShowedToolbar" /t REG_DWORD /d "1" /f > nul
Reg.exe add "HKCU\Software\OpenShell\ClassicExplorer" /v "NoInitialToolbar" /t REG_DWORD /d "1" /f > nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Enable Browser Extensions" /t REG_SZ /d "yes" /f > nul
GOTO OS.END

:OS.END
GOTO STEP4

REM	============================================================================================================================================

:Remove.AllUsers.Dirs
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f > nul
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f > nul

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f > nul
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f > nul

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f > nul
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f > nul

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f > nul
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f > nul

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f > nul
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f > nul

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f > nul
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f > nul

Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f > nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f > nul 2>&1

GOTO STEP16

REM	============================================================================================================================================

:TBO.Services
REM				THE BIG ONE Windows 11 Service Optimization
REM				===========================================
REM "Stopping and Disabling:	Connected User Experiences and Telemetry	(DiagTrack)"
sc stop "DiagTrack" > nul
sc config "DiagTrack" start= disabled > nul 2>&1

REM "Stopping and Disabling:	Data Collection Publishing Service		(DcpSvc)"
sc stop DcpSvc > nul
sc config "DcpSvc" start= disabled > nul 

REM "Stopping and Disabling:	dmwappushsvc					(dmwappushservice)"
sc stop dmwappushservice > nul
sc config "dmwappushservice" start= disabled > nul 2>&1

REM "Stopping and Disabling:	Downloaded Maps Manager				(MapsBroker)"
sc stop MapsBroker > nul
sc config "MapsBroker" start= disabled > nul 2>&1

REM "Stopping and Disabling:	Geolocation Service				(lfsvc)"
sc stop lfsvc > nul
sc config "lfsvc" start= disabled > nul 2>&1

REM "Starting and Automating:	Function Discovery Resource Publication		(FDResPub)"
sc start FDResPub > nul
sc config "FDResPub" start= auto > nul

REM "Stopping and Disabling:	HomeGroup Listener				(HomeGroupListener)"
sc stop "HomeGroupListener" > nul
sc config "HomeGroupListener" start= disabled > nul 2>&1

REM "Stopping and Disabling:	HomeGroup Provider				(HomeGroupProvider)"
sc stop "HomeGroupProvider" > nul
sc config "HomeGroupProvider" start= disabled > nul 2>&1

REM "Stopping and Disabling:	One Drive Sync Service				(OneSyncSvc)
sc stop "OneSyncSvc" > nul
sc config "OneSyncSvc" start= disabled > nul 2>&1

REM "Stopping and Disabling:	Program Compatability Assistant			(PcaSvc)"
sc stop "PcaSvc" > nul
sc config "PcaSvc" start= disabled > nul 2>&1

REM "Stopping and Disabling:	Superfetch					(SysMain)"
sc stop "SysMain" > nul
sc config "SysMain" start= disabled > nul 2>&1

REM "Stopping and Disabling:	Touch Keyboard and Handwriting Panel Service	(TabletInputService)"
sc stop "TabletInputService" > nul
sc config "TabletInputService" start= disabled > nul 2>&1

REM "Stopping and Disabling:	Windows Error Reporting Service			(WerSvc)"
sc stop "WerSvc" > nul
sc config "WerSvc" start= disabled > nul 2>&1

REM "Stopping and Disabling:	Windows Font Cache Service			(FontCache)"
sc stop "FontCache" > nul
sc config "FontCache" start= disabled > nul 2>&1

REM "Stopping and Disabling:	Windows Search Indexer				(WSearch)"
sc stop "WSearch" > nul
sc config "WSearch" start= disabled > nul 2>&1

REM "Stopping and Disabling:	Windows Presentation Foundation Font Cache	(FontCache3.0.0.0)"
sc stop "FontCache3.0.0.0" > nul
sc config "FontCache3.0.0.0" start= disabled > nul 2>&1

REM "Stopping and Disabling:	Xbox Live Auth Manager				(XblAuthManager)"
sc stop "XblAuthManager" > nul
sc config "XblAuthManager" start= manual > nul 2>&1

REM "Stopping and Disabling:	Xbox Live Game Save				(XblGameSave)"
sc stop "XblGameSave" > nul
sc config "XblGameSave" start= manual > nul 2>&1

REM "Stopping and Disabling:	Xbox Live Networking Service			(XboxNetApiSvc)"
sc stop "XboxNetApiSvc" > nul
sc config "XboxNetApiSvc" start= manual > nul 2>&1

REM "Enabling:			Connected Devices Platform Service		(CDPSvc)"
REM sc stop "CDPSvc" > nul
REM sc config "CDPSvc" start= auto > nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\CDPSvc" /v "Start" /t REG_DWORD /d "2" /f > nul

REM "Enabling:			Network Connection Broker			(NcbService)"
rem sc stop "NcbService" > nul
rem sc config "NcbService" start= disabled > nul 2>&1
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\NcbService" /v "Start" /t REG_DWORD /d "3" /f > nul


REM "Enabling:			Connected Devices Platform User Service		(CDPUserSvc)"
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\CDPUserSvc" /v "Start" /t REG_DWORD /d "2" /f > nul

ping 127.0.0.1 -n 1 > nul 2>&1
GOTO STEP12
REM	============================================================================================================================================


:EOF
echo			-Configuration and Optimization Complete-
:END
Pause
