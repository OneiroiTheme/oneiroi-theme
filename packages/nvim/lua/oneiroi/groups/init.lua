local M = {}

---@alias grpName string

---@param name grpName
M.get_grp = function(name)
	---@type {get: oneiroi.hler}
	return require("oneiroi.groups." .. name)
end

---@param name grpName
---@return oneiroi.hl
M.get_hl = function(name, palette, opts)
	return M.get_grp(name).get(palette, opts)
end

---@param palette oneiroi.palette
---@param opts oneiroi.config
---@return oneiroi.hl, table<boolean>
M.setup = function(palette, opts)
	opts = require("oneiroi.config").extend(opts)

	local groups = {
		base = true,
		terminal = false,
		editor = false,
		treesitter = true,
	}

	if not opts.terminal_colors then --terminal
		groups.terminal = true
	end

	local ret = {} ---@type oneiroi.hl
	for grp, enabled in pairs(groups) do
		if enabled then
			for k, v in pairs(M.get_hl(grp, palette, opts)) do
				ret[k] = v
			end
		end
	end

	return ret, groups
end

return M
