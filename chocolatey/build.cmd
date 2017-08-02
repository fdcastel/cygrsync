@ECHO OFF
PUSHD %~dp0
DEL *.nupkg 2> NUL
CALL choco pack
POPD