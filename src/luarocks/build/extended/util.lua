local util = {}

function util.tryrequire(...)
    local lastErr
    for _, n in ipairs({...}) do
        local ok, m = pcall(function() return require(n) end)
        if ok then return m else lastErr = m end
    end
    error(lastErr)
end


return util
