ITEM.Name = "Dear God"
ITEM.Description = "No!"
ITEM.StorePrice = 60
ITEM.TauntSound = "taunts/dear_god.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end