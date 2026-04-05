#!/usr/bin/env bash
# ============================================================
#  nvim-backup.sh
#  Copie ~/.config/nvim vers ~/Documents/Github/Nvim-self
# ============================================================

set -euo pipefail

SRC="$HOME/.config/nvim"
DEST="$HOME/Documents/Github/Nvim-self"
LOG_PREFIX="[nvim-backup]"

# --- Couleurs ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${GREEN}${LOG_PREFIX}${NC} $*"; }
warning() { echo -e "${YELLOW}${LOG_PREFIX}${NC} $*"; }
error()   { echo -e "${RED}${LOG_PREFIX} ERREUR :${NC} $*"; exit 1; }

# --- Détection du gestionnaire de paquets ---
detect_pkg_manager() {
  if   command -v apt    &>/dev/null; then echo "apt"
  elif command -v dnf    &>/dev/null; then echo "dnf"
  elif command -v pacman &>/dev/null; then echo "pacman"
  elif command -v zypper &>/dev/null; then echo "zypper"
  elif command -v brew   &>/dev/null; then echo "brew"
  else echo "unknown"
  fi
}

install_pkg() {
  local pkg="$1"
  local mgr
  mgr=$(detect_pkg_manager)
  info "Installation de '$pkg' via $mgr..."
  case "$mgr" in
    apt)    sudo apt-get install -y "$pkg" ;;
    dnf)    sudo dnf install -y "$pkg" ;;
    pacman) sudo pacman -S --noconfirm "$pkg" ;;
    zypper) sudo zypper install -y "$pkg" ;;
    brew)   brew install "$pkg" ;;
    *)      error "Gestionnaire de paquets non reconnu. Installez '$pkg' manuellement." ;;
  esac
}

ensure_dep() {
  local cmd="$1"
  local pkg="${2:-$1}"
  if ! command -v "$cmd" &>/dev/null; then
    warning "'$cmd' n'est pas installé."
    install_pkg "$pkg"
    command -v "$cmd" &>/dev/null || error "Impossible d'installer '$cmd'. Installez-le manuellement."
    info "'$cmd' installé avec succès."
  fi
}

# --- Vérification des dépendances ---
info "Vérification des dépendances..."
ensure_dep rsync rsync

# --- Vérification source ---
[ -d "$SRC" ] || error "Dossier source introuvable : $SRC"

# --- Création du dossier destination si besoin ---
mkdir -p "$DEST"

# --- Copie ---
info "Copie de $SRC → $DEST ..."
rsync -a --delete \
  --exclude='.git/' \
  --exclude='lazy-lock.json' \
  --exclude='nvim-backup.sh' \
  "$SRC/" "$DEST/"

info "✓ Copie terminée. Vous pouvez maintenant commiter via GitHub Desktop."

