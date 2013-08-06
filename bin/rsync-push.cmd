@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

IF "%2" EQU "" (
	GOTO :ShowUsage
) ELSE (
	GOTO :Run
)

:Run
FOR /f "eol=; tokens=* delims=" %%i IN ('cygpath.exe -u "%1"') DO (
	SET CygwinFilename=%%i
)

rsync.exe --compress-level=9 --progress --human-readable "!CygwinFilename!" "%2::pub/"
GOTO :End


:ShowUsage
ECHO Send a file to remote server.
ECHO.
ECHO usage: %0 [local-file] [remote-server]
ECHO.
ECHO where
ECHO      local-file      file to send
ECHO      remote-server   target server
EXIT /B 1
GOTO :End


:End
ENDLOCAL