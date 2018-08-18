@echo off
set OLDAPP=%APPDATA%
set APPDATA=%CD%
XCOPY /ECIH "OLDAPP\Spotify" "%OLDAPP%\Spotify"
RD /S /Q "OLDAPP\Spotify"

cls
echo Spotify is running with your files. You may minimize
echo this window but do not close it. When you are done,
echo close spotify and all your files will be moved back
echo to where this script is located.

spotify.exe
XCOPY /ECIH "%OLDAPP%\Spotify" "OLDAPP\Spotify"
RD /S /Q "%OLDAPP%\Spotify"

cls
echo Safe travels!
timeout /t 5 /nobreak
