local M = {}

---@type oneiroi.hler
function M.get(c, opts)
	local bg = opts.transparent and c.none or c.bg
	local bg2 = c.bg2
	local bgSta = c.bg2
	local vis = c.primary_s
	local border = c.bg3
	return {
		-- BufferLineOffsetSeparator = { fg = border },
		-- BufferLineFill = { fg = c.muted, bg = bgSta },
		-- BufferLineBackground = "BufferLineFill",
		-- BufferLineBufferVisible = "BufferLineBackground",
		-- BufferLineBufferSelected = { bg = bg },
	}
end

return M
