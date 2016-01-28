ITEM.Name = "You Maniacs"
ITEM.Description = "You blew it up"
ITEM.StorePrice = 90
ITEM.TauntSound = "taunts/youmaniacs.ogg"
ITEM.TauntOnDeath = false

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end