 
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
