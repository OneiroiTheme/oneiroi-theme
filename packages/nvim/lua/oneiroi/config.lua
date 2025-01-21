local M = {}

M.version = "0.0.1"

---@class oneiroi.config
---@field style oneiroi.style
M.defaults = {
	style = "dream",
	transparent = false,
	italic_comments = false,
	underline_links = false,
	disable_nvimtree_bg = true,
	terminal_colors = true,

	-- custom highlights --
	colors = {},
	highlights = {},
}

---@type oneiroi.config
M.options = nil

---@param opts? oneiroi.config
M.setup = function(opts)
	M.options = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
end

---@param opts? oneiroi.config
function M.extend(opts)
	return opts and vim.tbl_deep_extend("force", {}, M.options, opts) or M.options
end

setmetatable(M, {
	__index = function(_, k)
		if k == "options" then
			return M.defaults
		end
	end,
})
return M
