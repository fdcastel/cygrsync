@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

IF /I "%1" EQU "install" (
	GOTO :Install
) ELSE IF /I "%1" EQU "uninstall" (
	GOTO :Uninstall
) ELSE IF /I "%1" EQU "run" (
	GOTO :Run
) ELSE (
	GOTO :ShowUsage
)


:Install
REM -- Add firewall rule
CALL add-windows-firewall-rule.cmd > NUL

REM -- Get /var current location
SET ROOT_PATH=
FOR /f "eol=; tokens=* delims=" %%i IN ('cygpath.exe -m "!CD!\..\var"') DO (
	SET ROOT_PATH=%%i
)

REM -- Fixes /var permissions in fstab
SET FSTAB_FILE=..\etc\fstab
ECHO !ROOT_PATH! /var ntfs binary,posix=0,noacl 0 0 > !FSTAB_FILE!
ECHO none /cygdrive cygdrive binary,posix=0,noacl 0 0 >> !FSTAB_FILE!

REM -- The file /var/log/rsyncd.log is always zero-sized.
REM --   Moving it to /rsyncd.log fixes this problem, but it keeps creating /var/log/rsyncd.log. 
REM --   I didn't find a better solution to this.  (cygwin1.dll v1.7.18)
cygrunsrv.exe --install rsyncd --path "/bin/rsync.exe" --args "--log-file=/rsyncd.log --daemon --no-detach" --desc "rsync - a fast, versatile, remote (and local) file-copying tool" --disp "rsync server" --type auto
cygrunsrv.exe --start rsyncd
GOTO :End


:Uninstall
cygrunsrv.exe --remove rsyncd
GOTO :End


:Run
rsync.exe -vvvv --log-file=/rsyncd.log --daemon --no-detach
GOTO :End


:ShowUsage
ECHO usage: %0 [command]
ECHO.
ECHO where [command]:
ECHO      install       installs as Windows service
ECHO      run           starts a server instance
ECHO      uninstall     uninstalls Windows service
EXIT /B 1
GOTO :End


:End
ENDLOCAL