 
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
