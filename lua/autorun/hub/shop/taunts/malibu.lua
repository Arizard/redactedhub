ITEM.Name = "Don't Ask Me"
ITEM.Description = "I'm Just A Girl!"
ITEM.StorePrice = 90
ITEM.TauntSound = "taunts/malibu.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end