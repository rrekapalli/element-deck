# Build the Element Deck Flutter web zip for the LXC deploy.
# Output: deployment/artifacts/pwa-dist.zip

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
if (-not $Root) { $Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path }

$Artifacts = Join-Path $Root "deployment\artifacts"
$BuildDir = Join-Path $Root "build\web"
$ZipPath = Join-Path $Artifacts "pwa-dist.zip"
$SwScript = Join-Path $Root "scripts\generate_offline_sw.py"

Write-Host "[INFO] Building Element Deck PWA (Flutter web)..."

Push-Location $Root
try {
    flutter pub get
    if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed" }

    # CanvasKit ships inside the build so a phone does not need gstatic.
    flutter build web --release --no-wasm-dry-run --no-web-resources-cdn
    if ($LASTEXITCODE -ne 0) { throw "flutter build web failed" }

    if (-not (Test-Path (Join-Path $BuildDir "index.html"))) {
        throw "Build dir missing index.html: $BuildDir"
    }

    if (Test-Path $SwScript) {
        Write-Host "[INFO] Generating offline/update service worker (content-hash cache)..."
        $python = $null
        foreach ($candidate in @("python", "python3", "py")) {
            if (Get-Command $candidate -ErrorAction SilentlyContinue) {
                $python = $candidate
                break
            }
        }
        if (-not $python) {
            throw "Python not found — required for scripts/generate_offline_sw.py (PWA updates)"
        }
        if ($python -eq "py") {
            & $python -3 $SwScript $BuildDir
        } else {
            & $python $SwScript $BuildDir
        }
        if ($LASTEXITCODE -ne 0) { throw "generate_offline_sw.py failed" }
    } else {
        throw "Missing generate_offline_sw.py — Flutter stub SW will unregister (A2HS updates break)"
    }

    New-Item -ItemType Directory -Force -Path $Artifacts | Out-Null
    if (Test-Path $ZipPath) { Remove-Item $ZipPath -Force }
    Compress-Archive -Path (Join-Path $BuildDir "*") -DestinationPath $ZipPath -Force
    Write-Host "[SUCCESS] PWA zip: $ZipPath"
} finally {
    Pop-Location
}
