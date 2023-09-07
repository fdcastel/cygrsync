Cygrsync project
================

Cygrsync is a minimal set of files needed to run rsync in Windows. It's a repackaging of current Cygwin rsync without the entire cygwin environment.

It supports both client and server (via rsyncd) and also supports rsync over ssh (uses `$USERPROFILE/.ssh` folder).



## How to update binaries (x64 only)

- Open a cmd.exe session with administrative privileges

```
:: Dowload Cygwin setup
powershell -Command (new-object System.Net.WebClient).DownloadFile('https://cygwin.com/setup-x86_64.exe','%TEMP%\setup-cygwin-x86_64.exe')

:: Install Cygwin, SSH and RSync (about 150Mb in C:)
%TEMP%\setup-cygwin-x86_64.exe -q -n -N -d -R c:\cygwin64 -s https://mirrors.kernel.org/sourceware/cygwin -l %TEMP% -P cygrunsrv,openssh,opensshd,rsync
```

Copy new files from `C:\cygwin`. You may need to use Dependency Walker to check what .DLLs are needed.



## How to collaborate? Contact?

Pull requests. fdcastel@gmail.com.