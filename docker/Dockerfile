FROM mcr.microsoft.com/windows/servercore:2004

COPY dist \cygrsync
COPY run.ps1 \cygrsync

EXPOSE 873

VOLUME ["C:/rsync-root"]

# Start Rsync daemon
CMD powershell -c /cygrsync/run.ps1
