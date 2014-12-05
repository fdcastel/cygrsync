@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

IF "%2" EQU "" GOTO :ShowUsage ELSE GOTO :Run

:Run
FOR /F "eol=; tokens=* delims=" %%i IN ('cygpath.exe -u "%2"') DO SET CygwinFilename=%%i
rsync.exe --compress-level=9 --progress --human-readable "%1" "!CygwinFilename!" %3 %4 %5 %6 %7 %8 %9
GOTO :End


:ShowUsage
ECHO Receive a file/folder from a remote server.
ECHO.
ECHO usage: %0 ^<remote-source^> ^<local-target^> [extra-args]
ECHO.
ECHO where
ECHO      remote-source   Source address in RSYNC format ^(HOST::/folder/file^).
ECHO      local-target    Target file or folder in Windows format ^(C:\folder\file^)
ECHO      extra-args      Extra arguments to rsync. ^(E.g. use '--recursive' for recursive transfers^)
EXIT /B 1
GOTO :End


:End
ENDLOCAL