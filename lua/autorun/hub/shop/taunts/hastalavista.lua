ITEM.Name = "Hasta la Vista"
ITEM.Description = "Baby!"
ITEM.StorePrice = 90
ITEM.TauntSound = "taunts/hasta_la_vista.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end