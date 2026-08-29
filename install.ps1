# install.ps1 — install dotfiles on Windows.
# Copies the PowerShell profile and git config into place (backs up existing files).
#
# Usage:
#   .\install.ps1            apply
#   .\install.ps1 -DryRun    show what would happen, change nothing
param([switch]$DryRun)

$RepoDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$BackupDir = Join-Path $HOME ".dotfiles-backup"

$Mappings = @(
    @{ Src = Join-Path $RepoDir "git\.gitconfig";                          Dst = Join-Path $HOME ".gitconfig" }
    @{ Src = Join-Path $RepoDir "powershell\Microsoft.PowerShell_profile.ps1"; Dst = $PROFILE }
)

foreach ($m in $Mappings) {
    if (-not (Test-Path $m.Src)) { Write-Host "skip:   $($m.Src) missing"; continue }

    if ((Test-Path $m.Dst) -and ((Get-FileHash $m.Src).Hash -eq (Get-FileHash $m.Dst).Hash)) {
        Write-Host "ok:     $($m.Dst) already up to date"
        continue
    }

    if (Test-Path $m.Dst) {
        if ($DryRun) { Write-Host "[dry-run] backup $($m.Dst) -> $BackupDir" }
        else {
            New-Item -ItemType Directory -Force -Path $BackupDir | Out-Null
            Copy-Item $m.Dst (Join-Path $BackupDir ((Split-Path -Leaf $m.Dst) + ".bak")) -Force
            Write-Host "backup: $($m.Dst) -> $BackupDir"
        }
    }

    if ($DryRun) { Write-Host "[dry-run] copy $($m.Src) -> $($m.Dst)" }
    else {
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $m.Dst) | Out-Null
        Copy-Item $m.Src $m.Dst -Force
        Write-Host "copy:   $($m.Src) -> $($m.Dst)"
    }
}

Write-Host ""
if ($DryRun) { Write-Host "(dry run - nothing was changed)" }
else { Write-Host "Done. Restart your shell to load the new profile." }
