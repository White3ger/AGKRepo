@ECHO OFF
set "downloadlocation=%USERPROFILE%\Downloads\AGKRepo_requirements"

SET "currentLocation=%cd%"
cd /D "%~dp0..\..\"
SET "repoLocation=%cd%"
cd /D "%currentLocation%"

set "buildfolder=%repoLocation%\AGK_Build"

echo ---------------------------------------------
echo For this repo, you have to download and unzip some prerequisite in their respective folder:
echo - https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite3/AGK_Build-Shared.zip
echo - https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite2/AGK_Build-External.zip
echo - https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite/AGK_Build-Build.zip
echo Do you want the script to handle this? ^(y/n^) ^(default n^)
SET /P continue=
if "%continue%" NEQ "y" echo Abort... & exit 1

if not exist "%downloadlocation%" mkdir "%downloadlocation%"


echo Start download AGK_Build-Build.zip...
if not exist "%downloadlocation%\AGK_Build-Build.zip" bitsadmin /transfer myDownloadJob /download /priority foreground https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite/AGK_Build-Build.zip "%downloadlocation%\AGK_Build-Build.zip"

echo Start download AGK_Build-External.zip...
if not exist "%downloadlocation%\AGK_Build-External.zip" bitsadmin /transfer myDownloadJob /download /priority foreground https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite2/AGK_Build-External.zip "%downloadlocation%\AGK_Build-External.zip"

echo Start download AGK_Build-Shared.zip...
if not exist "%downloadlocation%\AGK_Build-Shared.zip" bitsadmin /transfer myDownloadJob /download /priority foreground https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite3/AGK_Build-Shared.zip "%downloadlocation%\AGK_Build-Shared.zip"

echo Unzip all zips to their locations ^(please wait, those steps may take some time^)
echo Unzip "%downloadlocation%\AGK_Build-Build.zip" to "%buildfolder%"
tar -xf "%downloadlocation%\AGK_Build-Build.zip" -C "%buildfolder%"

echo Unzip "%downloadlocation%\AGK_Build-External.zip" to "%buildfolder%"
echo this may take some time...
tar -xf "%downloadlocation%\AGK_Build-External.zip" -C "%buildfolder%"

echo Unzip "%downloadlocation%\AGK_Build-Shared.zip" to "%buildfolder%"
tar -xf "%downloadlocation%\AGK_Build-Shared.zip" -C "%buildfolder%"

pause

exit 0