 
● Maintenant dans user.lua, activez :

   transparent = true,

  Ce qui se passe :

  Neovim → Normal { bg = NONE } → Ghostty voit un fond vide → affiche le flou/fond derrière

  Les groupes forcés à NONE : Normal, NormalFloat, neo-tree, Telescope, Noice, statusline, tabline, et plus. L'autocmd ColorScheme ré-applique la
  transparence si vous changez de thème à la volée avec :colorscheme.

vim.fn.jobstart lance le son en arrière-plan sans bloquer Neovim - c'est bcp plus propreque vim.fn.system:
Son dispo

complete.oga default
message.oga Notif neutral
bell.oga Cloche 
message-new-instant.oga Ping vif
piano-3.wav Note de piano

● Plus aucune erreur. Voici ce qui a changé :

  ┌──────────────────────────────────┬─────────────────────────────────────────────────────────┐
  │ Ancien (déprécié)                │ Nouveau (0.11)                                          │
  ├──────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ lspconfig[server].setup(opts)    │ vim.lsp.config(server, opts) + vim.lsp.enable(list)     │
  ├──────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ on_attach = function(_, bufnr)   │ autocmd LspAttach                                       │
  ├──────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ vim.fn.sign_define(...)          │ vim.diagnostic.config({ signs = { text = {} } })        │
  ├──────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ vim.diagnostic.goto_prev/next    │ vim.diagnostic.jump({ count = ±1 })                     │
  ├──────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ automatic_installation = true    │ automatic_enable = false (on gère manuellement)         │
  └──────────────────────────────────┴─────────────────────────────────────────────────────────┘

  Les serveurs sont toujours installés par Mason, mais configurés via la nouvelle API native de Neovim.
● Plus aucune erreur. Voici ce qui a changé :

  ┌──────────────────────────────────┬─────────────────────────────────────────────────────────┐
  │ Ancien (déprécié)                │ Nouveau (0.11)                                          │
  ├──────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ lspconfig[server].setup(opts)    │ vim.lsp.config(server, opts) + vim.lsp.enable(list)     │
  ├──────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ on_attach = function(_, bufnr)   │ autocmd LspAttach                                       │
  ├──────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ vim.fn.sign_define(...)          │ vim.diagnostic.config({ signs = { text = {} } })        │
  ├──────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ vim.diagnostic.goto_prev/next    │ vim.diagnostic.jump({ count = ±1 })                     │
  ├──────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ automatic_installation = true    │ automatic_enable = false (on gère manuellement)         │
  └──────────────────────────────────┴─────────────────────────────────────────────────────────┘

  Les serveurs sont toujours installés par Mason, mais configurés via la nouvelle API native de Neovim.

● Edit which-key.lua +1
  └ lua/plugins/which-key.lua

● Verify no errors (shell)
  │ nvim --headless -c "qa" 2>&1 | grep -E "Error|error|WARN" | head -10
  └ 1 line...

● ✅ Aucune erreur. Voici comment ça fonctionne :

  ┌──────────────┬──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
  │ Keymap       │ Action                                                                                                                               │
  ├──────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
  │ <leader>nf   │ Créer un nouveau fichier — un prompt s'ouvre pré-rempli avec le dossier courant. Tapez le nom (ou un chemin complet comme            │
  │              │ src/utils/helper.lua). Les dossiers parents sont créés automatiquement si besoin. Le fichier s'ouvre directement.                    │
  ├──────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
  │ <leader>nd   │ Créer un nouveau dossier — même principe, le dossier est créé et Neo-tree se rafraîchit.                                             │
  └──────────────┴──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

   Astuce : Pour créer src/components/Button.tsx depuis n'importe où, faites <leader>nf et tapez le chemin complet depuis la racine du projet.



● ✅ Aucune erreur. Voici ce qui change :

  Avant

  Taper :sav → rien ou suggestion basique

  Après

  Taper :sav → popup avec :saveas, :save et le chemin du fichier

  ------------------------------------------------------------------------------------------------------------------------------------------------------

  Ce qui a été ajouté :

  ┌────────────────────────┬─────────────────────────────────────────────────────────────────┐
  │ Source                 │ Activée quand                                                   │
  ├────────────────────────┼─────────────────────────────────────────────────────────────────┤
  │ cmp-cmdline            │ Toutes les commandes : (:saveas, :bufdo, :set, :lua…)           │
  ├────────────────────────┼─────────────────────────────────────────────────────────────────┤
  │ cmp-path en cmdline    │ Chemins de fichiers après :e, :saveas…                          │
  ├────────────────────────┼─────────────────────────────────────────────────────────────────┤
  │ cmp-buffer en search   │ Mots du buffer courant lors d'une recherche /                   │
  ├────────────────────────┼─────────────────────────────────────────────────────────────────┤
  │ wildmenu natif         │ Fallback popup si cmp n'est pas encore chargé                   │
  └────────────────────────┴─────────────────────────────────────────────────────────────────┘

  Navigation dans le popup : Tab / Shift+Tab ou Ctrl+j / Ctrl+k.


● Tout est en place. Voici le résumé :

  -----------------------------------------------------------------------

  Ce qui a été fait

  3 fichiers modifiés, 1 créé :

  ┌──────────────────────────────┬───────────────────────────────────────┐
  │ Fichier                      │ Modification                          │
  ├──────────────────────────────┼───────────────────────────────────────┤
  │ lua/extras/spotify.lua       │ ✅ Créé — plugin + keymaps            │
  ├──────────────────────────────┼───────────────────────────────────────┤
  │ lua/plugins/extras.lua       │ + entrée spotify dans la table        │
  ├──────────────────────────────┼───────────────────────────────────────┤
  │ lua/config/user.lua          │ + spotify = false dans extras         │
  ├──────────────────────────────┼───────────────────────────────────────┤
  │ lua/plugins/statusline.lua   │ + composant lualine conditionnel      │
  │                              │ (vert Spotify)                        │
  └──────────────────────────────┴───────────────────────────────────────┘

  -----------------------------------------------------------------------

  Pour activer

  Dans user.lua :

   spotify = true,  -- nécessite spotify-tui + golang

  Prérequis à installer

   # Rust requis pour cargo
   cargo install spotify-tui
   # Ou via snap
   snap install spt
   
   # Golang
   sudo apt install golang

  Puis lancer spt une première fois pour l'authentification Spotify.

  Keymaps (<leader>m)

  ┌──────────────┬─────────────────────┐
  │ Touche       │ Action              │
  ├──────────────┼─────────────────────┤
  │ <leader>mo   │ Recherche Telescope │
  ├──────────────┼─────────────────────┤
  │ <leader>mp   │ Pause / Play        │
  ├──────────────┼─────────────────────┤
  │ <leader>mn   │ Piste suivante      │
  ├──────────────┼─────────────────────┤
  │ <leader>mb   │ Piste précédente    │
  ├──────────────┼─────────────────────┤
  │ <leader>ms   │ Sauvegarder piste   │
  ├──────────────┼─────────────────────┤
  │ <leader>mr   │ Shuffle             │
  ├──────────────┼─────────────────────┤
  │ <leader>md   │ Choisir device      │
  └──────────────┴─────────────────────┘

 Le plugin embarque un binaire Go dans son dossier go/. Quand tu fais 
  build = "make", ça compile ce binaire en local :

   cd ./go; go build -o ../bin/NvimSpotify

  Ce binaire NvimSpotify est le pont entre Neovim et l'API Spotify (via
  spotify-tui). C'est lui qui gère les appels API en arrière-plan — c'est
  d'ailleurs pourquoi il n'impacte pas les perfs de Neovim : tout tourne
  dans ce process séparé.

  En résumé : Go est nécessaire une seule fois à l'installation pour
  compiler le binaire. Une fois compilé, plus besoin de Go.

  Go est indispensable pour chaque utilisateur. Voici pourquoi :

Quand lazy.nvim installe le plugin, il exécute build = "make" sur la
machine du nouvel utilisateur. Le binaire compilé va dans :

 ~/.local/share/nvim/lazy/nvim-spotify/bin/NvimSpotify

Ce dossier fait partie de lazy's data, pas de ton repo de config. Donc
il n'est pas partagé.

-----------------------------------------------------------------------

Options :

┌───────────────────────────┬────────────┬─────────────────────────────┐
│ Option                    │ Pro        │ Con                         │
├───────────────────────────┼────────────┼─────────────────────────────┤
│ Chaque user installe Go   │ Simple,    │ Dépendance à installer      │
│                           │ propre     │                             │
├───────────────────────────┼────────────┼─────────────────────────────┤
│ Pré-compiler et shipper   │ Pas besoin │ Binaire Linux x86           │
│ le binaire dans le repo   │ de Go      │ uniquement, lourd, risque   │
│                           │            │ sécu                        │
├───────────────────────────┼────────────┼─────────────────────────────┤
│ Utiliser un autre plugin  │ Zéro       │ Moins de features           │
│                           │ dépendance │                             │
│                           │ Go         │                             │
└───────────────────────────┴────────────┴─────────────────────────────┘

-----------------------------------------------------------------------

La meilleure solution pour tes users serait de documenter clairement
dans ton README :

 Pour activer spotify = true dans user.lua, installer au préalable :
 
  sudo apt install golang   # ou: snap install go --classic
  snap install spt          # spotify-tui

Go n'est utilisé qu'une fois à la compilation (~30s), après ça il peut
même être désinstallé.
