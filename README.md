# Neovim Setup Personnel

> Configuration Neovim moderne, modulaire et prête à l'emploi.
> Inspirée de LazyVim, entièrement personnalisable via un seul fichier.

---

## ✨ Aperçu

- 🎨 4 thèmes custom + accès à tokyonight, catppuccin, rose-pine, gruvbox…
- 🌳 Explorateur de fichiers (Neo-tree) à droite
- 🔭 Recherche universelle (Telescope)
- 🧠 LSP sur 14 langages (Python, JS/TS, Go, Rust, C, Lua…)
- ⚡ Navigation ultra-rapide (Flash)
- ⚑ Marks visuels, Surround, Autopairs, Commentaires intelligents
- 💬 Which-key : appuyez sur `Espace` pour voir toutes les commandes
- 🖥️ Terminal intégré (`<leader>ft`)
- 🤖 Nvim+ : Copilot / Supermaven / Prettier en option

---

## 📋 Prérequis

| Outil | Version min | Rôle |
|-------|------------|------|
| **Neovim** | ≥ 0.11 | L'éditeur |
| **Git** | any | Téléchargement des plugins |
| **Node.js + npm** | ≥ 18 | Serveurs LSP (JS, HTML, CSS, JSON…) |
| **ripgrep** (`rg`) | any | Recherche texte dans Telescope |
| **fd** | any | Recherche de fichiers dans Telescope |
| **gcc** ou **clang** | any | Compilation Treesitter |
| **unzip** | any | Extraction des binaires Mason |
| **Nerd Font** | any | Icônes (recommandé : JetBrainsMono Nerd Font) |

---

## 🚀 Installation rapide

### Option A — Script automatique (recommandé)

```bash
git clone https://github.com/VOTRE_USERNAME/Nvim-self.git ~/nvim-setup
bash ~/nvim-setup/install.sh
```

### Option B — Installation manuelle

```bash
# 1. Sauvegarder l'ancienne config si elle existe
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak

# 2. Cloner ce dépôt dans le dossier de config Neovim
git clone https://github.com/VOTRE_USERNAME/Nvim-self.git ~/.config/nvim

# 3. Supprimer le script de backup (ne sert qu'au propriétaire)
rm -f ~/.config/nvim/nvim-backup.sh

# 4. Lancer Neovim — les plugins s'installent automatiquement
nvim
```

Au premier lancement, **lazy.nvim installe tous les plugins**, puis **Mason installe tous les serveurs LSP**. Comptez 2–5 minutes selon la connexion.

---

## 📦 Dépendances système

### Ubuntu / Debian

```bash
sudo apt-get install -y git ripgrep fd-find nodejs npm gcc unzip
# fd-find s'appelle "fdfind" sur Debian/Ubuntu, créer un alias :
mkdir -p ~/.local/bin && ln -sf $(which fdfind) ~/.local/bin/fd
```

### Fedora / RHEL

```bash
sudo dnf install -y git ripgrep fd-find nodejs npm gcc unzip
```

### Arch Linux

```bash
sudo pacman -S --noconfirm git ripgrep fd nodejs npm gcc unzip
```

### macOS (Homebrew)

```bash
brew install git ripgrep fd node gcc
```

### Neovim lui-même

```bash
# Ubuntu/Debian — via PPA pour avoir une version récente
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update && sudo apt-get install -y neovim

# Arch
sudo pacman -S neovim

# macOS
brew install neovim

# Ou télécharger directement : https://github.com/neovim/neovim/releases
```

---

## 🔤 Police Nerd Font

Les icônes ne s'affichent correctement qu'avec une **Nerd Font**.

### Installation manuelle (JetBrainsMono)

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
unzip JetBrainsMono.zip -d JetBrainsMono
rm JetBrainsMono.zip
fc-cache -fv
```

Puis dans votre terminal : sélectionnez **JetBrainsMono Nerd Font** comme police.

---

## ⚙️ Personnalisation

**Un seul fichier à modifier : `lua/config/user.lua`**

```lua
-- Thème
colorscheme = "ember",       -- cyber | forest | ember | void | tokyonight-night | ...

-- Transparence (dépend du terminal)
transparent = true,

-- Curseur
cursor = { style = "line", smear = { preset = "fire" } },

-- Serveurs LSP installés
lsp = { servers = { "lua_ls", "pyright", "ts_ls", ... } },

-- Modules optionnels (false par défaut)
extras = { copilot = false, supermaven = false, prettier = false },
```

---

## 📖 Aide et commandes

Consultez le guide complet : `lua/config/guide.md`

Ou depuis Neovim : `<Space>ff` → taper `guide` → `Enter`

---

## 🤖 Nvim+ — Modules optionnels

| Module | Activation | Prérequis |
|--------|-----------|-----------|
| **GitHub Copilot** | `copilot = true` + `:Copilot setup` | Abonnement GitHub |
| **Supermaven** | `supermaven = true` | Gratuit, activation au 1er lancement |
| **Prettier** | `prettier = true` | `npm install -g prettier` |

> ⚠️ Copilot et Supermaven font la même chose. N'activez qu'un seul des deux.

---

## 🗂️ Structure du projet

```
~/.config/nvim/
├── init.lua                 ← point d'entrée
├── lazy-lock.json           ← versions des plugins (ne pas modifier)
├── colors/                  ← thèmes custom
│   ├── cyber.lua
│   ├── forest.lua
│   ├── ember.lua
│   └── void.lua
└── lua/
    ├── config/
    │   ├── user.lua         ← VOTRE fichier de config
    │   ├── guide.md         ← guide des commandes
    │   └── config.md        ← config terminal (Ghostty/Tabby)
    ├── plugins/             ← un fichier par fonctionnalité
    │   ├── ui.lua           (noice + neo-tree)
    │   ├── telescope.lua
    │   ├── which-key.lua
    │   ├── themes.lua
    │   ├── statusline.lua
    │   ├── dashboard.lua
    │   ├── cursor.lua
    │   ├── lsp.lua
    │   ├── cmp.lua
    │   ├── editing.lua      (marks, surround, autopairs, flash...)
    │   ├── terminal.lua
    │   └── extras.lua       (loader Nvim+)
    ├── extras/              ← modules optionnels Nvim+
    │   ├── copilot.lua
    │   ├── supermaven.lua
    │   └── prettier.lua
    └── themes/
        └── utils.lua        ← helpers partagés pour les thèmes
```

---

## 🔑 Keymaps essentiels

| Touche | Action |
|--------|--------|
| `Espace` | Ouvrir la liste des commandes (which-key) |
| `<leader>ff` | Chercher un fichier |
| `<leader>fg` | Chercher du texte |
| `<leader>e` | Toggle l'explorateur |
| `<leader>ft` | Terminal flottant |
| `<leader>nf` | Nouveau fichier |
| `<leader>nd` | Nouveau dossier |
| `Ctrl+s` | Sauvegarder |
| `gd` | Aller à la définition |
| `K` | Documentation |

→ Guide complet dans `lua/config/guide.md`
