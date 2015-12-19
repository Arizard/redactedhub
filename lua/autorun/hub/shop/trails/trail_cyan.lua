ITEM.Name = "Cyan Trail"
ITEM.Description = "W A V E"
ITEM.StorePrice = 100
ITEM.Trail = "trails/color.vmt"
ITEM.Col = Color(0,255,255)

function ITEM:OnEquip(ply, id)
	if ply[self.Name] then
		SafeRemoveEntity(ply[self.Name])
	end
	ply[self.Name] = util.SpriteTrail( ply, 0, self.Col, false, 16, 0, 0.75, 1 / (16*0.5), self.Trail)
end

function ITEM:OnHolster(ply, id)
	SafeRemoveEntity(ply[self.Name])
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end