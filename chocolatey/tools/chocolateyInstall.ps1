$packageName = 'cygrsync'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Remove pasta "cygrsync-master" de instalações antigas (se houver)
$oldMaster = Join-Path $toolsDir '.\cygrsync-master'
Remove-Item $oldMaster -Force -Recurse -ErrorAction SilentlyContinue
