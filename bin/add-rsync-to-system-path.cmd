@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET RSYNC_BIN_FOLDER=%~dp0

PUSHD !ProgramFiles!
SET IsRsyncInPath=T
WHERE rsync.exe > NUL 2>&1
IF ERRORLEVEL 1 SET IsRsyncInPath=F
POPD

IF !IsRsyncInPath!==F SETX /M PATH "%PATH%;%RSYNC_BIN_FOLDER%"
IF !IsRsyncInPath!==F SET PATH=%PATH%;%RSYNC_BIN_FOLDER%

ENDLOCAL