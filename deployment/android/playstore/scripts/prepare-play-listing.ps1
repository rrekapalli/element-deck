# Resize screenshots listed in listing/screenshot-map.json.
$ErrorActionPreference = "Stop"
$PlaystoreDir = Split-Path -Parent $PSScriptRoot
Set-Location (Resolve-Path (Join-Path $PlaystoreDir "..\..\..")).Path
python (Join-Path $PSScriptRoot "prepare_play_listing.py")
if ($LASTEXITCODE -ne 0) { throw "prepare_play_listing.py failed" }
