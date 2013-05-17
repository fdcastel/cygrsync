@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

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

ENDLOCAL