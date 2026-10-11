# Build the Element Deck PWA on Windows, then deploy from WSL.
#
# Usage (repo root, PowerShell):
#   .\deploy.ps1
#   .\deploy.ps1 -Major 1
#   .\deploy.ps1 -SkipBuild
#   .\deploy.ps1 -Recreate

param(
    [int]$Major = -1,
    [switch]$BumpMajor,
    [switch]$SkipBuild,
    [switch]$SkipVersionBump,
    [switch]$Recreate,
    [switch]$Help
)

$ErrorActionPreference = "Stop"
$Root = $PSScriptRoot

function Show-Help {
    @"
Usage: .\deploy.ps1 [OPTIONS]

Build the Flutter PWA with Windows Flutter, then deploy to Proxmox LXC 7018 via WSL.

OPTIONS:
  -Major N          Set major version for this build
  -BumpMajor        Increment major by 1
  -SkipBuild        Deploy using existing deployment/artifacts/pwa-dist.zip
  -SkipVersionBump  Do not change pubspec.yaml version
  -Recreate         Destroy and recreate the LXC before deploy
  -Help             Show this help
"@
}

if ($Help) {
    Show-Help
    exit 0
}

function Get-WslRepoRoot {
    $unixPath = ($Root -replace '\\', '/')
    if ($unixPath -match '^([A-Za-z]):') {
        $drive = $Matches[1].ToLower()
        return "/mnt/$drive$($unixPath.Substring(2))"
    }
    return (wsl wslpath -a $Root).Trim()
}

function Invoke-WslBash {
    param([Parameter(Mandatory = $true)][string]$Command)
    & wsl -e bash -lc $Command
    if ($LASTEXITCODE -ne 0) {
        throw "WSL command failed (exit $LASTEXITCODE): $Command"
    }
}

$wslRoot = Get-WslRepoRoot
$deployArgs = @("./deploy.sh", "--skip-build", "--skip-version-bump")
if ($Recreate) { $deployArgs += "--recreate" }
$deployCmd = ($deployArgs -join " ")

if (-not $SkipBuild) {
    if (-not $SkipVersionBump) {
        $bumpScript = Join-Path $Root "scripts\bump_app_version.ps1"
        if (-not (Test-Path $bumpScript)) {
            throw "Missing version bump script: $bumpScript"
        }
        $bumpArgs = @{}
        if ($Major -ge 0) {
            $bumpArgs['Major'] = $Major
        } elseif ($BumpMajor) {
            $bumpArgs['BumpMajor'] = $true
        }
        $appVersion = & $bumpScript @bumpArgs
        Write-Host "[SUCCESS] App version for this build: $appVersion"
    } else {
        Write-Host "[INFO] Skipping version bump"
    }

    Write-Host "[INFO] Building PWA via Windows Flutter..."
    $pwaScript = Join-Path $Root "scripts\build_pwa_artifact.ps1"
    if (-not (Test-Path $pwaScript)) {
        throw "Missing $pwaScript"
    }
    & $pwaScript
    if ($LASTEXITCODE -ne 0) { throw "PWA build failed" }
}

Write-Host "[INFO] Deploying via WSL: $deployCmd"
Invoke-WslBash -Command "cd '$wslRoot'; bash $deployCmd"
