ITEM.Name = "Fast Zombie"
ITEM.Description = [[Aim for the head.]]
ITEM.StorePrice = 500
ITEM.PlayerModel = "models/player/zombie_fast.mdl"

function ITEM:OnEquip(ply, id)
	timer.Simple(1, function() 
		ply:SetModel(self.PlayerModel)
		ply:SetupHands( ply )
	end)
end

if engine.ActiveGamemode() == "murder" then
     ITEM.Buyable = false
end

function ITEM:OnHolster(ply, id)
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end