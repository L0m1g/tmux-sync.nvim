local M = {}

-- 🔍 Vérifie si tmux est installé
local function is_tmux_installed()
    return vim.fn.executable("tmux") == 1
end

-- 🔍 Vérifie si on est dans une session tmux
local function is_in_tmux()
    return os.getenv("TMUX") ~= nil
end

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
    if not (is_tmux_installed() and is_in_tmux()) then
        return  -- 🔒 Ne fait rien si tmux n'est pas dispo
    end

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
    vim.fn.system({ "tmux", "set-option", "-g", "status-bg", color })
end

-- 🔄 Détecte les changements de mode
if is_tmux_installed() and is_in_tmux() then
    vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "*",
        callback = function()
            local mode = vim.fn.mode()
            M.set_tmux_status(mode)
        end,
    })
end

return M
