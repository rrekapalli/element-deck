# Print Android signing certificate fingerprints for GCP / Entra.
# Usage:
#   .\scripts\print-signing-fingerprints.ps1 -Target debug
#   .\scripts\print-signing-fingerprints.ps1 -Target release
#   .\scripts\print-signing-fingerprints.ps1 -Sha1Hex "C9:01:8B:13:..."

[CmdletBinding()]
param(
    [ValidateSet("debug", "release")]
    [string] $Target = "release",

    # Convert a colon/hex SHA-1 to MSAL Base64 (Play Console paste helper).
    [string] $Sha1Hex = "",

    # Suppress human-readable banners; still emit SHA1=/SHA256=/MSAL_BASE64= lines.
    [switch] $Quiet
)

$ErrorActionPreference = "Stop"
$PlaystoreDir = Split-Path -Parent $PSScriptRoot
$Root = (Resolve-Path (Join-Path $PlaystoreDir "..\..\..")).Path

function Convert-Sha1HexToMsalBase64 {
    param([Parameter(Mandatory)][string] $Hex)
    $clean = ($Hex -replace "[:\s]", "").ToUpperInvariant()
    if ($clean.Length -ne 40 -or $clean -notmatch '^[0-9A-F]+$') {
        throw "SHA-1 hex must be 40 hex chars (colons optional). Got length $($clean.Length)."
    }
    $bytes = for ($i = 0; $i -lt 40; $i += 2) {
        [Convert]::ToByte($clean.Substring($i, 2), 16)
    }
    return [Convert]::ToBase64String([byte[]]$bytes)
}

function Get-KeytoolFingerprints {
    param(
        [Parameter(Mandatory)][string] $Keystore,
        [Parameter(Mandatory)][string] $Alias,
        [Parameter(Mandatory)][string] $StorePassword
    )
    if (-not (Get-Command keytool -ErrorAction SilentlyContinue)) {
        throw "keytool not found on PATH. Install a JDK and ensure keytool is available."
    }
    if (-not (Test-Path $Keystore)) {
        throw "Keystore not found: $Keystore"
    }

    $raw = & keytool -list -v -keystore $Keystore -alias $Alias -storepass $StorePassword 2>&1 | Out-String
    if ($LASTEXITCODE -ne 0 -and $raw -notmatch "SHA1:") {
        throw "keytool failed:`n$raw"
    }

    $sha1 = $null
    $sha256 = $null
    if ($raw -match "SHA1:\s*([0-9A-Fa-f:]+)") { $sha1 = $Matches[1].Trim() }
    if ($raw -match "SHA256:\s*([0-9A-Fa-f:]+)") { $sha256 = $Matches[1].Trim() }
    if (-not $sha1) { throw "Could not parse SHA1 from keytool output." }

    $msal = Convert-Sha1HexToMsalBase64 -Hex $sha1
    [PSCustomObject]@{
        Keystore = $Keystore
        Alias    = $Alias
        SHA1     = $sha1
        SHA256   = $sha256
        MsalBase64 = $msal
        Raw      = $raw
    }
}

if ($Sha1Hex) {
    $b64 = Convert-Sha1HexToMsalBase64 -Hex $Sha1Hex
    if (-not $Quiet) {
        Write-Host "SHA-1 (input): $Sha1Hex"
        Write-Host "MSAL Base64:   $b64"
    }
    Write-Output "MSAL_BASE64=$b64"
    exit 0
}

if ($Target -eq "debug") {
    $keystore = Join-Path $env:USERPROFILE ".android\debug.keystore"
    $alias = "androiddebugkey"
    $pass = "android"
} else {
    $propsPath = Join-Path $Root "android\key.properties"
    if (-not (Test-Path $propsPath)) {
        throw "android/key.properties missing. Run create-upload-keystore.ps1 first."
    }
    $map = @{}
    Get-Content $propsPath | ForEach-Object {
        if ($_ -match '^\s*#' -or $_ -notmatch '=') { return }
        $k, $v = $_ -split "=", 2
        $map[$k.Trim()] = $v.Trim()
    }
    $storeRel = $map["storeFile"]
    if (-not $storeRel) { throw "storeFile missing in key.properties" }
    $keystore = if ([IO.Path]::IsPathRooted($storeRel)) {
        $storeRel
    } else {
        Join-Path (Join-Path $Root "android") $storeRel
    }
    $alias = if ($map["keyAlias"]) { $map["keyAlias"] } else { "upload" }
    $pass = $map["storePassword"]
    if (-not $pass -or $pass -eq "CHANGE_ME") {
        throw "storePassword missing or still CHANGE_ME in key.properties"
    }
}

$fp = Get-KeytoolFingerprints -Keystore $keystore -Alias $alias -StorePassword $pass

if (-not $Quiet) {
    Write-Host ""
    Write-Host "=== Android signing fingerprints ($Target) ===" -ForegroundColor Cyan
    Write-Host "Package:     com.vislesha.element_deck"
    Write-Host "Keystore:    $($fp.Keystore)"
    Write-Host "Alias:       $($fp.Alias)"
    Write-Host "SHA-1:       $($fp.SHA1)"
    Write-Host "SHA-256:     $($fp.SHA256)"
    Write-Host "MSAL Base64: $($fp.MsalBase64)"
    Write-Host ""
    Write-Host "Firebase / GCP: Android OAuth client, package com.vislesha.element_deck, paste SHA-1 and SHA-256."
    Write-Host "After Play App Signing enrolls, add that certificate's SHA-1 in Firebase too."
    Write-Host "Docs: Docs/play-store.md"
}

# Emit machine-readable lines for other scripts
Write-Output "SHA1=$($fp.SHA1)"
Write-Output "SHA256=$($fp.SHA256)"
Write-Output "MSAL_BASE64=$($fp.MsalBase64)"
