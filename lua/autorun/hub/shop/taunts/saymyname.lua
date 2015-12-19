ITEM.Name = "Say My Name"
ITEM.Description = "Key 2 Success"
ITEM.StorePrice = 60
ITEM.TauntSound = "taunts/say_my_name.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end