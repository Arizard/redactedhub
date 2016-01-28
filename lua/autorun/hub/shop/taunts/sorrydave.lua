ITEM.Name = "I'm Sorry Dave"
ITEM.Description = "Afraid I can't do that."
ITEM.StorePrice = 120
ITEM.TauntSound = "taunts/sorrydave.ogg"
ITEM.TauntOnDeath = false

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end