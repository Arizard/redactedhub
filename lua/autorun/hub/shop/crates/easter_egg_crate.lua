ITEM.Name = "Easter Egg"
ITEM.IsCrate = true
ITEM.Description = "Egg"
ITEM.CrateModel = "models/props_phx/misc/egg.mdl"
--ITEM.CrateMat = "debug/debugempty.vmt"
ITEM.Sellable = false
ITEM.StorePrice = 200
ITEM.Col = Color(241, 196, 15)
ITEM.IconFOV = 7
ITEM.IconPosOff = Vector(0,0,7)
ITEM.CrateContains = {
	['col_red'] = 20,
	['col_blue'] = 20,
	['white'] = 10,
	['easer_egg_crate'] = 5,
	['trail_vaporgrid_cyan'] = 10,
	['trail_vaporgrid_magenta'] = 10,
	['electrictrail'] = 10,
	['lasertrail'] = 10,
	['phystrail'] = 10,
	['smoketrail'] = 10,
	['trail_black'] = 8,
	['trail_blue'] = 8,
	['trail_green'] = 8,
	['trail_purple'] = 8,
	['trail_red'] = 8,
	['trail_white'] = 5,
	['trail_yellow'] = 5,
	['3dglasses'] = 4,
	['antlers'] = 5,
	['aviators'] = 5,
	['catears'] = 5,
	['fedora'] = 5,
	['horsemask'] = 2,
	['horsemask3'] = 2,
	['sombrero'] = 2,
	['vikinghelmet'] = 2,
	['witchhat'] = 2,
	['tophat'] = 2,
	['trail_missing'] = 2,
	['stripemat'] = 1,
	['pinemat'] = 1,
	['daftpunk_guy'] = 1,
	['daftpunk_thomas'] = 1,

}

function ITEM:OnEquip(ply, id)
	
end

function ITEM:OnHolster(ply, id)
	
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end
