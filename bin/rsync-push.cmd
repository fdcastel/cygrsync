@ECHO OFF

FOR /f "eol=; tokens=* delims=" %%i IN ('cygpath.exe -u "%1"') DO (
	SET CygwinFilename=%%i
)

rsync.exe --compress-level=9 --progress --human-readable "!CygwinFilename!" "%2::pub/"
