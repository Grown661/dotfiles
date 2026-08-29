# dotfiles

Meine Shell-, Git- und Editor-Konfiguration — versioniert, dokumentiert und mit
Install-Skripten für Windows **und** Linux/macOS.

## Problem

Ein neuer Rechner (oder eine frische VM) kostet ohne Dotfiles eine Stunde
Handarbeit: Git-Aliase, Shell-Funktionen, Editor-Defaults. Dieses Repo macht
daraus einen Befehl — idempotent und mit Backup der bestehenden Dateien.

## Features

- **Git**: Aliase (`st`, `lg`, `amend`, `wip`), `pull.rebase`, `main` als Default-Branch, `zdiff3`-Konflikte
- **PowerShell**: `ll`, `gs`, `mkcd`, `which`, `serve`, kompakter Prompt
- **Bash**: Aliase + `extract`-Funktion für beliebige Archive, bessere History
- **VS Code**: aufgeräumte Defaults (format on save, keine Minimap, Telemetrie aus)
- **Installer**: `install.sh` (symlinks, `--dry-run`) und `install.ps1` (Kopien mit Backup, `-DryRun`)

## Stack

Bash, PowerShell 5.1+, Git — keine Abhängigkeiten.

## Setup & Start

```bash
# Linux / macOS
git clone <repo-url> ~/.dotfiles
cd ~/.dotfiles
./install.sh --dry-run   # erst ansehen
./install.sh             # dann anwenden
```

```powershell
# Windows
git clone <repo-url> $HOME\.dotfiles
cd $HOME\.dotfiles
.\install.ps1 -DryRun    # erst ansehen
.\install.ps1            # dann anwenden
```

Danach in `~/.gitconfig` Name und E-Mail eintragen.

## Was landet wo

| Quelle (Repo)                                   | Ziel                          | Methode (Linux) | Methode (Windows) |
|--------------------------------------------------|-------------------------------|-----------------|-------------------|
| `git/.gitconfig`                                 | `~/.gitconfig`                | Symlink         | Kopie mit Backup  |
| `bash/.bashrc`                                   | `~/.bashrc.dotfiles`          | Symlink         | —                 |
| `bash/.aliases`                                  | `~/.aliases`                  | Symlink         | —                 |
| `powershell/Microsoft.PowerShell_profile.ps1`    | `$PROFILE`                    | —               | Kopie mit Backup  |
| `vscode/settings.json`                           | manuell (VS Code Settings)    | manuell         | manuell           |

Bestehende echte Dateien werden **einmalig** nach `~/.dotfiles-backup/` gesichert.
Getestet auf Windows 11 und Linux.

## Screenshot

_(Screenshot folgt)_
