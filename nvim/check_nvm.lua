-- this is not working for some reason and I have no idea why
local function nvm_exists()
    local handle = io.popen("which nvm")
    if not handle or type(handle) == "nil" then
        -- handle is nil, which means there was an error running the command
        return false
    end

    local result = handle:read("*a")
    handle:close()

    if result == "nvm not found\n" or result == "" then
        return false
    else
        return true
    end
end

if not nvm_exists() then
    os.execute("nvminit")
end
