local M = {}

---@type oneiroi.hler
function M.get(c, opts)
    return {
        Foo                         = { bg = c.bg, fg = c.primary },

        ColorColumn                 = { bg = c.black },                             -- used for the columns set with 'colorcolumn'
        Conceal                     = { fg = c.dark },                              -- placeholder characters substituted for concealed text (see 'conceallevel')
        Cursor                      = { fg = c.cursor, bg = c.bg, reverse = true }, -- character under the cursor
        lCursor                     = { fg = c.cursor, bg = c.bg, reverse = true }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
        CursorIM                    = { fg = c.cursor, bg = c.bg, reverse = true }, -- like Cursor, but used when in IME mode |CursorIM|
        CursorColumn                = { bg = c.bgDark },                            -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine                  = { bg = c.bgDark },                            -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        Directory                   = { fg = c.primaryDark, bold = true },          -- directory names (and other special names in listings)
        DiffAdd                     = { fg = c.greenDark, reverse = true },
        DiffChange                  = { fg = c.yellowDark, reverse = true },
        DiffDelete                  = { fg = c.redDark, reverse = true },
        DiffText                    = { fg = c.blueDark, reverse = true },
        EndOfBuffer                 = { fg = c.bg },

        ErrorMsg                    = { fg = c.diagError },                                           -- error messages on the command line
        VertSplit                   = { fg = c.border },                                              -- the column separating vertically split windows
        WinSeparator                = { fg = c.border, bold = true },                                 -- the column separating vertically split windows
        Folded                      = { fg = c.mutedDark, bg = c.bgDark },                            -- line used for closed folds
        FoldColumn                  = { bg = opts.transparent and c.none or c.bg, fg = c.mutedDark }, -- 'foldcolumn'
        SignColumn                  = { bg = opts.transparent and c.none or c.bg, fg = c.muted },     -- column where |signs| are displayed
        SignColumnSB                = { bg = c.bgSB, fg = c.gray },                                   -- column where |signs| are displayed
        Substitute                  = { bg = c.red, fg = c.black },                                   -- |:substitute| replacement text highlighting
        LineNr                      = { fg = c.muted },                                               -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr                = { fg = c.secondary, bold = true },                              -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        LineNrAbove                 = { fg = c.primaryDark },
        LineNrBelow                 = { fg = c.primaryDark },
        MatchParen                  = { fg = c.bg, bg = c.fg, bold = true },                   -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg                     = { fg = c.fgDark, bold = true },                          -- 'showmode' message (e.g., "-- INSERT -- ")
        MsgArea                     = { fg = c.fgDark },                                       -- Area for messages and cmdline
        MoreMsg                     = { fg = c.primary },                                      -- |more-prompt|
        NonText                     = { fg = c.mutedDark },                                    -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal                      = { fg = c.fg, bg = opts.transparent and c.none or c.bg }, -- normal text
        NormalNC                    = { fg = c.fg, bg = opts.transparent and c.none or c.bg }, -- normal text in non-current windows
        NormalSB                    = { fg = c.fgSB, bg = c.bgDark },                          -- normal text in sidebar
        NormalFloat                 = { fg = c.fg, bg = c.bgDark },                            -- Normal text in floating windows.
        FloatBorder                 = { fg = c.border, bg = c.bg },
        FloatTitle                  = { fg = c.border, bg = c.bg },
        Pmenu                       = { fg = c.fg, bg = c.bgDark },             -- Popup menu: normal item.
        PmenuSel                    = { fg = c.bgDark, bg = c.primaryDark },    -- Popup menu: selected item.
        PmenuSbar                   = { bg = c.muted },                         -- Popup menu: scrollbar.
        PmenuThumb                  = { bg = c.secondaryDark },                 -- Popup menu: Thumb of the scrollbar.
        Question                    = { fg = c.tertiary },                      -- |hit-enter| prompt and yes/no questions
        QuickFixLine                = { bg = c.bgVisual, bold = true },         -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search                      = { bg = c.bgSearch, bold = true },         -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        IncSearch                   = { bg = c.tertiary, fg = c.bg },           -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        CurSearch                   = "IncSearch",
        SpecialKey                  = { fg = c.primaryDark },                   -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad                    = { sp = c.diagError, undercurl = true },   -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap                    = { sp = c.diagWarning, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal                  = { sp = c.diagInfo, undercurl = true },    -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare                   = { sp = c.diagHint, undercurl = true },    -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        StatusLine                  = { fg = c.fgSB, bg = c.bgSta },            -- status line of current window
        StatusLineNC                = { fg = c.muted, bg = c.bgSta },           -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        TabLine                     = { fg = c.mutedDark, bg = c.bgSta },       -- tab pages line, not active tab page label
        TabLineFill                 = { bg = c.bgSta },                         -- tab pages line, where there are no labels
        TabLineSel                  = { fg = c.secondary, bg = c.bg },          -- tab pages line, active tab page label
        Title                       = { fg = c.primary, bold = true },          -- titles for output from ":set all", ":autocmd" etc.
        Visual                      = { bg = c.bgVisual },                      -- Visual mode selection
        VisualNOS                   = { bg = c.bgVisual },                      -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg                  = { fg = c.diagWarning },                   -- warning messages
        Whitespace                  = { fg = c.muted },                         -- "nbsp", "space", "tab" and "trail" in 'listchars'
        WildMenu                    = { bg = c.bgVisual },                      -- current match in 'wildmenu' completion
        WinBar                      = "StatusLine",                             -- window bar
        WinBarNC                    = "StatusLineNC",                           -- window bar in inactive windows

        Bold                        = { bold = true },                          -- (preferred) any bold text
        Character                   = { fg = c.secondary },                     --  a character constant: 'c', '\n'
        Constant                    = { fg = c.secondary },                     -- (preferred) any constant
        Comment                     = { fg = c.mutedDark },                     -- any comment
        --Debug                       = { fg = c.orange },                                 --    debugging statements
        Delimiter                   = "Special",                                --  character that needs attention
        Error                       = { fg = c.diagError },                     -- (preferred) any erroneous construct
        Function                    = { fg = c.tertiary },                      -- function name (also: methods for classes)
        Identifier                  = { fg = c.primary },                       -- (preferred) any variable name
        Italic                      = { italic = true },                        -- (preferred) any italic text
        Keyword                     = { fg = c.red },                           --  any other keyword
        Operator                    = { fg = c.red },                           -- "sizeof", "+", "*", etc.
        PreProc                     = { fg = c.gray },                          -- (preferred) generic Preprocessor
        PreCondit                   = { fg = c.primary },
        Special                     = { fg = c.primary },                       -- (preferred) any special symbol
        Statement                   = { fg = c.primary },                       -- (preferred) any statement
        String                      = { fg = c.secondary },                     --   a string constant: "this is a string"
        Todo                        = { bg = c.senaryDark, fg = c.bg },         -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
        Type                        = { fg = c.primary },                       -- (preferred) int, long, char, etc.
        Underlined                  = { underline = true },                     -- (preferred) text that stands out, HTML links
        debugBreakpoint             = { fg = c.primary, bg = c.bg },            -- used for breakpoint colors in terminal-debug
        debugPC                     = { bg = c.bgSB },                          -- used for highlighting the current line in terminal-debug
        dosIniLabel                 = "@property",
        --helpCommand                 = { bg = c.bgSB, fg = c.cyan },
        htmlH1                      = { fg = c.primary, bold = true },
        htmlH2                      = { fg = c.secondary, bold = true },
        qfFileName                  = { fg = c.primary },
        qfLineNr                    = { fg = c.secondary },

        -- These groups are for the native LSP client. Some other LSP clients may
        -- use these groups, or use their own.
        LspReferenceText            = { bg = c.mutedDark }, -- used for highlighting "text" references
        LspReferenceRead            = { bg = c.mutedDark }, -- used for highlighting "read" references
        LspReferenceWrite           = { bg = c.mutedDark }, -- used for highlighting "write" references
        LspSignatureActiveParameter = { bg = c.mutedDark, bold = true },
        LspCodeLens                 = { fg = c.mutedDark },
        LspInlayHint                = { fg = c.mutedDark, italic = true },
        LspInfoBorder               = { fg = c.borderHL, bg = c.bgSB },

        -- diagnostics
        DiagnosticError             = { fg = c.diagError },                     -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticWarn              = { fg = c.diagWarning },                   -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticInfo              = { fg = c.diagInfo },                      -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticHint              = { fg = c.diagHint },                      -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticUnnecessary       = { fg = c.mutedDark },                     -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticVirtualTextError  = { fg = c.diagError },                     -- Used for "Error" diagnostic virtual text
        DiagnosticVirtualTextWarn   = { fg = c.diagWarning },                   -- Used for "Warning" diagnostic virtual text
        DiagnosticVirtualTextInfo   = { fg = c.diagInfo },                      -- Used for "Information" diagnostic virtual text
        DiagnosticVirtualTextHint   = { fg = c.diagHint },                      -- Used for "Hint" diagnostic virtual text
        DiagnosticUnderlineError    = { undercurl = true, sp = c.diagError },   -- Used to underline "Error" diagnostics
        DiagnosticUnderlineWarn     = { undercurl = true, sp = c.diagWarning }, -- Used to underline "Warning" diagnostics
        DiagnosticUnderlineInfo     = { undercurl = true, sp = c.diagInfo },    -- Used to underline "Information" diagnostics
        DiagnosticUnderlineHint     = { undercurl = true, sp = c.diagHint },    -- Used to underline "Hint" diagnostics

        -- Health
        healthError                 = { fg = c.diagError },
        healthSuccess               = { fg = c.diagSuccess },
        healthWarning               = { fg = c.diagWarning },

        -- diff (not needed anymore?)
        diffAdded                   = { fg = c.diffAdd },
        diffRemoved                 = { fg = c.diffDelete },
        diffChanged                 = { fg = c.diffChange },
        diffOldFile                 = { fg = c.secondaryDark },
        diffNewFile                 = { fg = c.primaryDark },
        diffFile                    = { fg = c.diffText },
        diffLine                    = { fg = c.mutedDark },
        diffIndexLine               = { fg = c.tertiaryDark },
        helpExample                 = { fg = c.mutedDark },
    }
end

return M
