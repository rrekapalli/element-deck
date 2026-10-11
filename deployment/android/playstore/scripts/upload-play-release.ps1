# Upload AAB + listing to Google Play (Android Publisher API).
# Usage:
#   .\upload-play-release.ps1
#   .\upload-play-release.ps1 -ListingOnly
#   .\upload-play-release.ps1 -Aab path\to.aab -Track internal
[CmdletBinding()]
param(
    [string] $Aab = "",
    [string] $Track = "",
    [switch] $ListingOnly,
    [switch] $SkipListing,
    [switch] $Draft,
    [switch] $DryRun,
    [string] $JsonKey = ""
)

$ErrorActionPreference = "Stop"
$PlaystoreDir = Split-Path -Parent $PSScriptRoot
Set-Location (Resolve-Path (Join-Path $PlaystoreDir "..\..\..")).Path

$py = Join-Path $PSScriptRoot "upload_play_release.py"
$argv = @()
if ($Aab) { $argv += @("--aab", $Aab) }
if ($Track) { $argv += @("--track", $Track) }
if ($ListingOnly) { $argv += "--listing-only" }
if ($SkipListing) { $argv += "--skip-listing" }
if ($Draft) { $argv += "--draft" }
if ($DryRun) { $argv += "--dry-run" }
if ($JsonKey) { $argv += @("--json-key", $JsonKey) }

python $py @argv
if ($LASTEXITCODE -ne 0) { throw "upload_play_release.py failed" }
