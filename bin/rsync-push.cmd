@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

IF "%2" EQU "" GOTO :ShowUsage ELSE GOTO :Run

:Run
FOR /F "eol=; tokens=* delims=" %%i IN ('cygpath.exe -u "%1"') DO SET CygwinFilename=%%i
FOR /F "usebackq tokens=1*" %%i IN (`echo %*`) DO SET ExtraArgs=%%j
rsync.exe --compress-level=9 --progress --human-readable "!CygwinFilename!" !ExtraArgs!
GOTO :End


:ShowUsage
ECHO Send a file/folder to a remote server.
ECHO.
ECHO usage: %0 ^<local-source^> ^<remote-target^> [extra-args]
ECHO.
ECHO where
ECHO      local-source    Source file or folder to send in WINDOWS format ^(C:\folder\file^).
ECHO      remote-target   Target address in RSYNC format ^(HOST::/folder/file^).
ECHO      extra-args      Extra arguments to rsync. ^(E.g. use '--recursive' for recursive transfers^)
EXIT /B 1
GOTO :End


:End
ENDLOCAL