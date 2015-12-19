ITEM.Name = "Ram it into"
ITEM.Description = "your stomach"
ITEM.StorePrice = 120
ITEM.TauntSound = "taunts/ram_stomach.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end