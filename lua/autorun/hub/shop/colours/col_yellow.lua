ITEM.Name = "Sunflower Paint"
ITEM.Description = "Colours you yellow."
ITEM.StorePrice = 30
ITEM.Col = Color(241, 196, 15)


function ITEM:OnEquip(ply, id)
	local col = self.Col

	local r = col.r/255
	local g = col.g/255
	local b = col.b/255

	local c = Vector( r,g,b )
	
	ply:SetColor(self.Col)
	ply:SetPlayerColor(c)
end

function ITEM:OnHolster(ply, id)
	ply:SetColor( Color(255,255,255) )
	ply:SetPlayerColor(Vector(1,1,1))
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end