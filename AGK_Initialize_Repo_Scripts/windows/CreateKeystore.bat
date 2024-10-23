::Disclaimer: This script utilizes installer, guides and components from various companies/persons. It is important to note that these companies/persons are not affiliated with, nor do they endorse, support, or have any connection to this script. The use of their installer and components does not imply any form of partnership or endorsement.
@ECHO OFF
SET "currentLocation=%cd%"
cd /D "%~dp0..\..\AGK_Build\Signing"

echo Create keystore with password "studio" ^(without quotation marks^)
echo The creation of a keystore cause some question.
echo Just write something...
echo ---------------------------------------------
"%ProgramFiles%\Java\jdk-17\bin\keytool.exe" -genkey -v -keystore keystore.keystore -alias tgc -storepass studio -keypass studio -keyalg RSA -keysize 2048 -validity 10000

cd /D "%currentLocation%"
pause
exit 0