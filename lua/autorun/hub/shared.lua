print("Loaded shared.lua")


local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+='
function Base64Encode(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

function Base64Decode(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

function QuadLerp( frac, p1, p2 )

    local y = (p1-p2) * (frac -1)^2 + p2
    return y

end

function InverseLerp( pos, p1, p2 )

    local range = 0
    range = p2-p1

    if range == 0 then return 1 end

    return ((pos - p1)/range)

end

local hexvals = {
    ["0"] = 0,
    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
    ["A"] = 10,
    ["B"] = 11,
    ["C"] = 12,
    ["D"] = 13,
    ["E"] = 14,
    ["F"] = 15,
}

function Hex( hex ) -- utility functions

    hex = string.upper( hex )
    hex = string.Split( hex, "" )

    local num = 0

    for i = 1, #hex do
        local h = hex[i]
        local v = hexvals[h]

        v = v * (16^(#hex-i))
        num = num + v
    end

    return num

end

function HexColor(hex, alpha)

    if string.sub(hex, 1, 1) ~= "#" then return Color(255,255,255,255) end

    hex = string.Replace(hex, "#", "") -- remove #

    local ct = {}
    local len = string.len( hex )
    if len ~= 3 and len ~= 6 then return Color(255,255,255,255) end

    for i=1,3 do
        local l2 = len/3
        local m = 1
        ct[i] = Hex( string.sub(hex, l2*i -m, l2*i) )
    end
    --PrintTable(ct)
    return Color( ct[1], ct[2], ct[3], alpha or 255)

end
