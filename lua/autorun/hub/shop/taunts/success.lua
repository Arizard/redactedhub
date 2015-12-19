ITEM.Name = "Can't Handle Success"
ITEM.Description = "I can"
ITEM.StorePrice = 90
ITEM.TauntSound = "taunts/cant_handle_success.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end