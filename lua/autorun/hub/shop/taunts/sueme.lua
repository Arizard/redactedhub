ITEM.Name = "Sue Me"
ITEM.Description = "dickhead."
ITEM.StorePrice = 60
ITEM.TauntSound = "taunts/sue_me.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end