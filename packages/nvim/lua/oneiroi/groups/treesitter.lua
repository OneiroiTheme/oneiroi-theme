local M = {}

---@type oneiroi.hler
function M.get(c, opts)
    -- stylua: ignore
    local ret = {
        ["@annotation"]               = "PreProc",
        ["@attribute"]                = "PreProc",
        ["@boolean"]                  = "Boolean",
        ["@character"]                = "Character",
        ["@character.printf"]         = "SpecialChar",
        ["@character.special"]        = "SpecialChar",
        ["@comment"]                  = "Comment",
        -- ["@comment.error"]            = { fg = c.error },
        -- ["@comment.hint"]             = { fg = c.hint },
        -- ["@comment.info"]             = { fg = c.info },
        -- ["@comment.note"]             = { fg = c.hint },
        -- ["@comment.todo"]             = { fg = c.todo },
        -- ["@comment.warning"]          = { fg = c.warning },
        ["@constant"]                 = "Constant",
        ["@constant.builtin"]         = "Special",
        ["@constant.macro"]           = "Define",
        ["@constructor"]              = "Special",
        ["@constructor.tsx"]          = "Special",
        ["@diff.delta"]               = "DiffChange",
        ["@diff.minus"]               = "DiffDelete",
        ["@diff.plus"]                = "DiffAdd",
        ["@function"]                 = "Function",
        ["@function.builtin"]         = "Special",
        ["@function.call"]            = "@function",
        ["@function.macro"]           = "Macro",
        ["@function.method"]          = "Function",
        ["@function.method.call"]     = "@function.method",
        ["@keyword"]                  = "Keyword",
        ["@keyword.conditional"]      = "Conditional",
        ["@keyword.coroutine"]        = "@keyword",
        ["@keyword.debug"]            = "Debug",
        ["@keyword.directive"]        = "PreProc",
        ["@keyword.directive.define"] = "Define",
        ["@keyword.exception"]        = "Exception",
        ["@keyword.function"]         = "@keyword",
        ["@keyword.import"]           = "Include",
        ["@keyword.operator"]         = "@operator",
        ["@keyword.repeat"]           = "Repeat",
        ["@keyword.return"]           = "@keyword",
        ["@keyword.storage"]          = "StorageClass",
        ["@label"]                    = "Label",
        ["@markup"]                   = "@none",
        ["@markup.emphasis"]          = { italic = true },
        ["@markup.environment"]       = "Macro",
        ["@markup.environment.name"]  = "Type",
        ["@markup.heading"]           = "Title",
        ["@markup.italic"]            = { italic = true },
        ["@markup.link"]              = { fg = c.tertiary },
        ["@markup.link.label"]        = "SpecialChar",
        ["@markup.link.label.symbol"] = "Identifier",
        ["@markup.link.url"]              = "Underlined",
        ["@markup.list"]                  = "Delimiter",  -- For special punctutation that does not fall in the categories before.
        -- ["@markup.list.checked"]          = { fg = c.green1 }, -- For brackets and parens.
        -- ["@markup.list.markdown"]         = { fg = c.orange, bold = true },
        -- ["@markup.list.unchecked"]        = { fg = c.blue },   -- For brackets and parens.
        ["@markup.math"]                  = "Special",
        ["@markup.raw"]                   = "String",
        -- ["@markup.raw.markdown_inline"]   = { bg = c.terminal_black, fg = c.blue },
        ["@markup.strikethrough"]         = { strikethrough = true },
        ["@markup.strong"]                = { bold = true },
        ["@markup.underline"]             = { underline = true },
        ["@module"]                       = "Include",
        -- ["@module.builtin"]               = { fg = c.red }, -- Variable names that are defined by the languages, like `this` or `self`.
        ["@namespace.builtin"]            = "@variable.builtin",
        ["@none"]                         = {},
        ["@number"]                       = "Number",
        ["@number.float"]                 = "Float",
        ["@operator"]                     = "Operator",   -- For any operator: `+`, but also `->` and `*` in C.
        ["@property"]                     = { fg = c.primary_s },
        -- ["@punctuation.bracket"]          = { fg = c.fg_dark }, -- For brackets and parens.
        -- ["@punctuation.delimiter"]        = { fg = c.blue5 },   -- For delimiters ie: `.`
        -- ["@punctuation.special"]          = { fg = c.blue5 },   -- For special symbols (e.g. `{}` in string interpolation)
        -- ["@punctuation.special.markdown"] = { fg = c.orange },  -- For special symbols (e.g. `{}` in string interpolation)
        ["@string"]                       = "String",
        -- ["@string.documentation"]         = { fg = c.yellow },
        -- ["@string.escape"]                = { fg = c.magenta }, -- For escape characters within a string.
        ["@string.regexp"]                = "SpecialChar",   -- For regexes.
        ["@tag"]                          = "Label",
        ["@tag.attribute"]                = "@property",
        ["@tag.delimiter"]                = "Delimiter",
        -- ["@tag.delimiter.tsx"]            = { fg = Util.blend_bg(c.blue, 0.7) },
        -- ["@tag.tsx"]                      = { fg = c.red },
        -- ["@tag.javascript"]               = { fg = c.red },
        ["@type"]                         = "Type",
        -- ["@type.builtin"]                 = { fg = Util.blend_bg(c.blue1, 0.8) },
        ["@type.definition"]              = "Typedef",
        ["@type.qualifier"]               = "@keyword",
        ["@variable"]                     = "Identifier", -- Any variable name that does not have another highlight.
        -- ["@variable.builtin"]             = { fg = c.red },                               -- Variable names that are defined by the languages, like `this` or `self`.
        -- ["@variable.member"]              = { fg = c.green1 },                            -- For fields.
        -- ["@variable.parameter"]           = { fg = c.yellow },                            -- For parameters of a function.
        -- ["@variable.parameter.builtin"]   = { fg = Util.blend_fg(c.yellow, 0.8) },        -- For builtin parameters of a function, e.g. "..." or Smali's p[1-99]
    }

	-- for i, color in ipairs(c.rainbow) do
	--     ret["@markup.heading." .. i .. ".markdown"] = { fg = color, bold = true }
	-- end
	return ret
end

return M
