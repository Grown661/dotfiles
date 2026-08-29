# PowerShell profile — aliases and helper functions.
# Location: $PROFILE (usually Documents\PowerShell\Microsoft.PowerShell_profile.ps1)

# --- Listing ---------------------------------------------------------------
function ll { Get-ChildItem -Force @args | Sort-Object -Property @{e={$_.PSIsContainer}; Descending=$true}, Name }

# --- Git shortcuts ---------------------------------------------------------
function gs { git status -sb @args }
function gl { git log --oneline --graph --decorate -20 @args }
function ga { git add @args }
function gcom { git commit @args }

# --- Navigation ------------------------------------------------------------
function mkcd {
    param([Parameter(Mandatory)][string]$Path)
    New-Item -ItemType Directory -Force -Path $Path | Out-Null
    Set-Location $Path
}
function .. { Set-Location .. }
function ... { Set-Location ..\.. }

# --- Utilities -------------------------------------------------------------
# Unix-style `which`: show where a command comes from
function which {
    param([Parameter(Mandatory)][string]$Name)
    Get-Command $Name -ErrorAction SilentlyContinue | Select-Object Name, CommandType, Source
}

# Quick local web server for the current directory (needs Python or Node)
function serve {
    param([int]$Port = 8000)
    if (Get-Command python -ErrorAction SilentlyContinue) { python -m http.server $Port }
    elseif (Get-Command npx -ErrorAction SilentlyContinue) { npx serve -l $Port . }
    else { Write-Warning "Neither python nor npx found." }
}

# --- Prompt ----------------------------------------------------------------
function prompt {
    $loc = Split-Path -Leaf (Get-Location)
    "PS $loc> "
}
