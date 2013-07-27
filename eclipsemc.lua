-- {{{ Grab environment
local tonumber = tonumber
local math = { ceil = math.ceil }
local setmetatable = setmetatable
local helpers = require("vicious.helpers")
-- }}}

-- load required modules
local https = require("ssl.https") --luasec
local ltn12 = require("ltn12")
local mime = require("mime")
local json = require("json") -- luajson

local eclipsemc = {}


local response = {}
local save = ltn12.sink.table(response) -- need a l1tn12 sink to get back the page content


local function worker(format, warg)
    if not warg then return end
        -- Default values
        local eclinfo = {
            ["{CR}"] = 0, -- confirmed reward
            ["{UR}"] = 0, -- unconfirmed reward
            ["{ER}"] = 0, -- estimated reward
            ["{TP}"] = 0, -- total payout
            ["{BF}"] = 0  -- block found

        }
        --- send the request
        ok, code, headers = https.request{url = "https://eclipsemc.com/api.php?action=userstats&key="..warg, method = "POST", headers = h, sink = save}
        if(ok==1 and code==200) then
            saveditem = response[1];
            --- convert from json to lua object
            if(pcall(function() objAsTable=json.decode(saveditem) end)) then -- protect your ass from parsing/encoding errors
                local data=objAsTable["data"]["user"]
                eclinfo["{CR}"] =   tonumber(string.format ("%3.3f",data["confirmed_rewards"])) -- idiot formatting stuff
                eclinfo["{UR}"] =   tonumber(string.format ("%3.3f",data["unconfirmed_rewards"]))
                eclinfo["{ER}"] =   tonumber(string.format ("%3.3f",data["estimated_rewards"]))
                eclinfo["{TP}"] =   tonumber(string.format ("%3.3f",data["total_payout"]))
                eclinfo["{BF}"] =   tonumber(string.format ("%3.3f",data["blocks_found"]))
                
                local workers=objAsTable["workers"]
                for k,v in pairs(workers) do            -- fills the table with {nameoftheworker.key}=value
                    wname= workers[k]["worker_name"]    -- es: if your worker is called Giorgio and want to know how much is grinding
                                                        --     in the format you write something like ${Giorgio.hash_rate}
                    for j,i in pairs(v) do if(wname ~= i) then eclinfo["{"..wname.."."..j.."}"]=i end end 
                end
        end
    end
    return eclinfo
end
-- }}}

return setmetatable(eclipsemc, { __call = function(_, ...) return worker(...) end })
