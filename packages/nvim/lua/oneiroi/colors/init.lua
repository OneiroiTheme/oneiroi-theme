local M = {}

---@param opts oneiroi.config
---@return oneiroi.palette
M.setup = function(opts)
    local p ---@type oneiroi.palette
    if opts.style == 'dream' then
        p = require("oneiroi.colors.dream")
    end

    return p
end

return M
