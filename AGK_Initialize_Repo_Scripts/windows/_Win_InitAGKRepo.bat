@echo OFF
cls
echo ---------------------------------------------
echo Disclaimer: This script utilizes installer, guides and components from various organisations/companies/persons. It is important to note that these organisations/companies/persons are not affiliated with, nor do they endorse, support, or have any connection to this script. The use of their installer and components does not imply any form of partnership or endorsement.
echo ---------------------------------------------
echo If you don't own a copy of AppGameKit Studio or have otherwise permission to use this repo please cancel the execution of this script!
echo More info here: https://github.com/TheGameCreators/AGKRepo/tree/main/AGK ^(Permitted Usage ^(License^)^)
echo ---------------------------------------------
echo This Script is intended to support you to prepare needed stuff for this repo.
echo What you can expect from this script:
echo -	Providing a checklist of things you have to do
echo -	Install Visual Studio
echo -	Install Android Studio (script can only starts the installer for this one :^( , but you can keep the default settings^)
echo -	Download and unzip JDK17 in the respective folder
echo -	Download and unzip the prerequisite zips from GitHub
echo -  Create keystore file in the respective folder
echo -	Set all environment variables required for this repo
echo ---------------------------------------------
echo If you need help, you can use Zaxxan's helpful guide: " https://forum.thegamecreators.com/thread/229731 " ^(as attachment in the post^)
echo ^(maybe you should download it, before continue^)
echo ---------------------------------------------
echo Let us start to prepare everything...
echo Press any button to continue...
pause

echo Do you have already git, git-lfs ^(Large File Storage^) and GitHub Desktop installed?
echo ^(y/n^)
SET /P userResponse=

if "%userResponse%" NEQ "n" (
    echo You have those already installed? Great! Going to next step...
    goto SkipGitInstall
)

echo How have you downloaded this repo in the first place?
echo Never mind, we can use the batch "InstallGit.bat" in the folder "Windows_InitRepo" to install git.
echo You still have to download GitHub Desktop on your own!
echo Do you want to install git and git-lfs through the script?
echo ^(y/n^)
SET /P userResponse=

if "%userResponse%" NEQ "y" (
    echo Choise: No install through script...
    echo You may install git, git-lfs and GitHub Desktop now, if you havent already.
    echo After installing GitHub Desktop you should also initiate Git-LFS for this repo before continue.
    echo More infos in the guide...
    echo Press any button if you finished installing all 3 and initiated Git-LFS...
    pause

    goto SkipGitInstall
)

start /wait "" "%~dp0InstallGit.bat"

echo You still have to install GitHub Desktop...
echo You can download it here: " https://central.github.com/deployments/desktop/desktop/latest/win32 "
echo This would be a good time to download and install GitHub Desktop, wouldn't it?
echo After installing GitHub Desktop you should also initiate Git-LFS for this repo before continue.
echo More infos in the guide...
echo Press any button, as soon as you have GitHub Desktop installed and initiated Git-LFS...
pause

:SkipGitInstall
echo ---------------------------------------------
echo Do you have Visual Studio 2022 ^(with "Desktop development with C++"^) installed?
echo ^(y/n^)
SET /P userResponse=

if "%userResponse%" NEQ "n" (
    echo You have VS already installed? Great! Going to next step...
    goto SkipVsInstall
)

echo Do you want to install Visual Studio 2022 Community through the script?
echo ^(y/n^)
SET /P userResponse=

if "%userResponse%" NEQ "y" (
    echo Choise: No install through script...
    echo You may install Visual Studio 2022 now, if you havent already.
    echo Press any button if you finished installing Visual Studio...
    pause

    goto SkipVsInstall
)

start /wait "" "%~dp0InstallVS.bat"

:SkipVsInstall
echo ---------------------------------------------
echo Do you have Android Studio installed?
echo ^(y/n^)
SET /P userResponse=

if "%userResponse%" NEQ "n" (
    echo You have Android Studio already installed? Great! Going to next step...
    goto SkipAndroidStudioInstall
)

echo Do you want to install Android Studio through the script?
echo ^(y/n^)
SET /P userResponse=

if "%userResponse%" NEQ "y" (
    echo Choise: No install through script...
    echo You may install Android Studio now, if you havent already.
    echo Press any button if you finished installing Android Studio...
    pause

    goto SkipAndroidStudioInstall
)

start /wait "" "%~dp0InstallAndroidStudio.bat"

:SkipAndroidStudioInstall
echo ---------------------------------------------
echo Do you have downloaded the JDK17 (and unziped to its respective folder)?
echo ^(y/n^)
SET /P userResponse=

if "%userResponse%" NEQ "n" (
    echo You have JDK17 already? Great! Going to next step...
    goto SkipJdk
)

echo Do you want the script to handle the download and unzip of JDK17?
echo ^(y/n^)
SET /P userResponse=

if "%userResponse%" NEQ "y" (
    echo Choise: No download through script...
    echo You may download and unzip JDK17 now, if you havent already.
    echo You should Download jdk17 ^( " https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_windows-x64_bin.zip " ^)
    echo Extract the content of the zip
    echo Rename the extracted jdk-17.02 to jdk-17 and copy the folder into C:\Program Files\Java\
    echo Press any button if JDK17 is in place ...
    pause

    goto SkipJdk
)

::TODO: Start with admin permission...
start /wait powershell.exe -Command "Start-Process cmd -ArgumentList '/c ""%~dp0InstallJDK17.bat""' -Wait -Verb RunAs" 
::start /wait "%~dp0InstallJDK17.bat"
:SkipJdk
echo ---------------------------------------------
echo Do you have downloaded the prerequisites ^(and unziped those to the AGK_Build folder^)?
echo ^(y/n^)
SET /P userResponse=

if "%userResponse%" NEQ "n" (
    echo You have the prerequisites already? Great! Going to next step...
    goto SkipDownloadPrerequisites
)

echo Do you want the script to handle the download and unzip of the prerequisites?
echo ^(y/n^)
SET /P userResponse=

if "%userResponse%" NEQ "y" (
    echo Choise: No download through script...
    echo You may download and unzip the prerequisites now, if you havent already.
    echo Download those files:
    echo - https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite3/AGK_Build-Shared.zip
    echo - https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite2/AGK_Build-External.zip
    echo - https://github.com/TheGameCreators/AGKRepo/releases/download/Prerequisite/AGK_Build-Build.zip
    echo Extract them to D:\Dev\AGKRepo\AGK_Build
    echo Press any button if all prerequisites are in place ...
    pause

    goto SkipDownloadPrerequisites
)

start /wait "" "%~dp0DownloadRepoPrerequisite.bat"
:SkipDownloadPrerequisites
echo ---------------------------------------------
echo Do you have provided a keystore file?
echo ^(y/n^)
SET /P userResponse=

if "%userResponse%" NEQ "n" (
    echo You have the keystore file already? Great! Going to next step...
    goto SkipCreateKeystore
)
echo Do you want the script to assist you with the creation of the keystore file?
echo ^(y/n^)
SET /P userResponse=

if "%userResponse%" NEQ "y" (
    echo Choise: No creation through script...
    echo You may download the keystore file using the link in Zaxxan's guide.
    echo If you want to create your own, take a look into CreateKeystore.bat...
    echo Copy the keystore file to AGK_Build\Signing\keystore.keystore
    echo Press any button if the keystore file is in place ...
    pause

    goto SkipCreateKeystore
)

start /wait "" "%~dp0CreateKeystore.bat"

:SkipCreateKeystore
echo ---------------------------------------------
echo Do you have set all required environment vars?
echo If you are unsure, just insert n 
echo Normally it doesn't hurt to set them again...
echo Furthermore the Script will tell you which environment variables are needed and ask you once again.
echo ^(y/n^)
SET /P userResponse=

if "%userResponse%" NEQ "n" (
    echo You have the environment variables already? Great!.................
    goto LastHints
)

start /wait "" "%~dp0SetEnvironmentVars.bat"

:LastHints
echo ---------------------------------------------
echo ---------------------------------------------
echo ---------------------------------------------
echo Final Hints:
echo Keep in mind to configure all 3 projects in Android Studio...
echo - interpreter_android_google
echo - interpreter_android_amazon
echo - interpreter_android_ouya
echo Head over to the guide for additional information.
echo ^(starting at page 8^)
echo ---------------------------------------------
echo Furthermore, dont forget to copy the content of the HTML5 folder from your installed AGK Studio to "AGK_Build\Shared\WindowsReceive\Studio\HTML5" ^(more infos in the guide created by Zaxxan^)
echo ---------------------------------------------
echo If everything is ready, go to "AGK\tools\AGKBuildSystem\Windows" and double click the "AGKBuild.sln"
echo Now start a rebuild... ^(for more information see the guide^)
echo ---------------------------------------------
echo You finished the preparations!
echo Have fun coding :^)
pause