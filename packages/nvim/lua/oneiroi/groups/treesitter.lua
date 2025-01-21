local M = {}

---@type oneiroi.hler
function M.get(c, opts)
    local ret = {
        ["@annotation"]                 = "PreProc",
        ["@attribute"]                  = "PreProc",
        ["@boolean"]                    = "Boolean",
        ["@character"]                  = "Character",
        ["@character.printf"]           = "SpecialChar",
        ["@character.special"]          = "SpecialChar",
        ["@comment"]                    = "Comment",
        ["@comment.error"]              = { fg = c.diagError },
        ["@comment.hint"]               = { fg = c.diagHint },
        ["@comment.info"]               = { fg = c.diagInfo },
        ["@comment.note"]               = { fg = c.diagHint },
        ["@comment.todo"]               = { fg = c.diagInfo },
        ["@comment.warning"]            = { fg = c.diagWarning },
        ["@constant"]                   = "Constant",
        -- ["@constant.builtin"]
        ["@constant.macro"]             = "Define",
        ["@constructor"]                = "Special",
        -- ["@constructor.tsx"]
        ["@diff.delta"]                 = "DiffChange",
        ["@diff.minus"]                 = "DiffDelete",
        ["@diff.plus"]                  = "DiffAdd",
        ["@function"]                   = "Function",
        -- ["@function.builtin"]
        ["@function.call"]              = "@function",
        ["@function.macro"]             = "Macro",
        ["@function.method"]            = "Function",
        ["@function.method.call"]       = "@function.method",
        ["@keyword"]                    = "Keyword",
        ["@keyword.conditional"]        = "Conditional",
        ["@keyword.coroutine"]          = "@keyword",
        ["@keyword.debug"]              = "Debug",
        ["@keyword.directive"]          = "PreProc",
        ["@keyword.directive.define"]   = "Define",
        ["@keyword.exception"]          = "Exception",
        ["@keyword.function"]           = "@keyword",
        ["@keyword.import"]             = "Include",
        ["@keyword.operator"]           = "@operator",
        ["@keyword.repeat"]             = "Repeat",
        ["@keyword.return"]             = "@keyword",
        ["@keyword.storage"]            = "StorageClass",
        ["@label"]                      = "Label",
        ["@markup"]                     = "@none",
        ["@markup.emphasis"]            = { italic = true },
        ["@markup.environment"]         = "Macro",
        ["@markup.environment.name"]    = "Type",
        ["@markup.heading"]             = "Title",
        ["@markup.italic"]              = { italic = true },
        ["@markup.link"]                = { fg = c.tertiary },
        ["@markup.link.label"]          = "SpecialChar",
        ["@markup.link.label.symbol"]   = "Identifier",
        ["@markup.link.url"]            = "Underlined",
        ["@markup.list"]                = "Delimiter",
        ["@markup.list.checked"]        = { fg = c.suc },
        ["@markup.list.markdown"]       = { fg = c.ora, bold = true },
        ["@markup.list.unchecked"]      = { fg = c.muted },
        ["@markup.math"]                = "Special",
        ["@markup.raw"]                 = "String",
        ["@markup.raw.markdown_inline"] = { bg = c.bg, fg = c.yel_s },
        ["@markup.strikethrough"]       = { strikethrough = true },
        ["@markup.strong"]              = { bold = true },
        ["@markup.underline"]           = { underline = true },
        ["@module"]                     = "Include",
        -- ["@module.builtin"]
        -- ["@namespace.builtin"]
        ["@none"]                       = {},
        ["@number"]                     = "Number",
        ["@number.float"]               = "Float",
        ["@operator"]                   = "Operator",
        -- ["@property"]                   = { fg = c.primary_s },
        ["@property"]                   = "Special",
        ["@punctuation.bracket"]        = "Delimiter",
        ["@punctuation.delimiter"]      = "Delimiter",
        -- ["@punctuation.special"]
        -- ["@punctuation.special.markdown"]
        ["@string"]                     = "String",
        ["@string.documentation"]       = "SpecialChar",
        ["@string.escape"]              = "SpecialChar",
        ["@string.regexp"]              = "SpecialChar",
        ["@tag"]                        = "Label",
        ["@tag.attribute"]              = "@property",
        ["@tag.delimiter"]              = "Delimiter",
        -- ["@tag.delimiter.tsx"]
        -- ["@tag.tsx"]
        -- ["@tag.javascript"]
        ["@type"]                       = "Type",
        -- ["@type.builtin"]
        ["@type.definition"]            = "Typedef",
        ["@type.qualifier"]             = "@keyword",
        ["@variable"]                   = "Identifier",
        -- ["@variable.builtin"]
        ["@variable.member"]            = "Proprety",
        ["@variable.parameter"]         = { fg = c.fg_s },
        -- ["@variable.parameter.builtin"]
    }
    return ret
end

return M
