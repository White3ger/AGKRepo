::Disclaimer: This script utilizes installer, guides and components from various companies/persons. It is important to note that these companies/persons are not affiliated with, nor do they endorse, support, or have any connection to this script. The use of their installer and components does not imply any form of partnership or endorsement.
@ECHO OFF
set "downloadlocation=%USERPROFILE%\Downloads\AGKRepo_requirements"
set androidStudioInstaller="%downloadlocation%\android-studio-2024.1.2.13-windows.exe"

echo If you have already Android Studio installed, you can skip this step...
echo Do you want to install Android Studio?
echo (y/n)
set /P installAndroidStudio=
if "%installAndroidStudio%" NEQ "y" goto ErrorAbort

if not exist "%downloadlocation%" mkdir "%downloadlocation%"
if not exist %androidStudioInstaller% bitsadmin /transfer myDownloadJob /download /priority foreground https://redirector.gvt1.com/edgedl/android/studio/install/2024.1.2.13/android-studio-2024.1.2.13-windows.exe %androidStudioInstaller%
if not exist %androidStudioInstaller% goto ErrorAndroidStudioInstaller

start /wait "" %androidStudioInstaller% 
:: /S for silent install

goto Finished

:ErrorAndroidStudioInstaller
echo Android Studio installer not found...
goto Error

:ErrorAbort
echo Abort...
goto Error

:Error
pause
exit 1

:Finished
exit 0