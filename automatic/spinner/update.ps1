import-module au

$releases = 'https://github.com/ticketmaster/spinner/releases'

function global:au_SearchReplace {
    @{ }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    # spinner_windows_amd64-v1.0.8.zip
    $re  = "spinner_windows_amd64-v.+\.zip"
    $url = $download_page.links | ? href -match $re | select -First 2 -expand href

    $url -match "-v(.+).zip"
    $version = $Matches[1]
    $url64 = 'https://github.com' + $url

    @{
        URL64 = $url64;
        Version = $version
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}
