---@class oneiroi.Highlights: vim.api.keyset.hightlight
---@field style? vim.api.keyset.highlight

---@alias oneiroi.hl table<string,oneiroi.Highlights|string>
---@alias oneiroi.hler  fun(c: oneiroi.palette, opts:oneiroi.config):oneiroi.hl
---@alias oneiroi.style "dream" | "base"
