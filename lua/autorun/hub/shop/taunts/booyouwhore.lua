ITEM.Name = "Boo You Whore"
ITEM.Description = "Why are you white?"
ITEM.StorePrice = 70
ITEM.TauntSound = "taunts/booyouwhore.ogg"
ITEM.TauntOnDeath = false

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end