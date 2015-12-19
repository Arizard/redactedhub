ITEM.Name = "Go and kiss"
ITEM.Description = "your mother's behind"
ITEM.StorePrice = 90
ITEM.TauntSound = "taunts/kiss_mothers_behind.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end