--- miatanto: crap utility for awesome3
-- @author autoscatto &lt;4utoscatto@gmail.com&gt;
--

-- environment
local type = type
local ipairs = ipairs
local table = table
local string = string
local beautiful = require("beautiful")
local awful = require("awful")
local shifty= require("shifty")
local pairs = pairs
local io = io
local tonumber = tonumber
local dbg= dbg
local capi = {
    client = client,
    tag = tag,
    image = image,
    screen = screen,
    button = button,
    mouse = mouse,
    root = root,
    timer = timer
}

module("miatanto")


--set_tagevent: add event to shifty tag (relative widget)
-- @param scrr : screen to look for tags on
-- @param tagname : tag name
-- @param eventname : event name name
-- @param funct: funct for event handler
function set_tagevent(scrr,tagname,eventname,funct)
        local tags=shifty.name2tags(tagname,scr)
        if (tags and type(tags)=='table') then
            if tags[1] then
                local ps=tonumber(awful.tag.getproperty(tags[1], "position")*2) -- 2X MAGIC!!
                local tagwidg=shifty.taglist[scrr][ps]
                if type(tagwidg) == 'widget' then
                    tagwidg:add_signal(eventname,funct)
                end
            end
        end
end