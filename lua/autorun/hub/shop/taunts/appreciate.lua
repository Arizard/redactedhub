ITEM.Name = "I Appreciate That"
ITEM.Description = "DJ Khaled"
ITEM.StorePrice = 60
ITEM.TauntSound = "taunts/appreciate.ogg"

function ITEM:OnEquip(ply, id)
	ply.ChoiceTaunt = self.TauntSound
end

function ITEM:OnHolster(ply, id)
	ply.ChoiceTaunt = ""
end