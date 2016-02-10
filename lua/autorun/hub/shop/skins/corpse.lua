ITEM.Name = "Corpse"
ITEM.Description = "Who were you?"
ITEM.StorePrice = 290
ITEM.PlayerModel = "models/player/corpse1.mdl"

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