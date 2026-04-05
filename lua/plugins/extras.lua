-- ============================================================
--  NVIM+ — Loader des extras
--  Lit user.lua et charge dynamiquement chaque addon activé.
--  Pour ajouter un nouvel extra :
--    1. Créer lua/extras/mon-extra.lua
--    2. Ajouter   mon_extra = false   dans user.lua > extras
--    3. Ajouter l'entrée dans la table `available` ci-dessous
-- ============================================================

local U       = require("config.user")
local extras  = U.extras or {}
local plugins = {}

-- Table des extras disponibles
-- clé = nom dans user.lua   valeur = chemin du module lua/extras/
local available = {
  copilot    = "extras.copilot",
  supermaven = "extras.supermaven",
  prettier   = "extras.prettier",
}

-- Vérifie les conflits d'IA
if extras.copilot and extras.supermaven then
  vim.notify(
    "[Nvim+] Copilot ET Supermaven sont activés en même temps.\n"
    .. "Désactivez l'un des deux dans user.lua > extras.",
    vim.log.levels.WARN
  )
end

-- Charge chaque extra activé
for key, module in pairs(available) do
  if extras[key] then
    local ok, result = pcall(require, module)
    if ok and type(result) == "table" then
      vim.list_extend(plugins, result)
    else
      vim.notify("[Nvim+] Erreur lors du chargement de l'extra '" .. key .. "'", vim.log.levels.ERROR)
    end
  end
end

return plugins
