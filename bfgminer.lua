-- {{{ Grab environment
local tonumber = tonumber
local math = { ceil = math.ceil }
local setmetatable = setmetatable
local helpers = require("vicious.helpers")
-- }}}
local socket = require("socket") -- luasocket
local json = require("json")     -- luajson




local function worker(format, warg)
        if type(warg) ~= "table" or #warg < 2 then return end -- check if args are ok (host,port)
        local bfginfo = {}
        c = assert(socket.connect(warg[1], warg[2]))
        assert(c:send(json.encode({["command"]="summary"})))
        l, e = c:receive("*a")
        l=string.sub(l,1,-2) -- remove last char
        local value = {}
        if(e==nil) then
            objAsTable = json.decode(l)
            lcc =objAsTable["SUMMARY"]
            lcc=lcc[1]
            --print(objAsTable)
            for k,v in pairs(lcc) do bfginfo["{"..k.."}"]=v end

        end
    return bfginfo
end
-- }}}

return setmetatable(bfgminer, { __call = function(_, ...) return worker(...) end })

