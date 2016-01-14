ITEM.Name = "Prank Patrol"
ITEM.Description = "Theme Song"
ITEM.StorePrice = 120
ITEM.TauntSound = "taunts/prankpatrol.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end