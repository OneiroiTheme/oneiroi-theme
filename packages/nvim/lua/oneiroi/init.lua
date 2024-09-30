local config = require("oneiroi.config")
-- local colors = require("oneiroi.colors")
local M = {}

-- Pass setup to config module
M.setup = config.setup

---@param opts oneiroi.config
M.load = function(opts)
    opts = require("oneiroi.config").extend(opts)
    opts.style = "dark"

    -- opts.transparent = true

    return require("oneiroi.theme").setup(opts)
end

return M
