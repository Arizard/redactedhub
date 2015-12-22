ITEM.Name = "Missing"
ITEM.Description = "Developer Crate"
ITEM.StorePrice = 120
ITEM.Trail = "debug/debugempty.vmt"
ITEM.Col = Color(255,255,255)
ITEM.Buyable = false

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