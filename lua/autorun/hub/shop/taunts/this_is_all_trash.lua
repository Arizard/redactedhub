ITEM.Name = "This is all trash"
ITEM.Description = "All of it"
ITEM.StorePrice = 90
ITEM.TauntSound = "taunts/this_is_all_trash.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end