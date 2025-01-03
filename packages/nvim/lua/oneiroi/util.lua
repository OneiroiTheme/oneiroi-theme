local M = {}

function M.mod(modname)
    if package.loaded[modname] then
        return package.loaded[modname]
    end

    local ret = loadfile(me .. "/" .. modname:gsub("%.", "/") .. ".lua")()

    package.loaded[modname] = ret

    -- 返回加载的模块
    return ret
end

return M
