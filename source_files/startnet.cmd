echo off
cls
echo.
echo Please wait...
echo Initiating the preboot environment...
wpeinit>NUL
echo   ...OK!
echo.
echo Awaiting for Ethernet to estabilish connection... 15 seconds.
echo Press any key to skip.
echo.
timeout 15>NUL
echo RiiConnect24 Patcher will start shortly...

set FilesHostedOn=https://kcrPL.github.io/Patchers_Auto_Update/RiiConnect24Patcher
cd/
cd RiiConnect24

:: Trying to download RC24 Patcher.

:1

curl -f -L -s -S --insecure "%FilesHostedOn%/UPDATE/update_assistant.bat" --output "update_assistant.bat"
if not %errorlevel%==0 goto 1_error_no_internet


set /a version_use=0
For /F "Delims=" %%A In ('curl -f -L -s -S --insecure "%FilesHostedOn%/UPDATE/preboot_version.txt"') do set "version_use=%%A"

if %version_use%==0 call "update_assistant.bat" -RC24_Patcher -preboot
if %version_use%==1 call "update_assistant.bat" -RC24_Patcher -preboot -beta

call RiiConnect24Patcher.bat -preboot

goto 1

:1_error_no_internet
cls                                                   
echo.                 
echo.                 
echo.                 
echo.                 
echo.                 
echo.                 
echo.                 
echo.                 
echo.
echo ----------------------------------------------------------------------------------------------------------------------
echo    /---\   ERROR             
echo   /     \  There is no Internet connection.
echo  /   ^!   \ There is a posibility that Internet wasn't initialized.
echo  --------- 
echo            If you can, please connect the Ethernet cable to your computer and please try again.
echo.
echo       What to do now?
echo.
echo  1. Try to redownload RiiConnect24 Patcher.
echo  2. Launch PE Network Manager.
echo  3. Launch a File Explorer.
echo  4. Exit to shell.
echo ----------------------------------------------------------------------------------------------------------------------
echo.
set /p s=Choose: 
if %s%==1 goto 1
if %s%==2 goto launch_pe
if %s%==3 goto launch_explorer
if %s%==4 goto cmd
goto 1_error_no_internet
:launch_pe
"X:\PENetworkManager\PENetwork.exe"
goto 1_error_no_internet

:launch_explorer

"X:\TOTALCMD.exe"
goto 1_error_no_internet


:cmd
cls
echo Alright, launching shell.
echo.
echo Type in exit to return.
echo.
cmd

goto 1


















