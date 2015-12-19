ITEM.Name = "Excuuuuse me"
ITEM.Description = "princess!"
ITEM.StorePrice = 60
ITEM.TauntSound = "taunts/excuse2.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end