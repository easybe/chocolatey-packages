$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    PackageName = 'spinner'
    FileFullPath64 = Get-Item $toolsDir\*.zip
    Destination = $toolsDir
}

Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0

Move-Item -Path "$toolsPath\spinner_v*.exe" -Destination "$toolsPath\spinner.exe" -Force
