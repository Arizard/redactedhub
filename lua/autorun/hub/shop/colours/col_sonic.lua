ITEM.Name = "Sonic Paint"
ITEM.Description = "Colours you fazt."
ITEM.StorePrice = 200
ITEM.Col = Color(2,42,212)

function ITEM:OnEquip(ply, id)
	local col = self.Col

	local r = col.r/255
	local g = col.g/255
	local b = col.b/255

	local c = Vector( r,g,b )
	
	
	ply:SetPlayerColor(c)
	//print("LALALALALAL",ply:GetMaterial())

	if ply:GetMaterial() != "" then
		ply:SetColor(self.Col)
	end
end

function ITEM:OnHolster(ply, id)
	ply:SetColor(Color(255,255,255))
	ply:SetPlayerColor(Vector(0,0,0))
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end