@ECHO OFF

rmdir /s/q .\dist
robocopy /s ..\dist .\dist

docker build -t fdcastel/cygrsync:latest .

rmdir /s/q .\dist

