---@class oneiroi.palette
local M = {
	fg = "#FFFDEB",
	com = "#827C8E",
	red = "#FFAACA",
	ora = "#FFB5AA",
	yel = "#FFDFAA",
	gre = "#CAFFAA",
	aqu = "#AAFFDF",
	blu = "#AACAFA",
	pur = "#DFAAFF",
	sel = "#282D32",
	cur = "#282D32",
	bg = "#343A41",

	fro_s = "#C9CBDA",
	com_s = "#B0A8C0",
	red_s = "#B1768C",
	ora_s = "#B17D76",
	yel_s = "#B19B76",
	gre_s = "#8CBA76",
	aqu_s = "#76B19B",
	blu_s = "#768CB1",
	pur_s = "#9B76B1",
	bac_s = "#5A6571",

	bg2 = "#282D32",
	bg3 = "#1F1D21",

	war = "#FBFB70",
	war_s = "#BABA70",
	suc = "#CAFFAA",
	suc_s = "#8CBA76",
	err = "#FF2525",
	err_s = "#BA1B1B",
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
