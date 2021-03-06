import-module au

$releases = 'https://github.com/ephtracy/ephtracy.github.io/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $version = $download_page.links.href -match 'download/' -notmatch 'mac' -notmatch 'win' -notmatch 'plugin' -notmatch 'Aerialod' -notmatch 'SampleMap' | Select -First 1 | % { $_ -split '/' | select -Last 2 }
    $version = $version[0]

    @{
        Version = $version
        URL32   = "https://github.com/ephtracy/ephtracy.github.io/releases/download/$version/MagicaVoxel-Viewer.zip"
    }
}

update