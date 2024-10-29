::Disclaimer: This script utilizes installer, guides and components from various companies/persons. It is important to note that these companies/persons are not affiliated with, nor do they endorse, support, or have any connection to this script. The use of their installer and components does not imply any form of partnership or endorsement.
@ECHO OFF

::As the repo is already downloaded, there shouldn't be any need for this script.... (unless you downloaded the Repo using the zip in GitHub, instead of using git)
::Keep in mind that you also have to install LFS (large file storage) for git if lfs is not already installed. (The git installed by this script is configured to install lfs too)
::Furthermore you have to install GitHub Desktop if you want to use it (none of the scripts will handle GitHub Desktop)...
set "downloadlocation=%USERPROFILE%\Downloads\AGKRepo_requirements"
set gitInstaller="%downloadlocation%\Git-2.47.0-64-bit.exe"

echo If you have git already installed, you can skip this step...
echo ^(unless you downloaded the zip from GitHub instead of cloning the repo through git / GitHub Desktop, you should press no^)
echo Do you want to install git?
echo ^(y/n^)
set /P installGit=
if "%installGit%" NEQ "y" goto ErrorAbort

if not exist "%downloadlocation%" mkdir "%downloadlocation%"
echo he1
if not exist %gitInstaller% bitsadmin /transfer myDownloadJob /download /priority foreground https://github.com/git-for-windows/git/releases/download/v2.47.0.windows.1/Git-2.47.0-64-bit.exe %gitInstaller%
echo he2
if not exist %gitInstaller% goto ErrorGitInstaller
echo he3

echo Install git...
start /wait "" %gitInstaller% /VERYSILENT /SP- /SUPPRESSMSGBOXES /NORESTART /LOADINF="%~dp0git.ini"

goto Finished

:ErrorGitInstaller
echo Git installer not found...
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