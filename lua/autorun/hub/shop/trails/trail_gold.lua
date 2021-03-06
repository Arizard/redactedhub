ITEM.Name = "Golddust"
ITEM.Description = "Gold Trail"
ITEM.StorePrice = 1000
ITEM.Trail = "models/player/shared/gold_player.vmt"
ITEM.Col = Color(100,100,255)
ITEM.Buyable = false
ITEM.Rarity = 5

function ITEM:OnEquip(ply, id)
	if ply[self.Name] then
		SafeRemoveEntity(ply[self.Name])
	end
	ply[self.Name] = util.SpriteTrail( ply, 0, self.Col, true, 16, 0, 0.5, 1 / (32*0.5), self.Trail)
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