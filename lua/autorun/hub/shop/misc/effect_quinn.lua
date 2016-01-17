ITEM.Name = "QuinnFace"
ITEM.Description = "R.I.P Quinn"
ITEM.StorePrice = 200
ITEM.Buyable = false
ITEM.Effect = "quinnface"
ITEM.EffectIcon = "vhs7/particles/quinnface"
ITEM.Interval = 0.15

function ITEM:OnEquip(ply, id)
	if SERVER then
		RS:AddEffect( ply, self.Class )
	end
end

function ITEM:OnHolster(ply, id)
	if SERVER then
		RS:RemoveEffect( ply, self.Class )
	end
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end