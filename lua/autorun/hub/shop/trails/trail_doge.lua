ITEM.Name = "Doge"
ITEM.Description = "Such Trail. Wow."
ITEM.StorePrice = 75
ITEM.Trail = "trails/dogetrail.vmt"
ITEM.Col = Color(255,255,255)

function ITEM:OnEquip(ply, id)
	if ply[self.Name] then
		SafeRemoveEntity(ply[self.Name])
	end
	ply[self.Name] = util.SpriteTrail( ply, 0, Color(255,255,255, 255), false, 24, 0, 0.75, 1 / (32*0.5), self.Trail)
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