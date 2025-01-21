---@class oneiroi.palette
local M = {
    fg = "#FFFDEB",
    com = "#53575B",
    red = "#FFAACA",
    ora = "#FFB5AA",
    yel = "#FFDFAA",
    gre = "#CAFFAA",
    aqu = "#AAFFDF",
    blu = "#AACAFF",
    pur = "#DFAAFF",
    sel = "#282D32",
    cur = "#282D32",
    bg = "#343A41",

    fg_s = "#C2C3B8",
    com_s = "#717574",
    red_s = "#B1768C",
    ora_s = "#B17D76",
    yel_s = "#B19B76",
    gre_s = "#8CB176",
    aqu_s = "#76B19B",
    blu_s = "#768CB1",
    pur_s = "#9B76B1",
    bac_s = "#5A6571",

    bg2 = "#282D32",
    bg3 = "#1F1D21",

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
