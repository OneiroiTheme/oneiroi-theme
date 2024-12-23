---@alias color string

---@class oneiroi.palette
---@field none color
---@field cursor color
---@field black color
---@field red color
---@field green color
---@field yellow color
---@field blue color
---@field magenta color
---@field cyan color
---@field white color
---@field blackDark color
---@field redDark color
---@field yellowDark color
---@field greenDark color
---@field blueDark color
---@field magentaDark color
---@field cyanDark color
---@field whiteDark color
---@field orange color
---@field orangeDark color
---@field dark color
---@field darkDark color
---@field gray color
---@field grayDark color
---@field red_fading color
---@field red_fadingDark color
---@field yellow_fading color
---@field yellow_fadingDark color
---@field primary color
---@field secondary color
---@field tertiary color
---@field quaternary color
---@field quinary color
---@field senary color
---@field primaryDark color
---@field secondaryDark color
---@field tertiaryDark color
---@field quaternaryDark color
---@field quinaryDark color
---@field senaryDark color
---@field diagInfo color
---@field diagHint color
---@field diagWarning color
---@field diagSuccess color
---@field diagError color
---@field diffAdd color
---@field diffChange color
---@field diffDelete color
---@field diffText color
---@field fg color
---@field fgDark color
---@field fgSB color
---@field bg color
---@field bgDark color
---@field bgHL color
---@field bgSB color
---@field bgSta color
---@field bgVisual color
---@field bgSearch color
---@field border color
---@field borderHL color
---@field muted color
---@field mutedDark color
---@field selection color
---@field selectionDark color

local M = {
    black = '#5A6571',
    red = '#FFAACA',
    green = '#CAFFAA',
    yellow = '#FFDFAA',
    blue = '#AACAFA',
    magenta = '#DFAAFF',
    cyan = '#AAFFDF',
    white = '#FFFDEB',
    blackDark = '#343A41',
    redDark = '#B1768C',
    yellowDark = '#B19B76',
    greenDark = '#8CBA76',
    blueDark = '#768CB1',
    magentaDark = '#9B76B1',
    cyanDark = '#76B19B',
    whiteDark = '#C9CBDA',

    orange = '#B17D76',
    orangeDark = '#FFB5AA',
    dark = '#282D32',
    darkDark = '#1F1D21',
    gray = '#B0A8C0',
    grayDark = '#827C8E',

    red_fading = '#7F5565',
    red_fadingDark = '#4E343E',
    yellow_fading = '#968364',
    yellow_fadingDark = '#5D513E'
}

M.none = "NONE"
M.cursor = M.primaryDark
M.primary = M.red
M.secondary = M.yellow
M.tertiary = M.cyan
M.quaternary = M.magenta
M.quinary = M.blue
M.senary = M.green
M.primaryDark = M.redDark
M.secondaryDark = M.yellowDark
M.tertiaryDark = M.cyanDark
M.quaternaryDark = M.magentaDark
M.quinaryDark = M.blueDark
M.senaryDark = M.greenDark

M.diagInfo = M.blueDark
M.diagHint = M.cyanDark
M.diagWarning = M.yellowDark
M.diagSuccess = M.greenDark
M.diagError = M.redDark

M.diffAdd = M.greenDark
M.diffChange = M.yellowDark
M.diffDelete = M.redDark
M.diffText = M.blueDark

M.fg = M.white
M.fgDark = M.whiteDark
M.fgSB = M.whiteDark
M.bg = M.blackDark
M.bgDark = M.dark
M.bgHL = M.black
M.bgSB = M.dark
M.bgSta = M.dark
M.bgVisual = M.bgDark
M.bgSearch = M.bgDark
M.border = M.darkDark
M.borderHL = M.primary
M.muted = M.gray
M.mutedDark = M.grayDark
M.selection = M.red_fading
M.selectionDark = M.red_fadingDark

return M
