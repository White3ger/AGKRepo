@ECHO OFF
set repoLocation=""
call :GET_ABSOLUTE_PATH repoLocation "%~dp0"

for %%I in ("%USERPROFILE%") do set "AGKUserFolderName=%%~nxI"

if not exist "%repoLocation%" (
    call :ASK_FOR_REPO_PATH repoLocation
    if ERRORLEVEL 1 goto :ERROR_REPO_PATH
    goto :SET_ENV
)

if not exist "%repoLocation%\AGK_Build" (
    call :ASK_FOR_REPO_PATH repoLocation
    if ERRORLEVEL 1 goto :ERROR_REPO_PATH
    goto :SET_ENV
)

if not exist "%repoLocation%\AGK" (
    call :ASK_FOR_REPO_PATH repoLocation
    if ERRORLEVEL 1 goto :ERROR_REPO_PATH
    goto :SET_ENV
)

:SET_ENV

if not exist "%repoLocation%" (
    goto :ERROR_REPO_PATH
)

set "agkstudiopath=%repoLocation%AGK"
set "ndkpath=%repoLocation%AGK_Build\External\android-ndk-r20b"
set "steamworkspath=%repoLocation%AGK_Build\External\Steamworks"
set "vulkansdkpath=%repoLocation%AGK_Build\External"
set "jdk_path=%ProgramFiles%\Java\jdk-17"

if not exist "%repoLocation%AGK_Build" (
    goto :ERROR_REPO_PATH
)

if not exist "%agkstudiopath%" (
    goto :ERROR_REPO_PATH
)

echo This Script will:
echo Set environment variable ^(user scope^) ANDROID_HOME to "%LocalAppData%\Android\Sdk"...
echo Set environment variable ^(user scope^) USERNAMEFORAGK to "%AGKUserFolderName%"... 
echo Set environment variable ^(user scope^) AGK_STUDIO_PATH to "%agkstudiopath%"... 
echo Set environment variable ^(user scope^) NDK_PATH to "%ndkpath%"... 
echo Set environment variable ^(user scope^) STEAMWORKS_PATH to "%steamworkspath%"... 
echo Set environment variable ^(user scope^) VULKAN_SDK_PATH to "%vulkansdkpath%"... 
echo Set environment variable ^(user scope^) JAVA_HOME to "%jdk_path%"... 
echo ^(user scope means for the current windows user only^)
echo Do you want the script to set these environment variables required for this repo?
echo ^(y/n^)
set /P setEnvironmentVars=
if "%setEnvironmentVars%" NEQ "y" echo Abort... & pause & exit /B 1

call :SET_ENV_VARIABLE ANDROID_HOME "%LocalAppData%\Android\Sdk"
call :SET_ENV_VARIABLE USERNAMEFORAGK "%AGKUserFolderName%"
call :SET_ENV_VARIABLE AGK_STUDIO_PATH "%agkstudiopath%"
call :SET_ENV_VARIABLE NDK_PATH "%ndkpath%"
call :SET_ENV_VARIABLE STEAMWORKS_PATH "%steamworkspath%"
call :SET_ENV_VARIABLE VULKAN_SDK_PATH "%vulkansdkpath%"
call :SET_ENV_VARIABLE JAVA_HOME "%jdk_path%"

pause

EXIT /B 0

::SCRIPT ABBORT
:ERROR_REPO_PATH
    echo ERROR: The given directory is not the root directory of the repo or the folder structure do not match the expected one.
    echo Aborting script without changing anything...
    pause
    EXIT /B 1

::FUNCTIONS
:GET_ABSOLUTE_PATH
    SET "%~1=%~dp2"
    EXIT /B

:ASK_FOR_REPO_PATH 
    ::credits to https://stackoverflow.com/a/15885133

    set folder=
    echo The batch failed to find the root directory of the AGKRepo ^(default name AGKRepo and contains AGK and AGK_Build folder^).
    echo Please select the directory...

    set "psCommand="(new-object -COM 'Shell.Application').BrowseForFolder(0,'Please choose the AGKRepo main folder (default name AGKRepo and contains AGK and AGK_Build folder).',0,0).self.path""
    for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

    if not defined folder (
        echo No folder selected...
        EXIT /B 1
    )

    echo Selected directory "%folder%"...
    SET "%~1=%folder%\"
    EXIT /B 0

:SET_ENV_VARIABLE
    call :CHECK_ENV_VARIABLE "%~1" "%%%~1%%" "%~2"
    if %ERRORLEVEL% NEQ 0 (
        echo Variable "%~1" not setted/changed...
        echo ------------------------------------
        exit /B 1
    )

    echo Set Variable "%~1" to "%~2"
    setx %~1 "%~2"
    if %ERRORLEVEL% NEQ 0 (
        echo Unknown error occured, while setting environment variable "%~1"
        echo ------------------------------------
        exit /B 1
    )

    exit /B 0

:CHECK_ENV_VARIABLE
    ::check if any of these variables are already defined...
    if not defined %~1 (
        exit /B 0
    )

    if "%~2" EQU "%~3" (
        echo Variable "%~1" is already set to "%~2"
        exit /B 1
    )

    call echo "%~1" already exist with the value %~2
    echo Do you want to overwrite this with the value %~3?
    echo ^(y/n^)
    set /P overwriteEnv=
    if "%overwriteEnv%" NEQ "y" (
        echo Variable "%~1" will stay at value "%~2"
        exit /B 1
    )

    exit /B 0