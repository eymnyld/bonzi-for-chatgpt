param([switch]$Yes)
$ErrorActionPreference = "Stop"
if (-not $Yes) { throw "Run with -Yes to confirm removal." }

$CodexRoot = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$TargetDir = Join-Path $CodexRoot "pets/bonzi"
if (-not (Test-Path $TargetDir)) {
  Write-Output "Bonzi is not installed at $TargetDir"
  exit 0
}

Remove-Item (Join-Path $TargetDir "pet.json"), (Join-Path $TargetDir "spritesheet.webp") -Force -ErrorAction SilentlyContinue
if (@(Get-ChildItem -Force $TargetDir).Count -eq 0) {
  Remove-Item $TargetDir -Force
  Write-Output "Removed Bonzi from $TargetDir"
} else {
  Write-Output "Removed Bonzi pet files; preserved unexpected files in $TargetDir"
}
