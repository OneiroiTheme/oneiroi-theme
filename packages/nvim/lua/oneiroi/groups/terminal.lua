local M = {}

---@type oneiroi.hler
M.get = function(c, opts)
    vim.g.terminal_color_0 = c.black
    vim.g.terminal_color_8 = c.black

    -- light
    vim.g.terminal_color_7 = c.whiteDark
    vim.g.terminal_color_15 = c.white

    -- c
    vim.g.terminal_color_1 = c.redDark
    vim.g.terminal_color_9 = c.red

    vim.g.terminal_color_2 = c.greenDark
    vim.g.terminal_color_10 = c.green

    vim.g.terminal_color_3 = c.yellowDark
    vim.g.terminal_color_11 = c.yellow

    vim.g.terminal_color_4 = c.blueDark
    vim.g.terminal_color_12 = c.blue

    vim.g.terminal_color_5 = c.magentaDark
    vim.g.terminal_color_18 = c.magenta

    vim.g.terminal_color_6 = c.cyanDark
    vim.g.terminal_color_14 = c.cyan
    return {}
end

return M
