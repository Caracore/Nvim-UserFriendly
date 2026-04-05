# Configuration des Terminaux — Nvim Self Setup

> Ce fichier explique comment configurer votre terminal pour tirer le meilleur
> parti de ce setup Neovim (transparence, polices Nerd Font, couleurs vraies).

---

## 🟣 Ghostty

**Fichier de config :** `~/.config/ghostty/config`

Ghostty est le terminal recommandé pour ce setup : rapide, natif, supporte
la transparence et le flou sans compositor externe sous Wayland/GNOME.

### Config minimale

```
background-opacity = 0.85
background-blur-radius = 20
font-family = JetBrainsMono Nerd Font
font-size = 13
window-decoration = client
window-padding-x = 12
window-padding-y = 8
cursor-style = block
cursor-style-blink = true
scrollback-limit = 10000
mouse-hide-while-typing = true
copy-on-select = false
```

### Raccourcis clavier

```
keybind = ctrl+t=new_window
keybind = ctrl+shift+c=copy_to_clipboard
keybind = ctrl+shift+v=paste_from_clipboard
keybind = ctrl+equal=increase_font_size:1
keybind = ctrl+minus=decrease_font_size:1
keybind = ctrl+zero=reset_font_size
keybind = f11=toggle_fullscreen
```

### Notes importantes

- **Transparence** : fonctionne nativement sur Wayland (GNOME, KDE).
  Sur X11, un compositor comme Picom est nécessaire.
- **Mode sombre** : suit automatiquement le thème système GNOME.
  Changez-le via *Paramètres → Apparence → Sombre*.
- **gtk-adwaita / gtk-prefer-dark-mode** : ces options n'existent pas
  dans Ghostty ≤ 1.3.x — ne pas les utiliser.
- **Nerd Font requise** pour les icônes de neo-tree, lualine, telescope.
  → Voir section [Installation Nerd Font](#installation-nerd-font) ci-dessous.

### Transparence dans Neovim

Activez dans `lua/config/user.lua` :
```lua
transparent = true,
```
Le setup force automatiquement `Normal { bg = NONE }` sur tous les groupes
concernés après le chargement du colorscheme.

---

## 🔵 Tabby

**Fichier de config :** `~/.config/tabby/config.yaml`
(ou via *Settings* dans l'interface graphique)

Tabby est un terminal multi-plateforme (Linux/macOS/Windows) basé sur
Electron. Parfait si vous voulez le même setup partout.

### Config minimale (`config.yaml`)

```yaml
terminal:
  font: JetBrainsMono Nerd Font
  fontSize: 13
  ligatures: true
  background: '#0d0d1a'   # adapté selon votre thème Neovim
  cursor: block
  cursorBlink: true
  scrollOnInput: true
  scrollback: 10000

appearance:
  opacity: 0.85            # transparence 0.0 → 1.0
  vibrancy: false          # flou (macOS uniquement)
  colorScheme:
    name: Custom
    background: '#0d0d1a'
    foreground: '#cdd6f4'

# Correspondance des couleurs par thème Neovim :
#   cyber  → background: '#0d0d1a'  foreground: '#cdd6f4'
#   forest → background: '#0d1410'  foreground: '#d4e6c3'
#   ember  → background: '#120a08'  foreground: '#f0d0b0'
#   void   → background: '#080808'  foreground: '#c8c8c8'
```

### Transparence dans Tabby

Tabby gère la transparence via le champ `opacity` dans `config.yaml`.
Sur Linux, le rendu dépend du compositor :
- **Wayland (GNOME/KDE)** → fonctionne nativement.
- **X11** → installez Picom :
  ```bash
  sudo apt install picom   # Debian/Ubuntu
  picom --experimental-backends &
  ```

### Notes importantes

- Tabby utilise Electron — plus gourmand en mémoire que Ghostty.
- Le flou de fond (`vibrancy`) n'est supporté que sur macOS.
- Sur Linux, la transparence est un simple fond semi-transparent sans flou.

---

## 🔤 Installation Nerd Font

Les icônes de neo-tree, lualine et telescope **nécessitent une Nerd Font**.
Sans elle, vous verrez des carrés □ à la place des icônes.

### JetBrainsMono Nerd Font (recommandée)

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
fc-cache -fv
rm JetBrainsMono.zip
```

### Autres polices compatibles

| Police | Ligatures | Commande |
|--------|-----------|---------|
| FiraCode Nerd Font | ✅ | `wget .../FiraCode.zip` |
| CascadiaCode NF | ✅ | `wget .../CascadiaCode.zip` |
| Hack Nerd Font | ❌ | `wget .../Hack.zip` |
| Meslo Nerd Font | ❌ | `wget .../Meslo.zip` |

Toutes les polices : <https://www.nerdfonts.com/font-downloads>

---

## ⚡ Comparatif rapide

| Terminal | Transparence | Flou | Ligatures | Perf | Plateforme |
|----------|-------------|------|-----------|------|------------|
| **Ghostty** | ✅ natif | ✅ natif | ✅ | 🚀 Excellent | Linux / macOS |
| **Tabby** | ✅ | ⚠️ macOS only | ✅ | 🐢 Moyen (Electron) | Linux / macOS / Windows |
| Kitty | ✅ natif | ✅ natif | ✅ | 🚀 Excellent | Linux / macOS |
| Alacritty | ✅ | ⚠️ compositor | ❌ | 🚀 Excellent | Linux / macOS / Windows |
| WezTerm | ✅ | ✅ | ✅ | ✅ Bon | Linux / macOS / Windows |
