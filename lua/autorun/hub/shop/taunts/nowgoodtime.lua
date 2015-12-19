ITEM.Name = "Now would be"
ITEM.Description = "a good time"
ITEM.StorePrice = 120
ITEM.TauntSound = "taunts/now_good_time.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end