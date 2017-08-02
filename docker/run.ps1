$env:RSYNCD_CONF | Set-Content \cygrsync\etc\rsyncd.conf
\cygrsync\bin\rsync.exe --daemon --no-detach
