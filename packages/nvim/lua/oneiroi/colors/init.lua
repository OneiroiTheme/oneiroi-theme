local M = {}

---@param opts oneiroi.config
---@return oneiroi.palette
M.setup = function(opts)
    local p ---@type oneiroi.palette
    if opts.style == 'dark' then
        p = require("oneiroi.colors.dark")
    end

    return p
end

return M
