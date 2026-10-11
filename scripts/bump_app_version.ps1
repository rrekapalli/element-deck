# Bump Element Deck app version in pubspec.yaml before a deploy build.
#
# Flutter format: MAJOR.MINOR.PATCH+BUILD
#   Default:        keep MAJOR, MINOR += 1, PATCH = 0, BUILD += 1
#   -Major N:       set MAJOR = N (if changed: MINOR=0, PATCH=0), BUILD += 1
#   -BumpMajor:     MAJOR += 1, MINOR = 0, PATCH = 0, BUILD += 1
#
# Usage:
#   .\scripts\bump_app_version.ps1
#   .\scripts\bump_app_version.ps1 -Major 1
#   .\scripts\bump_app_version.ps1 -BumpMajor
#   .\scripts\bump_app_version.ps1 -DryRun
#   .\scripts\bump_app_version.ps1 -Print

param(
    # -1 means "not specified" (avoids Nullable binding quirks with powershell -File).
    [int]$Major = -1,
    [switch]$BumpMajor,
    [switch]$DryRun,
    [switch]$Print,
    [switch]$Help
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
if (-not $Root) { $Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path }
$Pubspec = Join-Path $Root "pubspec.yaml"

function Show-Help {
    @"
Usage: .\scripts\bump_app_version.ps1 [OPTIONS]

Update pubspec.yaml version for the next deploy/build.

OPTIONS:
  -Major N      Set major to N. When major changes: minor/patch reset to 0.
                When major is unchanged: normal minor bump.
  -BumpMajor    Increment major by 1; reset minor/patch to 0.
  -DryRun       Print the next version without writing pubspec.yaml
  -Print        Print the current version and exit
  -Help         Show this help

Default: preserve major, increment minor, reset patch, increment build.
"@
}

if ($Help) {
    Show-Help
    exit 0
}

if (-not (Test-Path $Pubspec)) {
    throw "Missing $Pubspec"
}

$raw = Get-Content -Path $Pubspec -Raw
$match = [regex]::Match($raw, '(?m)^version:\s*([0-9]+)\.([0-9]+)\.([0-9]+)(?:\+([0-9]+))?')
if (-not $match.Success) {
    throw "Cannot parse version: line in $Pubspec (expected MAJOR.MINOR.PATCH+BUILD)"
}

# Use cur* names — PowerShell variables are case-insensitive, so $major
# would overwrite the -Major script parameter.
$curMajor = [int]$match.Groups[1].Value
$curMinor = [int]$match.Groups[2].Value
$curPatch = [int]$match.Groups[3].Value
$curBuild = if ($match.Groups[4].Success -and $match.Groups[4].Value) { [int]$match.Groups[4].Value } else { 0 }
$current = "$curMajor.$curMinor.$curPatch+$curBuild"

if ($Print) {
    Write-Output $current
    exit 0
}

$newMajor = $curMajor
$newMinor = $curMinor
$newPatch = $curPatch
$newBuild = $curBuild + 1

if ($Major -ge 0) {
    $newMajor = $Major
    if ($newMajor -ne $curMajor) {
        $newMinor = 0
        $newPatch = 0
    } else {
        $newMinor = $curMinor + 1
        $newPatch = 0
    }
} elseif ($BumpMajor) {
    $newMajor = $curMajor + 1
    $newMinor = 0
    $newPatch = 0
} else {
    $newMinor = $curMinor + 1
    $newPatch = 0
}

$next = "$newMajor.$newMinor.$newPatch+$newBuild"

if ($DryRun) {
    Write-Output $next
    Write-Host "dry-run: would change $current → $next"
    exit 0
}

$updated = [regex]::Replace($raw, '(?m)^version:\s*.*$', "version: $next", 1)
# Normalize to LF so bash/git stay happy on Windows checkouts.
$normalized = ($updated -replace "`r`n", "`n" -replace "`r", "`n")
if (-not $normalized.EndsWith("`n")) { $normalized += "`n" }
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($Pubspec, $normalized, $utf8NoBom)

Write-Output $next
Write-Host "Bumped app version: $current → $next"
