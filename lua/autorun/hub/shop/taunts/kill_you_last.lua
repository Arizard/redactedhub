ITEM.Name = "I'll kill you last"
ITEM.Description = "i like you"
ITEM.StorePrice = 90
ITEM.TauntSound = "taunts/kill_you_last.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end