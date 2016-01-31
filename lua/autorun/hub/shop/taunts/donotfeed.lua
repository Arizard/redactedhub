ITEM.Name = "Do Not Feed"
ITEM.Description = "The Dogs"
ITEM.StorePrice = 70
ITEM.TauntSound = "taunts/donotfeedthe.ogg"
ITEM.TauntOnDeath = false

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end