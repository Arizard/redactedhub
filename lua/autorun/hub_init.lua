print("loaded hub_init.lua")
local oldhubwindow = nil

if RS then
	if RS.HubWindow then
		oldhubwindow = RS.HubWindow
	end
end

RS = {} -- Redacted Shop aka hub



if SERVER then
	include("hub/sh_config.lua")
	include("hub/shared.lua")
	include("hub/init.lua")
	include("hub/sv_database.lua")
	include("hub/sv_commands.lua")
	AddCSLuaFile("hub/sh_config.lua")
	AddCSLuaFile("hub/shared.lua")
	AddCSLuaFile("hub/cl_menus.lua")
	AddCSLuaFile("hub/cl_jukebox_songs.lua")
	AddCSLuaFile("hub/cl_init.lua")

	--go through all the shop files, and add them to cs lua
	--folder structure is
	--hub/shop/category/unique_item_name.lua
	local files, categories = file.Find("autorun/hub/shop/*","LUA", "namedesc")

	for k,cat in ipairs(categories) do
		local itemfiles = file.Find("autorun/hub/shop/"..cat.."/*.lua", "LUA", "namedesc")

		for kk, f in ipairs(itemfiles) do
			local path = "autorun/hub/shop/"..cat.."/"..f
			local relpath = "hub/shop/"..cat.."/"..f
			AddCSLuaFile(relpath)
			print("$- Added CSLua File "..relpath)
		end
	end

end

if CLIENT then
	include("hub/sh_config.lua")
	include("hub/shared.lua")
	include("hub/cl_menus.lua")
	include("hub/cl_jukebox_songs.lua")
	include("hub/cl_init.lua")

	if not RS.ClientSideModels then
		RS.ClientSideModels = {}
	end

end

RS.PDataMoney = RS.PDataProvider

RS.Items = {}
RS.Caterogies = {}

local blank_item = {}
blank_item.Name = "Uninitialized Item"
blank_item.Description = "Uninitialized Description"
blank_item.StorePrice = 9999
blank_item.Col = Color(255,255,255)
blank_item.Material = nil
blank_item.Buyable = true
blank_item.IsToken = false
blank_item.Visible = true

function blank_item:OnSpawn()
end
function blank_item:OnDeath()
end
function blank_item:OnEquip()
end
function blank_item:OnHolster()
end

local files, categories = file.Find("autorun/hub/shop/*","LUA", "namedesc")
RS.Categories = categories
RS.ItemsOrdered = {}
local catnum = 0

for k,cat in ipairs(categories) do
	local itemfiles = file.Find("autorun/hub/shop/"..cat.."/*.lua", "LUA", "namedesc")
	PrintTable( itemfiles )

	for kk, f in ipairs(itemfiles) do
		local path = "autorun/hub/shop/"..cat.."/"..f
		local relpath = "hub/shop/"..cat.."/"..f
		local itemname = string.sub(f,1,-5)
		
		ITEM = table.Copy( blank_item )

		include(relpath)

		ITEM.Class = itemname
		ITEM.Category = cat

		if cat == "skins" then
			util.PrecacheModel( ITEM.PlayerModel )
		end

		if cat == "hats" then
			util.PrecacheModel( ITEM.HatModel )
		end

		RS.Items[itemname] = table.Copy(ITEM)
		RS.ItemsOrdered[catnum + kk] = itemname
	end
	catnum = catnum + #itemfiles
end

RS:Initialize()

if CLIENT then
	if oldhubwindow ~= nil and IsValid(oldhubwindow) then 
		oldhubwindow:Remove()
		RunConsoleCommand("hub_open2")
	end
end

--PrintTable(RS.Items)

--[[
Ordered table iterator, allow to iterate on the natural order of the keys of a
table.

Example:
]]

function __genOrderedIndex( t )
    local orderedIndex = {}
    for key in pairs(t) do
        table.insert( orderedIndex, key )
    end
    table.sort( orderedIndex )
    return orderedIndex
end

function orderedNext(t, state)
    -- Equivalent of the next function, but returns the keys in the alphabetic
    -- order. We use a temporary ordered key table that is stored in the
    -- table being iterated.

    --print("orderedNext: state = "..tostring(state) )
    if state == nil then
        -- the first time, generate the index
        t.__orderedIndex = __genOrderedIndex( t )
        key = t.__orderedIndex[1]
        return key, t[key]
    end
    -- fetch the next value
    key = nil
    for i = 1,table.getn(t.__orderedIndex) do
        if t.__orderedIndex[i] == state then
            key = t.__orderedIndex[i+1]
        end
    end

    if key then
        return key, t[key]
    end

    -- no more value to return, cleanup
    t.__orderedIndex = nil
    return
end

function orderedPairs(t)
    -- Equivalent of the pairs() function on tables. Allows to iterate
    -- in order
    return orderedNext, t, nil
end

function string.CapFirst(str)

	local len = string.len(str)
	local first = string.sub(str,1,1)
	first = string.upper(first)

	local rest = string.sub(str, 2,len)

	return first..rest

end

function ColToVec( col )

	local r = col.r/255
	local g = col.g/255
	local b = col.b/255

	return Vector( r,g,b )

end

function VecToCol( vec )

	return Color( vec.x*255, vec.y * 255, vec.z*255 )

end

function QuadLerp( frac, p1, p2 )

	local y = (p1-p2) * (frac -1)^2 + p2
	return y

end

