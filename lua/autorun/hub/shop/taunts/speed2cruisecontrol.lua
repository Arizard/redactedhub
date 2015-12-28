ITEM.Name = "Speed 2: Cruise Control"
ITEM.Description = "Starring Sandra Bullock"
ITEM.StorePrice = 100
ITEM.TauntSound = "taunts/speed2cruisecontrol.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end