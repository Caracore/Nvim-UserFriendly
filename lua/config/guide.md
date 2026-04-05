# 📖 Guide d'utilisation — Neovim Setup Personnel

> **Leader key = `Espace`** (noté `<leader>` dans ce guide)
> Pour ouvrir la liste des commandes disponibles : appuyez simplement sur `Espace` et attendez.

---

## Sommaire

1. [Concepts de base Neovim](#1-concepts-de-base-neovim)
2. [Démarrage et navigation dans les fichiers](#2-démarrage-et-navigation-dans-les-fichiers)
3. [Explorateur de fichiers — Neo-tree](#3-explorateur-de-fichiers--neo-tree)
4. [Telescope — Recherche universelle](#4-telescope--recherche-universelle)
5. [Buffers et fenêtres](#5-buffers-et-fenêtres)
6. [Édition avancée](#6-édition-avancée)
7. [Marks — Les signets de Neovim ⚑](#7-marks--les-signets-de-neovim-)
8. [Surround — Entourer du texte](#8-surround--entourer-du-texte)
9. [Commentaires](#9-commentaires)
10. [Flash — Navigation ultra-rapide](#10-flash--navigation-ultra-rapide)
11. [Search & Replace global](#11-search--replace-global)
12. [LSP — Intelligence du code](#12-lsp--intelligence-du-code)
13. [Autocomplétion](#13-autocomplétion)
14. [Sauvegarde](#14-sauvegarde)
15. [Thèmes et apparence](#15-thèmes-et-apparence)
16. [Nvim+ — Modules optionnels](#16-nvim--modules-optionnels)
17. [Personnalisation — user.lua](#17-personnalisation--userlua)
18. [Référence complète des keymaps](#18-référence-complète-des-keymaps)

---

## 1. Concepts de base Neovim

Neovim fonctionne avec des **modes**. Comprendre les modes est la clé pour tout.

| Mode | Comment y entrer | À quoi ça sert |
|------|-----------------|----------------|
| **Normal** | `Esc` depuis n'importe où | Navigation, commandes — mode par défaut |
| **Insert** | `i` (avant curseur), `a` (après), `o` (nouvelle ligne) | Taper du texte |
| **Visuel** | `v` (caractère), `V` (ligne), `Ctrl+v` (bloc) | Sélectionner du texte |
| **Visuel-ligne** | `V` | Sélectionner des lignes entières |
| **Commande** | `:` | Commandes ex (`:w`, `:q`, etc.) |

### Mouvements fondamentaux

```
h j k l   →  gauche / bas / haut / droite
w         →  mot suivant (début)
e         →  mot suivant (fin)
b         →  mot précédent
0         →  début de ligne
$         →  fin de ligne
gg        →  début du fichier
G         →  fin du fichier
{N}G      →  aller à la ligne N  (ex: 42G = ligne 42)
%         →  aller au bracket correspondant () [] {}
```

### Opérateurs + mouvements

La puissance de Neovim vient de la combinaison `opérateur + mouvement` :

```
d  = delete (supprimer)
c  = change (supprimer + passer en insertion)
y  = yank   (copier)
v  = select (sélectionner)

Exemples :
  dw   → supprimer jusqu'au prochain mot
  d$   → supprimer jusqu'en fin de ligne
  dd   → supprimer la ligne entière
  yy   → copier la ligne entière
  ciw  → changer le mot sous le curseur
  di"  → supprimer le contenu entre guillemets
  ya(  → copier tout ce qui est entre parenthèses (incluses)
```

---

## 2. Démarrage et navigation dans les fichiers

### Ouvrir Neovim

```bash
nvim              # Lance le dashboard
nvim .            # Ouvre l'explorateur de fichiers (Telescope)
nvim fichier.lua  # Ouvre directement un fichier
```

### Dashboard

Au lancement sans fichier, le dashboard s'affiche avec l'ASCII art personnalisé.
Appuyer sur `Espace` depuis le dashboard ouvre which-key (liste des commandes).

### Jump list — Historique de navigation

Neovim mémorise tous vos sauts (gd, Ctrl+d, etc.) dans une liste.

| Touche | Action |
|--------|--------|
| `Ctrl+o` | Reculer dans l'historique de navigation |
| `Ctrl+i` | Avancer dans l'historique de navigation |

> **Astuce :** Si vous allez à une définition avec `gd` et voulez revenir, `Ctrl+o` vous ramène exactement où vous étiez.

### Change list — Historique des modifications

```
g;   →  aller à la modification précédente
g,   →  aller à la modification suivante
```

---

## 3. Explorateur de fichiers — Neo-tree

L'explorateur est affiché sur la **droite** de l'écran.

| Keymap | Action |
|--------|--------|
| `<leader>e` | Ouvrir / fermer l'explorateur |
| `<leader>o` | Mettre le focus sur l'explorateur |

### Dans Neo-tree

Une fois le curseur dans l'explorateur :

| Touche | Action |
|--------|--------|
| `Enter` | Ouvrir le fichier / dossier |
| `a` | Créer un nouveau fichier ou dossier (terminer par `/` pour dossier) |
| `d` | Supprimer |
| `r` | Renommer |
| `c` | Copier |
| `m` | Déplacer |
| `y` | Copier le chemin |
| `q` | Fermer Neo-tree |
| `?` | Aide (liste toutes les touches) |

---

## 4. Telescope — Recherche universelle

Telescope est une fenêtre flottante de recherche floue (*fuzzy finder*).

| Keymap | Action |
|--------|--------|
| `<leader>ff` | Chercher un fichier par nom dans le projet |
| `<leader>fg` | Chercher un texte dans tous les fichiers (grep) |
| `<leader>fb` | Explorateur de fichiers interactif |
| `<leader>fr` | Fichiers récemment ouverts |

### Dans une fenêtre Telescope

| Touche | Action |
|--------|--------|
| `Ctrl+j` / `Ctrl+k` | Naviguer dans la liste |
| `Enter` | Ouvrir le fichier sélectionné |
| `Ctrl+v` | Ouvrir dans un split vertical |
| `Ctrl+x` | Ouvrir dans un split horizontal |
| `Ctrl+t` | Ouvrir dans un nouvel onglet |
| `Esc` | Fermer Telescope |

---

## 5. Buffers et fenêtres

### Concept : Buffer vs Fenêtre

- Un **buffer** = un fichier ouvert en mémoire (même si non visible)
- Une **fenêtre** = une zone d'affichage (plusieurs fenêtres peuvent montrer le même buffer)
- Un **tab** = un groupe de fenêtres

### Navigation entre buffers

| Keymap | Action |
|--------|--------|
| `Tab` | Buffer suivant |
| `Shift+Tab` | Buffer précédent |
| `<leader>bd` | Fermer le buffer courant |
| `<leader>ba` | Fermer tous les buffers |

### Splits (fenêtres multiples)

| Keymap | Action |
|--------|--------|
| `<leader>wv` | Diviser verticalement (côte à côte) |
| `<leader>ws` | Diviser horizontalement (haut/bas) |
| `<leader>wq` | Fermer la fenêtre courante |

### Navigation entre fenêtres

| Keymap | Action |
|--------|--------|
| `<leader>ww` | Cycle vers la fenêtre suivante |
| `<leader>wh` | Aller à la fenêtre de gauche |
| `<leader>wl` | Aller à la fenêtre de droite |
| `<leader>wj` | Aller à la fenêtre du bas |
| `<leader>wk` | Aller à la fenêtre du haut |
| `Ctrl+l` | Raccourci rapide → droite |
| `Ctrl+j` | Raccourci rapide → bas |
| `Ctrl+k` | Raccourci rapide → haut |

### Redimensionner les fenêtres

```
Ctrl+w >   →  élargir horizontalement
Ctrl+w <   →  rétrécir horizontalement
Ctrl+w +   →  agrandir verticalement
Ctrl+w -   →  rétrécir verticalement
Ctrl+w =   →  égaliser toutes les fenêtres
```

---

## 6. Édition avancée

### Déplacer des lignes

| Keymap | Mode | Action |
|--------|------|--------|
| `Alt+j` | Normal | Déplacer la ligne **vers le bas** |
| `Alt+k` | Normal | Déplacer la ligne **vers le haut** |
| `Alt+j` | Visuel | Déplacer la sélection **vers le bas** |
| `Alt+k` | Visuel | Déplacer la sélection **vers le haut** |

### Copier / Coller / Supprimer

| Keymap | Action |
|--------|--------|
| `<leader>d` | Dupliquer la ligne sous le curseur |
| `<leader>D` | Supprimer la ligne **sans polluer le registre de copie** |
| `p` (mode visuel) | Coller sans écraser ce qu'on avait copié |

> **Pourquoi `<leader>D` ?** Normalement `dd` supprime ET écrase le presse-papier. Avec `<leader>D`, la suppression va dans un "registre poubelle" (`_`) et votre copie précédente reste intacte.

### Indentation en mode visuel

| Keymap | Action |
|--------|--------|
| `>` | Indenter la sélection (reste en mode visuel) |
| `<` | Désindenter la sélection (reste en mode visuel) |

> **Astuce :** Vous pouvez appuyer plusieurs fois sur `>` sans resélecter.

### Navigation centrée

| Keymap | Action |
|--------|--------|
| `Ctrl+d` | Descendre d'une demi-page (curseur centré) |
| `Ctrl+u` | Monter d'une demi-page (curseur centré) |
| `n` | Résultat de recherche suivant (centré) |
| `N` | Résultat de recherche précédent (centré) |
| `Esc` | Effacer la surbrillance de recherche |

### Répétition

```
.   →  répéter la dernière action (la plus puissante commande de Neovim)
@:  →  répéter la dernière commande ex
```

---

## 7. Marks — Les signets de Neovim ⚑

Les marks sont des **signets invisibles** que vous posez dans votre code pour y revenir instantanément. C'est l'une des fonctionnalités les plus efficaces de Vim/Neovim.

### Principe

Imaginez que vous êtes dans une fonction au milieu d'un fichier de 500 lignes, et que vous devez aller vérifier quelque chose ailleurs — dans un autre fichier, ou 200 lignes plus bas. Avec les marks, vous posez un signet en une touche, allez faire votre vérification, et revenez exactement à l'endroit marqué en deux touches.

### Poser un mark

```
m{lettre}   →  poser un mark à la position courante
```

- `ma` → pose le mark "a" à la ligne et colonne courante
- `mB` → pose le mark global "B" (majuscule = global, fonctionne entre fichiers)

### Sauter vers un mark

```
'{lettre}   →  aller au début de la ligne marquée
`{lettre}   →  aller exactement à la position marquée (ligne + colonne)
```

- `'a` → saute au début de la ligne où "a" a été posé
- `` `a `` → saute exactement à la colonne où "a" a été posé
- `''` → saute au mark précédent (retour rapide)

### Supprimer un mark

```
dm{lettre}  →  supprimer le mark
dm-         →  supprimer tous les marks de la ligne
dm<Espace>  →  supprimer tous les marks du buffer
```

### Marks locaux (a–z) vs globaux (A–Z)

| Type | Lettres | Portée |
|------|---------|--------|
| **Local** | `a` à `z` (minuscules) | Valide dans le fichier courant uniquement |
| **Global** | `A` à `Z` (majuscules) | Valide entre tous les fichiers ouverts |

**Exemple pratique :**
```
Fichier auth.js  →  mA   (pose le mark global A)
Fichier user.js  →  mB   (pose le mark global B)
Plus tard :
  'A  →  revient dans auth.js à la bonne ligne
  'B  →  revient dans user.js à la bonne ligne
```

### Marks spéciaux (automatiques)

Ces marks sont gérés automatiquement par Neovim :

| Mark | Signification |
|------|--------------|
| `` `. `` | Dernière modification dans ce fichier |
| `` `^ `` | Dernière position en mode insertion |
| `` `[ `` et `` `] `` | Début et fin du dernier texte copié/collé |
| `` `< `` et `` `> `` | Début et fin de la dernière sélection visuelle |
| `''` | Retour au mark précédent (double guillemet simple) |

### Lister les marks (keymaps custom)

| Keymap | Action |
|--------|--------|
| `<leader>mm` | Afficher tous les marks du buffer courant |
| `<leader>mg` | Afficher tous les marks globaux |

### Indicateurs visuels dans la gouttière

Le plugin `marks.nvim` affiche une icône dans la gouttière (à gauche des numéros de ligne) pour chaque mark posé. Vous pouvez voir d'un coup d'œil où sont vos signets.

### Workflow recommandé

```
1. Vous êtes sur une ligne importante → ma
2. Vous naviguez ailleurs pour du contexte
3. `a  → retour exact à l'endroit marqué
4. dma → nettoyage du mark quand vous n'en avez plus besoin
```

---

## 8. Surround — Entourer du texte

Le plugin `nvim-surround` permet d'ajouter, changer ou supprimer des délimiteurs autour de texte.

### Ajouter un entourage : `ys{motion}{char}`

```
ysiw"   →  entoure le mot sous le curseur de guillemets doubles : mot → "mot"
ysiw'   →  entoure avec guillemets simples
ysiw(   →  entoure avec parenthèses avec espaces : mot → ( mot )
ysiw)   →  entoure avec parenthèses sans espaces : mot → (mot)
ysiw{   →  entoure avec accolades avec espaces : mot → { mot }
ys$"    →  entoure de la position courante jusqu'en fin de ligne
yss"    →  entoure la ligne entière
```

> **Motion courants :** `iw` (mot), `iW` (mot large), `i"` (dans guillemets), `a(` (avec parenthèses), `p` (paragraphe)

### Changer un entourage : `cs{ancien}{nouveau}`

```
cs"'    →  change " en '  :  "mot" → 'mot'
cs'`    →  change ' en `  :  'mot' → `mot`
cs({    →  change () en {}:  (mot) → { mot }
cs([    →  change () en []:  (mot) → [mot]
```

### Supprimer un entourage : `ds{char}`

```
ds"     →  supprime les guillemets doubles
ds(     →  supprime les parenthèses
ds{     →  supprime les accolades
dst     →  supprime les balises HTML/XML
```

### Exemples réels

```lua
-- Avant : print(hello)
-- Curseur sur "hello", taper: ysiw"
-- Après  : print("hello")

-- Avant : "bonjour"
-- Taper: cs"'
-- Après  : 'bonjour'

-- Avant : (x + y)
-- Taper: ds(
-- Après  : x + y
```

---

## 9. Commentaires

Le plugin `Comment.nvim` gère les commentaires intelligemment selon le langage.

| Keymap | Mode | Action |
|--------|------|--------|
| `gcc` | Normal | Commenter / décommenter la ligne |
| `gbc` | Normal | Commenter en bloc (`/* */`) |
| `gc{motion}` | Normal | Commenter un mouvement |
| `gc` | Visuel | Commenter la sélection |
| `gcO` | Normal | Ajouter un commentaire à la ligne **au-dessus** |
| `gco` | Normal | Ajouter un commentaire à la ligne **en-dessous** |
| `gcA` | Normal | Ajouter un commentaire en **fin de ligne** |

### Exemples

```
gcc          →  commente/décommente la ligne courante
3gcc         →  commente 3 lignes
gcip         →  commente le paragraphe entier
V3jgc        →  sélectionne 3 lignes et les commente
```

---

## 10. Flash — Navigation ultra-rapide

Flash remplace le `f`/`t` habituel par une navigation à étiquettes visuelles.

### `s` — Saut direct dans l'écran

```
s{deux lettres}   →  Flash affiche des étiquettes sur chaque occurrence
                      Tapez l'étiquette pour y sauter instantanément
```

**Exemple :** Vous voyez `function` dans votre écran. Tapez `sfu` et Flash affiche des lettres colorées sur chaque `fu` visible. Tapez la lettre de l'étiquette → vous y êtes.

### `S` — Sélection par nœud Treesitter

```
S   →  Flash affiche les nœuds syntaxiques (fonctions, blocs, etc.)
        Utile pour sélectionner des blocs entiers précisément
```

### Amélioration de `f`, `t`, `F`, `T`

Flash améliore aussi les commandes natives de saut sur caractère avec des étiquettes visuelles quand plusieurs occurrences existent :

```
f{char}   →  saute à la prochaine occurrence du caractère (avec étiquettes)
F{char}   →  saute en arrière
t{char}   →  saute juste avant le caractère
T{char}   →  saute en arrière juste après
```

### Intégration avec la recherche `/`

Flash est aussi actif dans les recherches `/` et `?` — les résultats affichent des étiquettes de saut.

---

## 11. Search & Replace global

### Recherche dans le fichier

```
/texte      →  chercher "texte" (résultats surlignés)
?texte      →  chercher en arrière
n           →  résultat suivant (centré automatiquement)
N           →  résultat précédent (centré)
Esc         →  effacer la surbrillance
```

### Remplacement dans le fichier

```
:%s/ancien/nouveau/g     →  remplace toutes les occurrences
:%s/ancien/nouveau/gc    →  remplace avec confirmation pour chaque
:s/ancien/nouveau/g      →  remplace sur la ligne courante seulement
```

### Search & Replace dans tout le projet — Grug-Far

| Keymap | Action |
|--------|--------|
| `<leader>sr` | Ouvrir le panneau Search & Replace projet |
| `<leader>sw` | Rechercher/remplacer le mot sous le curseur |

**Dans le panneau Grug-Far :**

```
Remplissez les champs :
  Search  : le texte à chercher
  Replace : le texte de remplacement
  Files   : filtre de fichiers (ex: *.lua, *.js)
  Flags   : options (i = insensible à la casse, etc.)

Ctrl+Enter  →  lancer le remplacement
```

---

## 12. LSP — Intelligence du code

Le LSP (Language Server Protocol) apporte l'intelligence d'un IDE dans Neovim. Il se connecte automatiquement quand vous ouvrez un fichier d'un langage supporté.

### Langages supportés

| Langage | Serveur LSP |
|---------|------------|
| HTML | html |
| CSS / SCSS | cssls |
| JavaScript / TypeScript | ts_ls |
| JSON | jsonls |
| Python | pyright |
| Go | gopls |
| Rust | rust_analyzer |
| C / C++ | clangd |
| Bash / Shell | bashls |
| YAML | yamlls |
| TOML | taplo |
| Dockerfile | dockerls |
| Markdown | marksman |
| Lua | lua_ls |

### Keymaps LSP (actifs seulement quand un serveur est attaché)

#### Navigation dans le code

| Keymap | Action |
|--------|--------|
| `gd` | Aller à la **définition** de la fonction/variable |
| `gD` | Aller à la **déclaration** |
| `gr` | Voir toutes les **références** à ce symbole |
| `gi` | Aller à l'**implémentation** |
| `K` | Afficher la **documentation** en popup |
| `Ctrl+k` | Afficher la **signature** de la fonction |

#### Actions sur le code

| Keymap | Action |
|--------|--------|
| `<leader>cr` | **Renommer** le symbole (renomme dans tout le projet) |
| `<leader>ca` | **Actions code** (imports automatiques, corrections, etc.) |
| `<leader>cf` | **Formater** le fichier entier |

#### Diagnostics (erreurs, avertissements)

| Keymap | Action |
|--------|--------|
| `<leader>xd` | Voir le détail de l'erreur sous le curseur |
| `[d` | Aller au diagnostic **précédent** |
| `]d` | Aller au diagnostic **suivant** |
| `<leader>xl` | Liste tous les diagnostics dans Telescope |

#### Icônes dans la gouttière

```
 → Erreur (Error)
 → Avertissement (Warning)
 → Information (Info)
󰌶 → Suggestion (Hint)
```

### Gérer les serveurs LSP — Mason

```
:Mason           →  ouvre l'interface de gestion des serveurs
:MasonUpdate     →  met à jour tous les serveurs installés
:LspInfo         →  voir quels serveurs sont actifs dans le buffer courant
:LspLog          →  voir les logs LSP (debug)
```

---

## 13. Autocomplétion

L'autocomplétion s'affiche automatiquement pendant la frappe.

| Touche | Action |
|--------|--------|
| `Ctrl+n` | Sélection suivante dans la liste |
| `Ctrl+p` | Sélection précédente |
| `Tab` | Confirmer la sélection / naviguer dans un snippet |
| `Shift+Tab` | Naviguer en arrière dans un snippet |
| `Enter` | Confirmer la sélection |
| `Ctrl+e` | Fermer la popup sans compléter |
| `Ctrl+Space` | Forcer l'affichage de la popup |

### Sources d'autocomplétion

L'autocomplétion puise dans plusieurs sources simultanément :
- **LSP** : symboles du langage (fonctions, variables, types)
- **Snippets** : extraits de code (LuaSnip)
- **Buffer** : mots déjà présents dans le fichier ouvert
- **Chemin** : chemins de fichiers système

---

## 14. Sauvegarde

| Keymap | Mode | Action |
|--------|------|--------|
| `Ctrl+s` | Normal / Insert / Visuel | Sauvegarder le fichier |
| `:w` | Commande | Sauvegarder |
| `:wa` | Commande | Sauvegarder tous les fichiers ouverts |
| `:wq` | Commande | Sauvegarder et quitter |

Après chaque sauvegarde :
- Une **notification** apparaît en bas avec le nom du fichier
- Un **son** est joué (configurable dans `user.lua`)

---

## 15. Thèmes et apparence

### Changer le thème

Modifiez `colorscheme` dans `lua/config/user.lua` :

```lua
colorscheme = "cyber",      -- Cyberpunk neon  (bleu/rose/cyan)
colorscheme = "forest",     -- Nature sombre   (verts + or)
colorscheme = "ember",      -- Feu et braises  (orange/rouge)
colorscheme = "void",       -- Ultra minimal   (quasi noir)
colorscheme = "tokyonight-night",
colorscheme = "catppuccin-mocha",
colorscheme = "rose-pine",
colorscheme = "gruvbox",
```

### Transparence

```lua
transparent = true,   -- fond transparent (dépend du terminal)
transparent = false,  -- fond opaque
```

> ⚠️ La transparence ne fonctionne que si votre terminal supporte la transparence (Ghostty, Alacritty, Kitty, etc.)

### Curseur

```lua
cursor = {
  style = "line",       -- "block" | "line" | "underline"
  smear = {
    enabled = true,
    preset  = "fire",   -- "default" | "fire" | "fast" | "smooth"
  },
}
```

---

## 16. Nvim+ — Modules optionnels

Ces modules ne sont **pas installés** par défaut. Activez-les dans `user.lua` :

```lua
extras = {
  copilot    = false,  -- GitHub Copilot (nécessite un abonnement)
  supermaven = false,  -- Supermaven AI (gratuit)
  prettier   = false,  -- Formateur Prettier (nécessite npm)
}
```

> ⚠️ **Copilot et Supermaven font la même chose.** N'activez qu'un seul des deux.

### Activer GitHub Copilot

1. `copilot = true` dans `user.lua`
2. Relancer Neovim
3. `:Copilot setup` → ouvre le lien d'authentification GitHub

### Activer Supermaven

1. `supermaven = true` dans `user.lua`
2. Relancer Neovim
3. Supermaven affichera un lien d'activation au premier lancement

### Activer Prettier

1. `npm install -g prettier` dans votre terminal
2. `prettier = true` dans `user.lua`
3. `<leader>cf` formate avec Prettier

---

## 17. Personnalisation — user.lua

**Tout se passe dans `lua/config/user.lua`.** C'est le seul fichier à modifier.

```
~/.config/nvim/
├── init.lua              ← ne pas toucher (sauf avancé)
└── lua/
    └── config/
        └── user.lua      ← VOTRE fichier de configuration
```

### Structure de user.lua

```lua
return {
  colorscheme = "ember",          -- thème
  transparent = true,             -- transparence
  cursor      = { style, smear }, -- curseur
  tree        = { position, width }, -- explorateur
  save        = { notify, sound, sound_file }, -- sauvegarde
  editor      = { tab_size, line_numbers, ... },
  dashboard_header = { ... },     -- ASCII art
  keymaps     = { ... },          -- vos raccourcis
  extras      = { copilot, ... }, -- modules optionnels
  lsp = { servers = { ... } },    -- serveurs LSP
}
```

### Ajouter un keymap personnalisé

Dans la section `keymaps` de `user.lua` :

```lua
{ "<leader>x", "<cmd>ma_commande<cr>", "Description" },
```

### Ajouter / retirer un serveur LSP

Dans la section `lsp.servers` :

```lua
lsp = {
  servers = {
    "lua_ls",
    "pyright",
    -- "gopls",  ← commenté = désactivé
    "rust_analyzer",
  }
}
```

---

## 18. Référence complète des keymaps

### 🗂️ Fichiers, explorateur et terminal

| Keymap | Action |
|--------|--------|
| `<leader>e` | Toggle Neo-tree |
| `<leader>o` | Focus Neo-tree |
| `<leader>ff` | Chercher fichier (Telescope) |
| `<leader>fg` | Chercher texte dans le projet |
| `<leader>fb` | Explorateur fichiers (Telescope) |
| `<leader>fr` | Fichiers récents |
| `<leader>ft` | **Terminal flottant** |
| `<leader>fT` | **Terminal horizontal** |

> Dans le terminal : `Esc` pour fermer, `Ctrl+w` pour naviguer vers une autre fenêtre.

### 📄 Buffers

| Keymap | Action |
|--------|--------|
| `Tab` | Buffer suivant |
| `Shift+Tab` | Buffer précédent |
| `<leader>bd` | Fermer le buffer courant |
| `<leader>ba` | Fermer tous les buffers |

### 🪟 Fenêtres

| Keymap | Action |
|--------|--------|
| `<leader>wv` | Split vertical |
| `<leader>ws` | Split horizontal |
| `<leader>wq` | Fermer la fenêtre |
| `<leader>ww` | Cycle fenêtres |
| `<leader>wh/l/j/k` | Naviguer direction |
| `Ctrl+l/j/k` | Naviguer rapidement |

### ✏️ Édition

| Keymap | Mode | Action |
|--------|------|--------|
| `Ctrl+s` | N/I/V | Sauvegarder |
| `Alt+j` | N/V | Déplacer ligne/sélection bas |
| `Alt+k` | N/V | Déplacer ligne/sélection haut |
| `<leader>d` | N | Dupliquer la ligne |
| `<leader>D` | N | Supprimer (sans registre) |
| `>` | V | Indenter (reste en visuel) |
| `<` | V | Désindenter (reste en visuel) |
| `p` | V | Coller sans écraser le registre |
| `Ctrl+d` | N | Demi-page bas (centré) |
| `Ctrl+u` | N | Demi-page haut (centré) |
| `n` / `N` | N | Résultat suivant/précédent (centré) |
| `Esc` | N | Effacer surbrillance |
| `.` | N | Répéter la dernière action |

### ⚑ Marks

| Keymap | Action |
|--------|--------|
| `m{a-z}` | Poser un mark local |
| `m{A-Z}` | Poser un mark global (inter-fichiers) |
| `` `{a-z} `` | Sauter exactement à la position |
| `'{a-z}` | Sauter au début de la ligne |
| `dm{a-z}` | Supprimer un mark |
| `<leader>mm` | Lister les marks du buffer |
| `<leader>mg` | Lister les marks globaux |

### 🔤 Surround

| Keymap | Action |
|--------|--------|
| `ys{motion}{char}` | Ajouter un entourage |
| `cs{ancien}{nouveau}` | Changer un entourage |
| `ds{char}` | Supprimer un entourage |

### 💬 Commentaires

| Keymap | Action |
|--------|--------|
| `gcc` | Commenter/décommenter la ligne |
| `gc{motion}` | Commenter un mouvement |
| `gc` (visuel) | Commenter la sélection |
| `gcO` | Commentaire au-dessus |
| `gco` | Commentaire en-dessous |
| `gcA` | Commentaire en fin de ligne |

### ⚡ Flash (navigation)

| Keymap | Action |
|--------|--------|
| `s{2 lettres}` | Saut direct à l'écran |
| `S` | Saut par nœud Treesitter |

### 🔍 Recherche & Remplacement

| Keymap | Action |
|--------|--------|
| `<leader>sr` | Search & Replace dans le projet |
| `<leader>sw` | Remplacer le mot sous le curseur |

### 🧠 LSP (Intelligence)

| Keymap | Action |
|--------|--------|
| `gd` | Aller à la définition |
| `gD` | Aller à la déclaration |
| `gr` | Voir les références |
| `gi` | Aller à l'implémentation |
| `K` | Documentation |
| `Ctrl+k` | Signature de la fonction |
| `<leader>cr` | Renommer le symbole |
| `<leader>ca` | Actions code |
| `<leader>cf` | Formater |
| `<leader>xd` | Détail diagnostic |
| `[d` / `]d` | Diagnostic précédent/suivant |
| `<leader>xl` | Liste des diagnostics |

### 🚪 Quitter

| Keymap | Action |
|--------|--------|
| `<leader>q` | Quitter tous les buffers |
| `:wq` | Sauvegarder et quitter |
| `:q!` | Quitter sans sauvegarder |

---

*Guide généré pour le setup Neovim personnel — version 2026*
