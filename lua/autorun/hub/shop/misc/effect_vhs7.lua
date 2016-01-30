ITEM.Name = "VHS-7 Particles"
ITEM.Description = "Show your support!"
ITEM.StorePrice = 1
ITEM.Buyable = false
ITEM.Effect = "vhs7_red"
ITEM.EffectIcon = "vhs7/particles/vhs7_red"
ITEM.Interval = 0.15
ITEM.DonatorReward = true

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