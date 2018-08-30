@echo off
set OLDAPP=%APPDATA%
set APPDATA=%CD%

IF NOT EXIST spotify.exe (
 cls
 echo Spotify.exe is not in the same directory
 echo as this script. Please place this script
 echo next to your spotify.exe file and retry.
 timeout /t 15 /nobreak
 exit
)

taskkill /f /im spotify.exe

cls
echo Relax, your files will be moved to the proper
echo locations in just a moment. Spotify will be
echo started automatically as soon as that is
echo completed.

timeout /t 10 /nobreak

XCOPY /ECIHY "%OLDAPP%\Spotify" "%APPDATA%\"
RD /S /Q "%OLDAPP%\Spotify"
XCOPY /ECIHY "Users" "OLDAPP\Spotify\Users"
XCOPY /ECIHY "prefs" "OLDAPP\Spotify\prefs"

rem not perfect but doesn't leave any files behind so oh well

start start_spotify.bat
