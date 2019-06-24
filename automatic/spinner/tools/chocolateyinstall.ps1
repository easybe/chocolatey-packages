$ErrorActionPreference = 'Stop'

$packageName = 'spinner'
$url64       = 'https://github.com/ticketmaster/spinner/releases/download/v1.0.8/spinner_windows_amd64-v1.0.8.zip'
$checksum64  = '0984a712ab67958bc593cf15272d41ce7661c48b282d06788a75ab9d56b146fc'

$packageArgs = @{
  packageName    = $packageName
  url64Bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  unzipLocation  = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
