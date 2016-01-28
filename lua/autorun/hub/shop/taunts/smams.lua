ITEM.Name = "SMAMS"
ITEM.Description = "TAKE A CLOSER LOOK"
ITEM.StorePrice = 100
ITEM.TauntSound = "taunts/smams.ogg"
ITEM.TauntOnDeath = false

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end