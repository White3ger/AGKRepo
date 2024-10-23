::Disclaimer: This script utilizes installer, guides and components from various companies/persons. It is important to note that these companies/persons are not affiliated with, nor do they endorse, support, or have any connection to this script. The use of their installer and components does not imply any form of partnership or endorsement.
@ECHO OFF
::TODO TEST SCRIPT
echo Warning: This script is poorly tested for now and may not work at all.
echo Do you still want to execute this script?
echo ^(y/n^)
set /P startInstallation=
if "%startInstallation%" NEQ "y" goto ErrorAbort

set "downloadlocation=%USERPROFILE%\Downloads\AGKRepo_requirements"

if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer" (
    if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" (
        goto CheckInstalledVS    
    )

    goto ErrorVsWhereNotFound
)

goto PreInstallVs

:CheckInstalledVS
set vsToolPath="%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
for /f "usebackq tokens=*" %%i in (`%vsToolPath% -prerelease -latest -version [17^,18^) -requires Microsoft.VisualStudio.Workload.NativeDesktop -property installationPath`) do (
    echo %%i
    set InstallDir=%%i
)

if exist "%InstallDir%" (
    echo "Visual Studio is already installed with required workload..." & goto Finished
)

for /f "usebackq tokens=*" %%i in (`%vsToolPath% -latest -version [17^,18^) -property installationPath`) do (
    echo %%i
    set InstallDir=%%i
)

if exist "%InstallDir%" (
    echo "Visual Studio is already installed but the required workload is missing..." & goto ModifyVisualStudio
)

:PreInstallVs
set vsInstaller="%downloadlocation%\vs_community.exe"

echo Do you want to install Visual Studio 2022 Community?
echo ^(y/n^)
set /P startInstallation=
if "%startInstallation%" NEQ "y" goto ErrorAbort

if not exist "%downloadlocation%" mkdir "%downloadlocation%"
echo Start download of Visual Studio Community installer...
if not exist %vsInstaller% bitsadmin /transfer myDownloadJob /download /priority foreground https://aka.ms/vs/17/release/vs_community.exe %vsInstaller%
if not exist %vsInstaller% goto ErrorVsInstallerNotFound

start /wait "" %vsInstaller% --add Microsoft.VisualStudio.Workload.NativeDesktop --includeRecommended --norestart --wait > nul
echo %errorlevel%
if %errorlevel% NEQ 0 goto ErrorVsInstallation

goto Finished

:ModifyVisualStudio
set vsInstaller="%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\setup.exe" 

echo Do you want to modify your existing Visual Studio installation: "%InstallDir%"?
echo ^(y/n^)
set /P modifyInstallation=
if "%modifyInstallation%" NEQ "y" goto ErrorAbort

start /wait "" %vsInstaller% modify --add Microsoft.VisualStudio.Workload.NativeDesktop --installPath "%InstallDir%" --includeRecommended --norestart --wait > nul
if %errorlevel% NEQ 0 goto ErrorVsInstallation

goto Finished

:ErrorVsWhereNotFound
echo VS Installer found, but no vswhere ^(required to check installed VS^)
goto Error

:ErrorVsInstallerNotFound
echo Couldn't find VS Installer %vsInstaller%
goto Error

:ErrorVsInstallation
echo Error while installing Visual Studio occured
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