# Build a Play-signed Android App Bundle.
# Usage (repo root):
#   .\deployment\android\playstore\scripts\create-upload-keystore.ps1
#   .\deployment\android\playstore\scripts\build-release-aab.ps1
#   .\deployment\android\playstore\scripts\build-release-aab.ps1 -UploadToPlay

[CmdletBinding()]
param(
    [string] $EnvFile = "",
    [switch] $SkipPubGet,
    [switch] $UploadToPlay
)

$ErrorActionPreference = "Stop"
$PlaystoreDir = Split-Path -Parent $PSScriptRoot
$Root = (Resolve-Path (Join-Path $PlaystoreDir "..\..\..")).Path
Set-Location $Root

$props = Join-Path $Root "android\key.properties"
$keystoreDefault = Join-Path $Root "android\upload-keystore.jks"

if (-not (Test-Path $props)) {
    throw "Missing android/key.properties. Run .\deployment\android\playstore\scripts\create-upload-keystore.ps1 first."
}
$storeFile = $null
Get-Content $props | ForEach-Object {
    if ($_ -match '^\s*storeFile=(.+)$') { $storeFile = $Matches[1].Trim() }
}
$ks = if ($storeFile -and [IO.Path]::IsPathRooted($storeFile)) {
    $storeFile
} elseif ($storeFile) {
    Join-Path (Join-Path $Root "android") $storeFile
} else {
    $keystoreDefault
}
if (-not (Test-Path $ks)) {
    throw "Upload keystore not found: $ks"
}

$gs = Join-Path $Root "android\app\google-services.json"
if (-not (Test-Path $gs)) {
    Write-Host "[WARN] android/app/google-services.json is missing. Sign-in and Play receipt checks need a Firebase Android app before this build is useful on a device." -ForegroundColor Yellow
}

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    throw "flutter is not on PATH."
}

Write-Host "[INFO] Building release AAB (upload keystore)..." -ForegroundColor Cyan
if (-not $SkipPubGet) {
    flutter pub get
    if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed" }
}

$debugInfo = Join-Path $Root "build\debug-info"
New-Item -ItemType Directory -Force -Path $debugInfo | Out-Null
flutter build appbundle --release --obfuscate "--split-debug-info=$debugInfo"
if ($LASTEXITCODE -ne 0) { throw "flutter build appbundle failed" }

$aab = Join-Path $Root "build\app\outputs\bundle\release\app-release.aab"
if (-not (Test-Path $aab)) { throw "Expected AAB missing: $aab" }

$artifacts = Join-Path $PlaystoreDir "artifacts"
New-Item -ItemType Directory -Force -Path $artifacts | Out-Null
$ver = "release"
$pubspec = Join-Path $Root "pubspec.yaml"
if (Test-Path $pubspec) {
    $m = Select-String -Path $pubspec -Pattern '^\s*version:\s*(\S+)' | Select-Object -First 1
    if ($m) { $ver = ($m.Matches[0].Groups[1].Value -replace '\+', '-') }
}
$dest = Join-Path $artifacts "element-deck-$ver-release.aab"
Copy-Item $aab $dest -Force
Write-Host "[OK] AAB: $dest" -ForegroundColor Green

if ($UploadToPlay) {
    & (Join-Path $PSScriptRoot "upload-play-release.ps1") -Aab $dest
    if ($LASTEXITCODE -ne 0) { throw "upload-play-release failed" }
} else {
    Write-Host "Upload in Play Console (internal testing), or re-run with -UploadToPlay."
    Write-Host "See Docs/play-store.md"
}
