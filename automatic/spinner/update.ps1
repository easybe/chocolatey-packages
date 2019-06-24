import-module au

$releases = 'https://github.com/ticketmaster/spinner/releases'

function global:au_SearchReplace {
    @{
        'tools\chocolateyinstall.ps1' = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    # spinner_windows_amd64-v1.0.8.zip
    $re  = "spinner_windows_amd64-v.+\.zip"
    $url = $download_page.links | ? href -match $re | select -First 2 -expand href

    $url -match "-v(.+).zip"
    $version = $Matches[1]
    $url64 = 'https://github.com' + $url

    $latest = @{ URL64 = $url64; Version = $version }
    return $latest
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor 64
}
