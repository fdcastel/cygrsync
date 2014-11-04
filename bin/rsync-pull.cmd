@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

IF "%2" EQU "" (
	GOTO :ShowUsage
) ELSE (
	GOTO :Run
)

:Run
FOR /f "eol=; tokens=* delims=" %%i IN ('cygpath.exe -u "%2"') DO (
	SET CygwinFilename=%%i
)

rsync.exe --compress-level=9 --progress --human-readable "%1" "!CygwinFilename!" %*
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