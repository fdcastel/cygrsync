@ECHO OFF

rmdir /s/q .\dist
robocopy /s ..\dist .\dist

SET IMAGENAME=fdcastel/cygrsync
SET IMAGEVERSION=3.1.2

docker build -t %IMAGENAME%:%IMAGEVERSION% .

docker tag %IMAGENAME%:%IMAGEVERSION% %IMAGENAME%:latest

rmdir /s/q .\dist

if "%1" EQU "pub" (
    docker push %IMAGENAME%:%IMAGEVERSION%
    docker push %IMAGENAME%:latest
)
