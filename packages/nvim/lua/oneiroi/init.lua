local config = require("oneiroi.config")
local M = {}

-- Pass setup to config module
M.setup = config.setup

---@param opts ? oneiroi.config
M.load = function(opts)
	opts = require("oneiroi.config").extend(opts)
	return require("oneiroi.theme").setup(opts)
end

return M
