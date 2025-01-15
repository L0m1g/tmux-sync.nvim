local M = {}

-- 🔎 Récupérer la couleur d'un groupe de highlight
local function get_hl_color(hl, attr)
    local ok, hl_data = pcall(vim.api.nvim_get_hl, 0, { name = hl })
    if ok and hl_data[attr] then
        return string.format("#%06x", hl_data[attr])
    else
        return "#444444"  -- Gris par défaut si rien trouvé
    end
end

-- 📡 Synchroniser les couleurs avec Tmux selon le mode
M.set_tmux_status = function(mode)
    local mode_colors = {
        n  = get_hl_color("MiniStatuslineModeNormal", "bg"),
        i  = get_hl_color("MiniStatuslineModeInsert", "bg"),
        v  = get_hl_color("MiniStatuslineModeVisual", "bg"),
        V  = get_hl_color("MiniStatuslineModeVisual", "bg"),
        [""] = get_hl_color("MiniStatuslineModeVisual", "bg"),
        R  = get_hl_color("MiniStatuslineModeReplace", "bg"),
        c  = get_hl_color("MiniStatuslineModeCommand", "bg"),
    }

    local color = mode_colors[mode] or get_hl_color("MiniStatuslineModeNormal", "bg")

    -- 🛠️ Commande silencieuse pour changer la couleur de Tmux
    vim.fn.system({ "tmux", "set-option", "status-bg", color })
end

-- 🔄 Détecte les changements de mode
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
        local mode = vim.fn.mode()
        M.set_tmux_status(mode)
    end,
})

return M
