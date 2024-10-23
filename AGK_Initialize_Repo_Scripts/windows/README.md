Use "_Win_InitAGKRepo.bat" to start the script supported initialisation of the repo.
The "_Win_InitAGKRepo.bat" is intended as checklist and to do the steps in the right order.

However, you can also execute any other batch, if you want to execute this step only.
Keep in mind that "InstallJDK17.bat" requires admin permission (as ProgramFiles is a protected folder).

Furthermore certains step like: 
- Configure projects in Android Studio...
    - interpreter_android_google
    - interpreter_android_amazon
    - interpreter_android_ouya
- copy the content of the HTML5 folder from your installed AGK Studio to AGK_Build\Shared\WindowsReceive\Studio\HTML5

are not handled by any of these batch files.