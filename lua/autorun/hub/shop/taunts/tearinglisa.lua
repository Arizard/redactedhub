ITEM.Name = "Tearing me apart"
ITEM.Description = "Lisa!"
ITEM.StorePrice = 60
ITEM.TauntSound = "taunts/tearing_lisa.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end