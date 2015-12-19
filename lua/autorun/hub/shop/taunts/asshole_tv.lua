ITEM.Name = "I Seen You"
ITEM.Description = "The asshole from TV"
ITEM.StorePrice = 60
ITEM.TauntSound = "taunts/asshole_tv.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end