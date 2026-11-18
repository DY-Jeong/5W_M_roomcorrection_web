# Rebuilds the single-file measurement page from ..\roomcorr and copies it here as index.html.
$ErrorActionPreference = 'Stop'
$roomcorr = Join-Path $PSScriptRoot '..\roomcorr'
Push-Location (Join-Path $roomcorr 'test')
try {
    node test-core.js vectors.json
    if ($LASTEXITCODE -ne 0) { throw 'roomcorr tests failed' }
} finally { Pop-Location }
node (Join-Path $roomcorr 'build-html.js') (Join-Path $PSScriptRoot 'index.html')
if ($LASTEXITCODE -ne 0) { throw 'build-html failed' }
