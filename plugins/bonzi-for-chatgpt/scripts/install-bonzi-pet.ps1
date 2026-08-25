param([switch]$Force)
$ErrorActionPreference = "Stop"

$PluginDir = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$SourceDir = Join-Path $PluginDir "assets/pet/bonzi"
$CodexRoot = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$TargetDir = Join-Path $CodexRoot "pets/bonzi"
$ExpectedSprite = "6171db4dffa833c4ed6d1cde4828753f92a4209498431502b0860fc5dfbcc145"
$ExpectedPet = "5aab8bddc9e0cd01042b6667843abe1a38bb049b94c9e1bbc081bc57bd5e9a0b"

function Assert-Hash([string]$Path, [string]$Expected) {
  $Actual = (Get-FileHash -Algorithm SHA256 -Path $Path).Hash.ToLowerInvariant()
  if ($Actual -ne $Expected) { throw "Checksum mismatch: $Path" }
}

$SourceSprite = Join-Path $SourceDir "spritesheet.webp"
$SourcePet = Join-Path $SourceDir "pet.json"
Assert-Hash $SourceSprite $ExpectedSprite
Assert-Hash $SourcePet $ExpectedPet

$TargetSprite = Join-Path $TargetDir "spritesheet.webp"
$TargetPet = Join-Path $TargetDir "pet.json"
if ((Test-Path $TargetSprite) -and (Test-Path $TargetPet)) {
  $SameSprite = (Get-FileHash $TargetSprite).Hash -eq (Get-FileHash $SourceSprite).Hash
  $SamePet = (Get-FileHash $TargetPet).Hash -eq (Get-FileHash $SourcePet).Hash
  if ($SameSprite -and $SamePet) {
    Write-Output "Bonzi is already installed and verified at $TargetDir"
    exit 0
  }
}

if (((Test-Path $TargetSprite) -or (Test-Path $TargetPet)) -and -not $Force) {
  throw "A different Bonzi package exists at $TargetDir. Re-run with -Force only after approving replacement."
}

New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
$TempSprite = Join-Path $TargetDir ".spritesheet.webp.$PID.tmp"
$TempPet = Join-Path $TargetDir ".pet.json.$PID.tmp"
try {
  Copy-Item $SourceSprite $TempSprite -Force
  Copy-Item $SourcePet $TempPet -Force
  Assert-Hash $TempSprite $ExpectedSprite
  Assert-Hash $TempPet $ExpectedPet
  Move-Item $TempSprite $TargetSprite -Force
  Move-Item $TempPet $TargetPet -Force
} finally {
  Remove-Item $TempSprite, $TempPet -Force -ErrorAction SilentlyContinue
}

Assert-Hash $TargetSprite $ExpectedSprite
Assert-Hash $TargetPet $ExpectedPet
Write-Output "Installed and verified Bonzi at $TargetDir"
