ITEM.Name = "Good Shit"
ITEM.Description = "Sign me the FUCK up"
ITEM.StorePrice = 200
ITEM.Buyable = false
ITEM.Effect = "goodshit"
ITEM.EffectIcon = "vhs7/particles/100"
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