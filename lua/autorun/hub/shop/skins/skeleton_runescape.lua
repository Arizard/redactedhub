ITEM.Name = "Runescape Skele"
ITEM.Description = [[Bones 4 prayer lvl pls]]
ITEM.StorePrice = 1000
ITEM.PlayerModel = "models/player/runescape/skeleton.mdl"
ITEM.Buyable = false

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