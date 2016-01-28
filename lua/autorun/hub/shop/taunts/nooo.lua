ITEM.Name = "NOOO"
ITEM.Description = ""
ITEM.StorePrice = 70
ITEM.TauntSound = "taunts/nooo.ogg"
ITEM.TauntOnDeath = true

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end