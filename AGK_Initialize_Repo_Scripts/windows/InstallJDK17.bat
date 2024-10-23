::Disclaimer: This script utilizes installer, guides and components from various companies/persons. It is important to note that these companies/persons are not affiliated with, nor do they endorse, support, or have any connection to this script. The use of their installer and components does not imply any form of partnership or endorsement.
@ECHO OFF
set "downloadlocation=%USERPROFILE%\Downloads\AGKRepo_requirements"
set "targetFolderJava=%ProgramFiles%\Java"
set "targetFolder=%targetFolderJava%\jdk-17"
set jdkZip="%downloadlocation%\openjdk-17.0.2_windows-x64_bin.zip"

echo WARNING: THIS SCRIPT REQUIRES ADMIN PERMISSION
echo IF YOU STARTED THE SCRIPT WITHOUT PERMISSIONS CANCEL THE EXECUTUION!
echo -----------------------------------------------------------------------
echo If you have already JDK17 installed, you can skip this step...
echo Do you want to download and unzip JDK17?
echo (y/n)
set /P downloadJdk=
if "%downloadJdk%" NEQ "y" goto ErrorAbort

if not exist "%downloadlocation%" mkdir "%downloadlocation%"
if exist "%targetFolder%" goto CheckFiles

:AfterCheckFiles

if not exist %jdkZip% bitsadmin /transfer myDownloadJob /download /priority foreground https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_windows-x64_bin.zip %jdkZip%
if not exist %jdkZip% goto ErrorJdkNotFound

tar -xf %jdkZip% -C "%downloadlocation%"

if not exist "%downloadlocation%\jdk-17.0.2" goto ErrorJdkNotFound

if exist "%targetFolderJava%" goto SkipMkDir
mkdir "%targetFolderJava%"
if not exist "%targetFolderJava%" goto ErrorTargetPath
:SkipMkDir

move "%downloadlocation%\jdk-17.0.2" "%targetFolder%"

goto Finished

:CheckFiles

if not exist "%targetFolder%\bin\jarsigner.exe" goto AfterCheckFiles
if not exist "%targetFolder%\bin\java.exe" goto AfterCheckFiles

echo JDK17 files already exists... 
goto Error

:ErrorTargetPath
echo Failed to create target folder "%targetFolderJava%"...
goto Error

:ErrorJdkNotFound
echo JDK not found...
goto Error

:ErrorAbort
echo Abort...
goto Error

:Error
pause
exit 1

:Finished
pause
exit 0