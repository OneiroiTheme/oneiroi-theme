---@class oneiroi.palette
local M = {
    fg = "#FFFDEB",
    com = "#3C3D4E",
    red = "#FB6BB0",
    ora = "#FF6E6B",
    yel = "#FBB66B",
    gre = "#B0FB6B",
    aqu = "#6BFBB6",
    blu = "#6BB0FB",
    pur = "#B66BFB",
    sel = "#121323",
    cur = "#121323",
    bg = "#1A1B32",

    fg_s = "#BAB9B3",
    com_s = "#5F5F69",
    red_s = "#CD5790",
    ora_s = "#CD5957",
    yel_s = "#CD9457",
    gre_s = "#90CD57",
    aqu_s = "#57CD94",
    blu_s = "#5790CD",
    pur_s = "#9457CD",
    bac_s = "#2E3059",

    bg2 = "#121323",
    bg3 = "#0A0B14",

    war = "#FFFA6A",
    war_s = "#AAA746",
    suc = "#6FFF6A",
    suc_s = "#4AAA46",
    err = "#FF6A6F",
    err_s = "#AA464A",
    inf = "#6A6FFF",
    inf_s = "#464AAA",
}
M.primary = M.red
M.secondary = M.yel
M.tertiary = M.aqu
M.quaternary = M.pur
M.quinary = M.blu
M.senary = M.gre
M.primary_s = M.red_s
M.secondary_s = M.yel_s
M.tertiary_s = M.aqu_s
M.quaternary_s = M.pur_s
M.quinary_s = M.blu_s
M.senary_s = M.gre_s

M.none = "NONE"
M.cursor = M.primary
M.border = M.bg3
M.muted = M.com
M.muted_s = M.com_s

M.diagInfo = M.inf
M.diagHint = M.pur
M.diagWarning = M.war
M.diagSuccess = M.suc
M.diagError = M.err

M.diffAdd = M.gre
M.diffChange = M.yel
M.diffDelete = M.red
M.diffText = M.blu

return M
