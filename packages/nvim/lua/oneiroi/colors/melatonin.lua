---@class oneiroi.palette
local M = {
    fg = "#FFFDEB",
    com = "#5B5B66",
    red = "#FB6BB0",
    ora = "#FF6E6B",
    yel = "#FBB66B",
    gre = "#B0FB6B",
    aqu = "#6BFBB6",
    blu = "#6BB0FB",
    pur = "#B66BFB",
    sel = "#222341",
    cur = "#222341",
    bg = "#1A1B32",

    fro_s = "#BCBBB5",
    com_s = "#7B7B80",
    red_s = "#CD5790",
    ora_s = "#CD5957",
    yel_s = "#CD9457",
    gre_s = "#90CD57",
    aqu_s = "#57CD94",
    blu_s = "#5790CD",
    pur_s = "#9457CD",
    bac_s = "#2E3059",

    bg2 = "#222341",
    bg3 = "#0A0B14",

    war = "#FBFB70",
    war_s = "#BABA70",
    suc = "#CAFFAA",
    suc_s = "#8CBA76",
    err = "#FF2525",
    err_s = "#BA1B1B",
}
M.primary = M.red
M.secondary = M.aqu
M.tertiary = M.yel
M.quaternary = M.pur
M.quinary = M.blu
M.senary = M.gre
M.primary_s = M.red_s
M.secondary_s = M.aqu_s
M.tertiary_s = M.yel_s
M.quaternary_s = M.pur_s
M.quinary_s = M.blu_s
M.senary_s = M.gre_s

M.none = "NONE"
M.cursor = M.primary
M.border = M.bg3
M.muted = M.com
M.muted_s = M.com_s

M.diagInfo = M.blu_s
M.diagHint = M.aqu_s
M.diagWarning = M.yel_s
M.diagSuccess = M.gre_s
M.diagError = M.red_s

M.diffAdd = M.gre_s
M.diffChange = M.yel_s
M.diffDelete = M.red_s
M.diffText = M.blu_s

return M
