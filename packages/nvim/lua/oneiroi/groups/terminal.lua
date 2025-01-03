local M = {}

---@type oneiroi.hler
M.get = function(c, opts)
  vim.g.terminal_color_0 = c.bg
  vim.g.terminal_color_8 = c.bg

  -- light
  vim.g.terminal_color_7 = c.fg_s
  vim.g.terminal_color_15 = c.fg

  -- c
  vim.g.terminal_color_1 = c.red_s
  vim.g.terminal_color_9 = c.red

  vim.g.terminal_color_2 = c.gre_s
  vim.g.terminal_color_10 = c.gre

  vim.g.terminal_color_3 = c.yel_s
  vim.g.terminal_color_11 = c.yel

  vim.g.terminal_color_4 = c.blu_s
  vim.g.terminal_color_12 = c.blu

  vim.g.terminal_color_5 = c.pur_s
  vim.g.terminal_color_18 = c.pur

  vim.g.terminal_color_6 = c.aqu_s
  vim.g.terminal_color_14 = c.aqu
  return {}
end

return M
