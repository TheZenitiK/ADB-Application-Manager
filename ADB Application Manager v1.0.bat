@echo off
setlocal enabledelayedexpansion

rem Set author name
set "AUTHOR=TheZenitiK"

rem --- Define Package Lists ---

rem 5. Google Apps
set "PACKAGES_GOOGLE_APPS=com.google.android.apps.duo com.google.android.apps.one com.google.android.apps.maps com.google.android.music com.google.android.videos com.android.chrome com.google.android.gm com.google.android.youtube com.google.android.apps.tachyon com.google.android.gms.location.devicehealth com.google.android.projection.gearhead com.google.android.apps.wellbeing com.google.android.googlequicksearchbox com.google.android.calendar com.google.android.apps.photos com.google.android.apps.lens com.google.android.apps.safyty com.google.android.marvin.talkback com.google.android.apps.restore com.google.android.apps.nbu.files com.google.android.apps.magazines"

rem 1. MIUI and HyperOS (Cleaned list, without Google Apps)
set "PACKAGES_MIUI_HYPEROS=com.miui.player com.miui.browser com.miui.videoplayer com.facebook.appmanager com.netflix.mediaclient com.amazon.mShop.android.client com.mipay.in com.xiomi.mipicks com.xiaomi.gamebox com.xiaomi.wallpaper.carousel com.xiaomi.shareme com.miui.notes com.miui.weather com.android.sim com.miui.music com.miui.fmradio com.miui.coins com.miui.daemon com.miui.compass com.miui.remote"

rem 2. OriginOS (Placeholder)
set "PACKAGES_ORIGINOS=com.vivo.browser com.vivo.weather com.bbk.account com.vivo.blum.ai com.vivo.wallet com.vivo.globalsearch com.vivo.calculator com.vivo.filemanager com.vivo.music com.vivo.gallery"

rem 3. ColorOS (OPPO and OnePlus) (Placeholder)
set "PACKAGES_COLOROS=com.oppo.market com.coloros.weather.service com.oneplus.calculator com.coloros.broser com.oppo.music com.coloros.filemanager com.android.calendar com.oppo.browser com.android.contacts com.android.dialer com.android.mms"

rem 4. RealmeUI (Placeholder)
set "PACKAGES_REALMEUI=com.heytap.market com.realmepay.in com.realme.calendar com.oplus.music com.hadesker.hiassistant com.oppo.broser com.facebook.system com.facebook.services com.realmi.theme.store"

rem 6. Pre-installed apps (Yandex, RuStore)
set "PACKAGES_PREINSTALLED_APPS=ru.oneme.app com.yandex.browser com.vkontakte.android ru.rustore ru.mail ru.dublgis ru.mirpay ru.odnoklassniki com.yandex.disk com.kaspersky.mobile com.netflix.mediaclient com.yandex.searchapp ru.yandex.mail com.facebook.katana com.instagram.android com.vk.vkvideo ru.yandex.delivery com.yandex.studio ru.yandex.weather com.yandex.music com.tencent.mm com.zhiliaoapp.musically com.zhiliaoapp.musically.lite com.alibaba.intl.android.apps.library com.sina.weibo com.xender com.tencent.mobileqq com.baidu.searchbox com.huawei.appgallery"

rem 7. Often Spyware
set "PACKAGES_SPYWARE=com.mspy com.flexispy com.spyzie com.kidsguard com.cocospy com.mspy com.flexispy com.spyzie com.kidsguard com.cocospy com.sand.airdroid com.phonespy com.ikeymonitor com.xnspy com.thetruthspy com.retina.x com.hoverwatch com.spyera com.mobistealth com.spybubble com.galaxy.mobilespy com.kiddoware com.eyezon spyhacker.appp com.mobilespy com.parentalcontrolapp com.famiapp com.hiddencallrecorder com.keyloggerapp com.spyic com.trackview com.mspybasic com.kidslocator com.spyeraagent"

rem Check for adb in the current directory
if not exist "adb.exe" (
    echo adb.exe not found in the current directory. Please place adb.exe next to this script.
    exit /b 2
)

rem --- ANSI Color Codes ---
set "ESC="
set "GREEN=%ESC%[32m"
set "RED=%ESC%[31m"
set "CYAN=%ESC%[36m"
set "YELLOW=%ESC%[33m"
set "RESET=%ESC%[0m"

rem --- Device Detection Loop ---
:CHECK_DEVICE
cls
echo %CYAN%=======================================================%RESET%
echo Author: %AUTHOR%
echo %GREEN%Welcome! Thank you for choosing this ADB Application Manager.%RESET%
echo %CYAN%=======================================================%RESET%
echo.

rem Reset variables before checking
set "DEVICE_SERIAL="
set "DEVICE_MODEL=device not detected"
set "DEVICE_NAME=device not detected"

rem 1. Search for connected devices
for /f "skip=1 tokens=1,2" %%A in ('adb devices') do (
    if not defined DEVICE_SERIAL if "%%B" neq "" (
        set "DEVICE_SERIAL=%%A"
    )
)

rem 2. Get device properties if connected
if defined DEVICE_SERIAL (
    rem Use delayed expansion !DEVICE_SERIAL! inside for loop
    for /f "usebackq delims=" %%M in (`adb -s !DEVICE_SERIAL! shell getprop ro.product.model 2^>nul`) do set "DEVICE_MODEL=%%M"
    for /f "usebackq delims=" %%N in (`adb -s !DEVICE_SERIAL! shell getprop ro.product.device 2^>nul`) do set "DEVICE_NAME=%%N"
    
    echo Device Name: %GREEN%!DEVICE_NAME!%RESET%
    echo Model: %GREEN%!DEVICE_MODEL!%RESET%
    echo Connection status: %GREEN%connected%RESET%
    echo.
    echo %CYAN%Device successfully detected. Press any key to proceed to the main menu...%RESET%
    pause >nul
    goto MAIN_MENU
) else (
    rem 3. Display disconnected status
    echo Device Name: %RED%!DEVICE_NAME!%RESET%
    echo Model: %RED%!DEVICE_MODEL!%RESET%
    echo Connection status: %RED%disconnected%RESET%
    echo.
    echo %YELLOW%Device not found. Press ENTER to search again...%RESET%
    pause >nul
    goto CHECK_DEVICE
)

rem --- Main Menu ---
:MAIN_MENU
cls
echo %CYAN%=======================================================%RESET%
echo %CYAN%       ADB Application Manager v1.0 by TheZenitiK      %RESET%
echo %CYAN%=======================================================%RESET%
echo.
echo Select the device OS group:
echo.
echo    1. MIUI and HyperOS (Xiaomi/Redmi/Poco)
echo    2. OriginOS (Vivo/iQOO)
echo    3. ColorOS (OPPO/OnePlus)
echo    4. RealmeUI (Realme)
echo    5. %YELLOW%Google Apps%RESET% (Duo, Maps, Chrome, YouTube, etc.)
echo    6. Pre-installed apps (Yandex, RuStore)
echo    7. Often Spyware
echo.
echo    %YELLOW%88. App Renewal%RESET% (Reinstall previously deleted packages for user 0)
echo.
echo    %RED%0. Quit Script%RESET%
echo.

set /p "MAIN_CHOICE=Enter group number (1-7), 88 for Renewal, or 0 to Quit: "

if "%MAIN_CHOICE%"=="0" goto END

if "%MAIN_CHOICE%"=="1" (
    set "CURRENT_OS_NAME=MIUI and HyperOS"
    set "CURRENT_PACKAGES=%PACKAGES_MIUI_HYPEROS%"
    goto GROUP_MENU
)
if "%MAIN_CHOICE%"=="2" (
    set "CURRENT_OS_NAME=OriginOS"
    set "CURRENT_PACKAGES=%PACKAGES_ORIGINOS%"
    goto GROUP_MENU
)
if "%MAIN_CHOICE%"=="3" (
    set "CURRENT_OS_NAME=ColorOS (OPPO and OnePlus)"
    set "CURRENT_PACKAGES=%PACKAGES_COLOROS%"
    goto GROUP_MENU
)
if "%MAIN_CHOICE%"=="4" (
    set "CURRENT_OS_NAME=RealmeUI"
    set "CURRENT_PACKAGES=%PACKAGES_REALMEUI%"
    goto GROUP_MENU
)
if "%MAIN_CHOICE%"=="5" (
    set "CURRENT_OS_NAME=Google Apps"
    set "CURRENT_PACKAGES=%PACKAGES_GOOGLE_APPS%"
    goto GROUP_MENU
)
if "%MAIN_CHOICE%"=="6" (
    set "CURRENT_OS_NAME=Pre-installed apps (Yandex, RuStore)"
    set "CURRENT_PACKAGES=%PACKAGES_PREINSTALLED_APPS%"
    goto GROUP_MENU
)
if "%MAIN_CHOICE%"=="7" (
    set "CURRENT_OS_NAME=Often Spyware"
    set "CURRENT_PACKAGES=%PACKAGES_SPYWARE%"
    goto GROUP_MENU
)
if "%MAIN_CHOICE%"=="88" (
    goto RENEWAL_MENU
)

echo %RED%Invalid choice. Please try again.%RESET%
timeout /t 2 >nul
goto MAIN_MENU

rem --- Group Menu (Select/All for UNINSTALL) ---
:GROUP_MENU
cls
echo %CYAN%=======================================================%RESET%
echo %CYAN%         Group: %CURRENT_OS_NAME%           %RESET%
echo %CYAN%=======================================================%RESET%
echo.
echo Select package number for UNINSTALL (user 0):
echo.

set "COUNT=1"
set "TARGET_PACKAGES="
for %%P in (%CURRENT_PACKAGES%) do (
    echo    !COUNT!. %%P
    set "PACKAGE_!COUNT!=%%P"
    set /a COUNT+=1
)
set /a TOTAL_PACKAGES=COUNT-1

echo.
echo    %YELLOW%99. Uninstall ALL%RESET% (%TOTAL_PACKAGES% packages in this group)
echo    %RED%0. Back to Main Menu%RESET%
echo.

set /p "CHOICE=Enter number (1-%TOTAL_PACKAGES%), 99 for ALL, or 0 to Back: "

if "%CHOICE%"=="0" goto MAIN_MENU

if "%CHOICE%"=="99" (
    set "TARGET_PACKAGES=%CURRENT_PACKAGES%"
    goto UNINSTALL_START
)

rem Check if input is a valid number
set "IS_VALID_NUM=0"
for /l %%N in (1,1,%TOTAL_PACKAGES%) do (
    if "!CHOICE!"=="%%N" (
        set "IS_VALID_NUM=1"
    )
)

if "%IS_VALID_NUM%"=="1" (
    set "TARGET_PACKAGES=!PACKAGE_%CHOICE%!"
    goto UNINSTALL_START
)

echo %RED%Invalid choice. Please try again.%RESET%
timeout /t 2 >nul
goto GROUP_MENU

rem --- Uninstall Execution ---
:UNINSTALL_START
echo.
echo %CYAN%=======================================================%RESET%
echo Starting UNINSTALL process for user 0...
echo %CYAN%=======================================================%RESET%

rem Check if device state is 'device' (connected and ready)
set "DEVICE_STATE="
for /f "delims=" %%S in ('adb -s %DEVICE_SERIAL% get-state 2^>nul') do set "DEVICE_STATE=%%S"

if not "%DEVICE_STATE%"=="device" (
    echo.
    echo %RED%ERROR:%RESET% Device %DEVICE_SERIAL% state is "%DEVICE_STATE%". Connection lost or device is busy.
    echo Returning to connection check...
    pause
    goto CHECK_DEVICE
)

for %%P in (%TARGET_PACKAGES%) do (
    echo.
    echo Attempting to uninstall: %%P
    adb -s %DEVICE_SERIAL% shell pm uninstall --user 0 %%P
    if errorlevel 1 (
        echo %RED%Error%RESET% uninstalling package %%P. It may not exist or require root permissions.
    ) else (
        echo %GREEN%Success!%RESET% Package %%P has been uninstalled for user 0.
    )
)

echo.
echo %CYAN%=======================================================%RESET%
echo Uninstall process finished.
echo %CYAN%=======================================================%RESET%
pause
goto GROUP_MENU

rem --- Renewal Menu (Select OS Group) ---
:RENEWAL_MENU
cls
echo %CYAN%=======================================================%RESET%
echo %CYAN%          App Renewal - Select Group             %RESET%
echo %CYAN%=======================================================%RESET%
echo.
echo Select the group of packages to attempt renewal for (Reinstall for user 0):
echo.
echo    1. MIUI and HyperOS (Xiaomi/Redmi/Poco)
echo    2. OriginOS (Vivo/iQOO)
echo    3. ColorOS (OPPO/OnePlus)
echo    4. RealmeUI (Realme)
echo    5. %YELLOW%Google Apps%RESET%
echo    6. Pre-installed apps (Yandex, RuStore)
echo    7. Often Spyware
echo.
echo    %RED%0. Back to Main Menu%RESET%
echo.

set /p "RENEWAL_CHOICE=Enter group number (1-7) or 0 to Back: "

if "%RENEWAL_CHOICE%"=="0" goto MAIN_MENU

if "%RENEWAL_CHOICE%"=="1" (
    set "CURRENT_OS_NAME=MIUI and HyperOS"
    set "CURRENT_PACKAGES=%PACKAGES_MIUI_HYPEROS%"
    goto RENEWAL_GROUP_SELECTION
)
if "%RENEWAL_CHOICE%"=="2" (
    set "CURRENT_OS_NAME=OriginOS"
    set "CURRENT_PACKAGES=%PACKAGES_ORIGINOS%"
    goto RENEWAL_GROUP_SELECTION
)
if "%RENEWAL_CHOICE%"=="3" (
    set "CURRENT_OS_NAME=ColorOS (OPPO and OnePlus)"
    set "CURRENT_PACKAGES=%PACKAGES_COLOROS%"
    goto RENEWAL_GROUP_SELECTION
)
if "%RENEWAL_CHOICE%"=="4" (
    set "CURRENT_OS_NAME=RealmeUI"
    set "CURRENT_PACKAGES=%PACKAGES_REALMEUI%"
    goto RENEWAL_GROUP_SELECTION
)
if "%RENEWAL_CHOICE%"=="5" (
    set "CURRENT_OS_NAME=Google Apps"
    set "CURRENT_PACKAGES=%PACKAGES_GOOGLE_APPS%"
    goto RENEWAL_GROUP_SELECTION
)
if "%RENEWAL_CHOICE%"=="6" (
    set "CURRENT_OS_NAME=Pre-installed apps (Yandex, RuStore)"
    set "CURRENT_PACKAGES=%PACKAGES_PREINSTALLED_APPS%"
    goto RENEWAL_GROUP_SELECTION
)
if "%RENEWAL_CHOICE%"=="7" (
    set "CURRENT_OS_NAME=Often Spyware"
    set "CURRENT_PACKAGES=%PACKAGES_SPYWARE%"
    goto RENEWAL_GROUP_SELECTION
)

echo %RED%Invalid choice. Please try again.%RESET%
timeout /t 2 >nul
goto RENEWAL_MENU

rem --- Renewal Group Selection (Individual/All) ---
:RENEWAL_GROUP_SELECTION
cls
echo %CYAN%=======================================================%RESET%
echo %CYAN%          Renewal Group: %CURRENT_OS_NAME%            %RESET%
echo %CYAN%=======================================================%RESET%
echo.
echo Select package number for RENEWAL (user 0):
echo.

set "COUNT=1"
set "TARGET_PACKAGES="
for %%P in (%CURRENT_PACKAGES%) do (
    echo    !COUNT!. %%P
    set "PACKAGE_RENEWAL_!COUNT!=%%P"
    set /a COUNT+=1
)
set /a TOTAL_PACKAGES=COUNT-1

echo.
echo    %YELLOW%99. Renew ALL%RESET% (%TOTAL_PACKAGES% packages in this group)
echo    %RED%0. Back to Renewal Menu%RESET%
echo.

set /p "RENEWAL_SELECTION_CHOICE=Enter number (1-%TOTAL_PACKAGES%), 99 for ALL, or 0 to Back: "

if "%RENEWAL_SELECTION_CHOICE%"=="0" goto RENEWAL_MENU

if "%RENEWAL_SELECTION_CHOICE%"=="99" (
    set "TARGET_PACKAGES=%CURRENT_PACKAGES%"
    goto RENEWAL_START
)

rem Check if input is a valid number
set "IS_VALID_NUM=0"
for /l %%N in (1,1,%TOTAL_PACKAGES%) do (
    if "!RENEWAL_SELECTION_CHOICE!"=="%%N" (
        set "IS_VALID_NUM=1"
    )
)

if "%IS_VALID_NUM%"=="1" (
    set "TARGET_PACKAGES=!PACKAGE_RENEWAL_%RENEWAL_SELECTION_CHOICE%!"
    goto RENEWAL_START
)

echo %RED%Invalid choice. Please try again.%RESET%
timeout /t 2 >nul
goto RENEWAL_GROUP_SELECTION

rem --- Renewal Execution ---
:RENEWAL_START
echo.
echo %CYAN%=======================================================%RESET%
echo Starting RENEWAL process for user 0...
echo %CYAN%=======================================================%RESET%

rem Check if device state is 'device' (connected and ready)
set "DEVICE_STATE="
for /f "delims=" %%S in ('adb -s %DEVICE_SERIAL% get-state 2^>nul') do set "DEVICE_STATE=%%S"

if not "%DEVICE_STATE%"=="device" (
    echo.
    echo %RED%ERROR:%RESET% Device %DEVICE_SERIAL% state is "%DEVICE_STATE%". Connection lost or device is busy.
    echo Returning to connection check...
    pause
    goto CHECK_DEVICE
)

for %%P in (%TARGET_PACKAGES%) do (
    echo.
    echo Attempting to renew: %%P
    rem pm install-existing command to reinstall the package for user 0
    adb -s %DEVICE_SERIAL% shell pm install-existing --user 0 %%P
    if errorlevel 1 (
        echo %RED%Error%RESET% renewing package %%P. It may not have been uninstalled or has been fully removed.
    ) else (
        echo %GREEN%Success!%RESET% Package %%P has been renewed for user 0.
    )
)

echo.
echo %CYAN%=======================================================%RESET%
echo Renewal process finished.
echo %CYAN%=======================================================%RESET%
pause
goto RENEWAL_MENU

:END
echo.
echo Exiting script. Goodbye!
endlocal