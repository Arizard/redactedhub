ITEM.Name = "Beehop"
ITEM.Description = "I DONT HAVE IT"
ITEM.StorePrice = 120
ITEM.TauntSound = "taunts/fuckbees.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end