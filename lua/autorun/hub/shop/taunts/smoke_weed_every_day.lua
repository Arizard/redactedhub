ITEM.Name = "Smoke Weed"
ITEM.Description = "Every Day"
ITEM.StorePrice = 90
ITEM.TauntSound = "taunts/smoke_weed_everyday.mp3"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end