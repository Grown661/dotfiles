#!/usr/bin/env bash
# install.sh — symlink dotfiles into $HOME (Linux/macOS).
# Idempotent: existing correct symlinks are skipped, real files are backed up once.
#
# Usage:
#   ./install.sh            apply
#   ./install.sh --dry-run  show what would happen, change nothing
set -euo pipefail

DRY_RUN=0
[ "${1:-}" = "--dry-run" ] && DRY_RUN=1

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup"

# source (relative to repo) -> target (relative to $HOME)
LINKS=(
  "git/.gitconfig:.gitconfig"
  "bash/.bashrc:.bashrc.dotfiles"
  "bash/.aliases:.aliases"
)

log()  { printf '%s\n' "$*"; }
doit() {
  if [ "$DRY_RUN" -eq 1 ]; then log "[dry-run] $*"; else "$@"; fi
}

for entry in "${LINKS[@]}"; do
  src="$DOTFILES_DIR/${entry%%:*}"
  dst="$HOME/${entry##*:}"

  if [ ! -e "$src" ]; then
    log "skip:   $src missing in repo"
    continue
  fi

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    log "ok:     $dst already linked"
    continue
  fi

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    doit mkdir -p "$BACKUP_DIR"
    doit mv "$dst" "$BACKUP_DIR/$(basename "$dst").bak"
    log "backup: $dst -> $BACKUP_DIR/"
  fi

  doit ln -sf "$src" "$dst"
  log "link:   $dst -> $src"
done

log ""
log "Done. Add to your ~/.bashrc:  [ -f ~/.bashrc.dotfiles ] && . ~/.bashrc.dotfiles"
[ "$DRY_RUN" -eq 1 ] && log "(dry run — nothing was changed)"

exit 0
