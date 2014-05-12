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

rsync.exe --compress-level=9 --progress --human-readable "%1" "!CygwinFilename!"
GOTO :End


:ShowUsage
ECHO Send a file to remote server.
ECHO.
ECHO usage: %0 [remote-file] [local-file] 
ECHO.
ECHO where
ECHO      remote-file   remote file, in rsync format ^(HOST::/folder/file^)
ECHO      local-file    file to write, in Windows format ^(C:\folder\file^)
EXIT /B 1
GOTO :End


:End
ENDLOCAL