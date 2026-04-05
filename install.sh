#!/usr/bin/env bash
# ============================================================
#  install.sh — Installation du Neovim Setup Personnel
#  Usage : bash install.sh
# ============================================================

set -euo pipefail

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; CYAN='\033[0;36m'; NC='\033[0m'
info()    { echo -e "${GREEN}[nvim-install]${NC} $*"; }
warn()    { echo -e "${YELLOW}[nvim-install]${NC} $*"; }
error()   { echo -e "${RED}[nvim-install] ERREUR :${NC} $*"; exit 1; }
title()   { echo -e "\n${CYAN}══════════════════════════════════════${NC}"; echo -e "${CYAN}  $*${NC}"; echo -e "${CYAN}══════════════════════════════════════${NC}"; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"

# ── Détection gestionnaire de paquets ────────────────────────────────────────
detect_pkg_manager() {
  if   command -v apt    &>/dev/null; then echo "apt"
  elif command -v dnf    &>/dev/null; then echo "dnf"
  elif command -v pacman &>/dev/null; then echo "pacman"
  elif command -v zypper &>/dev/null; then echo "zypper"
  elif command -v brew   &>/dev/null; then echo "brew"
  else echo "unknown"; fi
}

install_pkg() {
  local pkg="$1" mgr
  mgr=$(detect_pkg_manager)
  case "$mgr" in
    apt)    sudo apt-get install -y "$pkg" ;;
    dnf)    sudo dnf install -y "$pkg" ;;
    pacman) sudo pacman -S --noconfirm "$pkg" ;;
    zypper) sudo zypper install -y "$pkg" ;;
    brew)   brew install "$pkg" ;;
    *)      warn "Gestionnaire inconnu — installez '$pkg' manuellement." ;;
  esac
}

check_or_install() {
  local cmd="$1" pkg="${2:-$1}"
  if ! command -v "$cmd" &>/dev/null; then
    warn "'$cmd' manquant — tentative d'installation..."
    install_pkg "$pkg"
  else
    info "✓ $cmd $(command -v "$cmd")"
  fi
}

# ── 1. Vérification Neovim ────────────────────────────────────────────────────
title "Vérification de Neovim"

if ! command -v nvim &>/dev/null; then
  error "Neovim n'est pas installé.\nInstallez-le : https://github.com/neovim/neovim/releases\nOu via votre gestionnaire : sudo apt install neovim (Ubuntu PPA recommandé pour avoir >= 0.11)"
fi

NVIM_VER=$(nvim --version | head -1 | grep -oP '\d+\.\d+' | head -1)
NVIM_MAJOR=$(echo "$NVIM_VER" | cut -d. -f1)
NVIM_MINOR=$(echo "$NVIM_VER" | cut -d. -f2)

if [ "$NVIM_MAJOR" -lt 1 ] && [ "$NVIM_MINOR" -lt 11 ]; then
  error "Neovim $NVIM_VER détecté. Version >= 0.11 requise.\nMettez à jour : https://github.com/neovim/neovim/releases"
fi
info "✓ Neovim $NVIM_VER"

# ── 2. Dépendances système ────────────────────────────────────────────────────
title "Vérification des dépendances"

check_or_install git
check_or_install rg  ripgrep
check_or_install node nodejs
check_or_install npm
check_or_install gcc
check_or_install unzip

# fd : s'appelle fdfind sur Debian/Ubuntu
if ! command -v fd &>/dev/null; then
  if command -v fdfind &>/dev/null; then
    info "✓ fd (via fdfind)"
    mkdir -p "$HOME/.local/bin"
    ln -sf "$(which fdfind)" "$HOME/.local/bin/fd"
    info "  Lien créé : ~/.local/bin/fd → fdfind"
  else
    warn "fd non trouvé — tentative d'installation..."
    install_pkg fd-find 2>/dev/null || install_pkg fd 2>/dev/null || warn "Installez fd manuellement : https://github.com/sharkdp/fd"
  fi
else
  info "✓ fd"
fi

# ── 3. Sauvegarde de l'ancienne config ────────────────────────────────────────
title "Sauvegarde de la configuration existante"

if [ -d "$NVIM_CONFIG" ]; then
  BACKUP="$HOME/.config/nvim.bak.$(date +%Y%m%d_%H%M%S)"
  warn "Configuration existante détectée → sauvegarde dans $BACKUP"
  mv "$NVIM_CONFIG" "$BACKUP"
  info "Sauvegarde effectuée."
else
  info "Aucune configuration existante."
fi

# ── 4. Installation du setup ─────────────────────────────────────────────────
title "Installation du setup Neovim"

# Si le script est dans le dossier cloné, on copie directement
if [ -f "$SCRIPT_DIR/init.lua" ]; then
  info "Copie depuis $SCRIPT_DIR..."
  cp -r "$SCRIPT_DIR" "$NVIM_CONFIG"
  # Supprimer le script lui-même de la destination (inutile dans ~/.config/nvim)
  rm -f "$NVIM_CONFIG/install.sh"
else
  # Sinon l'utilisateur clone manuellement
  error "Lancez ce script depuis le dossier cloné qui contient init.lua."
fi

# ── 5. Nerd Font (optionnel) ──────────────────────────────────────────────────
title "Police Nerd Font (optionnel)"

echo -e "${YELLOW}Voulez-vous installer JetBrainsMono Nerd Font ? (recommandé pour les icônes)${NC}"
read -r -p "  [o/N] : " install_font
install_font="${install_font:-N}"

if [[ "$install_font" =~ ^[oOyY]$ ]]; then
  FONT_DIR="$HOME/.local/share/fonts"
  mkdir -p "$FONT_DIR"
  info "Téléchargement de JetBrainsMono Nerd Font..."
  FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
  if command -v wget &>/dev/null; then
    wget -q --show-progress -O /tmp/JetBrainsMono.zip "$FONT_URL"
  elif command -v curl &>/dev/null; then
    curl -L --progress-bar -o /tmp/JetBrainsMono.zip "$FONT_URL"
  else
    warn "wget/curl non trouvé. Téléchargez manuellement : $FONT_URL"
  fi
  if [ -f /tmp/JetBrainsMono.zip ]; then
    unzip -q /tmp/JetBrainsMono.zip -d "$FONT_DIR/JetBrainsMono"
    rm /tmp/JetBrainsMono.zip
    fc-cache -fv &>/dev/null
    info "✓ JetBrainsMono Nerd Font installée dans $FONT_DIR"
    info "  → Sélectionnez 'JetBrainsMono Nerd Font' dans les préférences de votre terminal."
  fi
else
  info "Police ignorée. Consultez README.md pour l'installer manuellement."
fi

# ── 6. Premier lancement ──────────────────────────────────────────────────────
title "Installation terminée !"

echo ""
echo -e "${GREEN}✓ Config installée dans ~/.config/nvim/${NC}"
echo ""
echo -e "  Prochaine étape : lancez ${CYAN}nvim${NC}"
echo -e "  → lazy.nvim va installer tous les plugins automatiquement (~2 min)"
echo -e "  → Mason va installer tous les serveurs LSP (~3 min selon connexion)"
echo -e "  → Attendez que les barres de progression disparaissent avant d'utiliser"
echo ""
echo -e "  ${YELLOW}Personnalisation :${NC} éditez ${CYAN}~/.config/nvim/lua/config/user.lua${NC}"
echo -e "  ${YELLOW}Guide complet    :${NC} ouvrez ${CYAN}~/.config/nvim/lua/config/guide.md${NC}"
echo ""
