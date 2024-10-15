@ECHO OFF
SET currentFolder="%CD%"
cd /D "%UserProfile%"

for %%I in (.) do set AGKUserFolderName=%%~nxI

cd /D %currentFolder%

setx AGK_STUDIO_PATH "D:\Dev\AGKRepo\AGK"
setx NDK_PATH "D:\Dev\AGKRepo\AGK_Build\External\android-ndk-r20b"
setx STEAMWORKS_PATH "D:\Dev\AGKRepo\AGK_Build\External\Steamworks"
setx USERNAMEFORAGK "%AGKUserFolderName%"
setx VULKAN_SDK_PATH "D:\Dev\AGKRepo\AGK_Build\External"
setx JAVA_HOME "C:\Program Files\Java\jdk-17"
setx ANDROID_HOME "%LocalAppData%\Android\Sdk"