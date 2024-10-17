@echo OFF
cls
SET "repoLocation=%~dp0"
SET "repoLocation=%repoLocation:~0,-1%"
echo Location of the script and repo %repoLocation% (if you have moved the script out of his folder, cancel the execution and move it back)
echo ---------------------------------------------
echo Before taking action, this script will always pause and request a button press to continue.
echo If you don't want something to happen, just close the cmd 
echo or press the keyboard shortcut ctrl + c ...
echo As some people may dislike the idea of always have to press a button for every step...
echo (The script will still ask you prior certain steps)
echo Do you want to pause always? (y/n) (default y) 
SET /P alwayspause=
echo ---------------------------------------------
echo Keep in mind you still have to install Visual Studio, Android Studio, Git, GitHub Desktop and download the jdk files on your own.
echo You also have to place the keystore file on your own to the location (maybe i will change this part later).
echo (if you haven't already)
echo If you need help, refer to the guide - created by someone else - provided here (as attachment): https://forum.thegamecreators.com/thread/229731
echo ---------------------------------------------
echo Start
echo ---------------------------------------------
echo Set environment variable (user scope) ANDROID_HOME to "%LocalAppData%\Android\Sdk"... 
if "%alwayspause%" NEQ "n" pause
setx ANDROID_HOME "%LocalAppData%\Android\Sdk"
echo The AGK_Build System is adjusted to not need the other vars anymore...
echo Do you want to set the remaining environment vars? (y/n) (default n)
SET /P continue=
echo %continue%

if "%continue%" NEQ "y" goto FileDownload

SET currentFolder="%CD%"
cd /D "%UserProfile%"

for %%I in (.) do set AGKUserFolderName=%%~nxI

cd /D %currentFolder%

set "agkstudiopath=%repoLocation%\AGK"
set "ndkpath=%repoLocation%\AGK_Build\External\android-ndk-r20b"
set "steamworkspath=%repoLocation%\AGK_Build\External\Steamworks"
set "vulkansdkpath=%repoLocation%\AGK_Build\External"

echo Set environment variable (user scope) AGK_STUDIO_PATH to "%agkstudiopath%"... 
if "%alwayspause%" NEQ "n" pause
setx AGK_STUDIO_PATH "%agkstudiopath%"

echo Set environment variable (user scope) NDK_PATH to "%ndkpath%"... 
if "%alwayspause%" NEQ "n" pause
setx NDK_PATH "%ndkpath%"

echo Set environment variable (user scope) STEAMWORKS_PATH to "%steamworkspath%"... 
if "%alwayspause%" NEQ "n" pause
setx STEAMWORKS_PATH "%steamworkspath%"

echo Set environment variable (user scope) USERNAMEFORAGK to "%AGKUserFolderName%"... 
if "%alwayspause%" NEQ "n" pause
setx USERNAMEFORAGK "%AGKUserFolderName%"

echo Set environment variable (user scope) VULKAN_SDK_PATH to "%vulkansdkpath%"... 
if "%alwayspause%" NEQ "n" pause
setx VULKAN_SDK_PATH "%vulkansdkpath%"

echo Ignoring environment vars...


:FileDownload
echo ---------------------------------------------
echo According to the readme, you have to download multiple zip files and unzip them in the right directory.
echo Those files are:
echo - https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite3/AGK_Build-Shared.zip
echo - https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite2/AGK_Build-External.zip
echo - https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite/AGK_Build-Build.zip
echo Do you want the script to handle these downloads? (y/n) (default n)
SET /P continue=
set "buildfolder=%repoLocation%\AGK_Build2"
set "downloadlocation=%USERPROFILE%\Downloads\AGKRepo_requirements"
if "%continue%" NEQ "y" goto end
echo Download files to "%downloadlocation%"
if exist "%downloadlocation%" goto FolderCreated

echo Create folder AGKRepo_requirements...
if "%alwayspause%" NEQ "n" pause
mkdir "%downloadlocation%"

:FolderCreated

echo Start download AGK_Build-Build.zip...
if "%alwayspause%" NEQ "n" pause
bitsadmin /transfer myDownloadJob /download /priority foreground https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite/AGK_Build-Build.zip "%downloadlocation%\AGK_Build-Build.zip"
echo Start download AGK_Build-External.zip...
if "%alwayspause%" NEQ "n" pause
bitsadmin /transfer myDownloadJob /download /priority foreground https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite2/AGK_Build-External.zip "%downloadlocation%\AGK_Build-External.zip"
echo Start download AGK_Build-Shared.zip...
if "%alwayspause%" NEQ "n" pause
bitsadmin /transfer myDownloadJob /download /priority foreground https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite3/AGK_Build-Shared.zip "%downloadlocation%\AGK_Build-Shared.zip"

echo Unzip all zips to their locations
echo Unzip "%downloadlocation%\AGK_Build-Build.zip" to "%buildfolder%"
if "%alwayspause%" NEQ "n" pause
tar -xf "%downloadlocation%\AGK_Build-Build.zip" -C "%buildfolder%"

echo Unzip "%downloadlocation%\AGK_Build-External.zip" to "%buildfolder%"
echo this may take some time...
if "%alwayspause%" NEQ "n" pause
tar -xf "%downloadlocation%\AGK_Build-External.zip" -C "%buildfolder%"

echo Unzip "%downloadlocation%\AGK_Build-Shared.zip" to "%buildfolder%"
if "%alwayspause%" NEQ "n" pause
tar -xf "%downloadlocation%\AGK_Build-Shared.zip" -C "%buildfolder%"

:end