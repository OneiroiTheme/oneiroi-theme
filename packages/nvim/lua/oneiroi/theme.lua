local M = {}

---@param opts? oneiroi.config
M.setup = function(opts)
    opts = require("oneiroi.config").extend(opts)
    local palette = require("oneiroi.colors").setup(opts)
    local groups = require("oneiroi.groups").setup(palette, opts)

    -- print(vim.inspect(groups))
    for group, hl in pairs(groups) do
        hl = type(hl) == "string" and { link = hl } or hl
        vim.api.nvim_set_hl(0, group, hl)
    end

    return palette, groups, opts
end

return M
