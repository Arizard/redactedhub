ITEM.Name = "Jean-Claude"
ITEM.Description = "PD2 Panda Mask"
ITEM.StorePrice = 900
ITEM.HatModel = "models/snowzgmod/payday2/masks/maskjeanclaude.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,0,0)
ITEM.AngOff = Angle(-20,0,0)
ITEM.Scl = 1
ITEM.IconFOV = 10
ITEM.Buyable = false
ITEM.Rarity = 4

function ITEM:OnEquip(ply, id)
	RS:CreateClientModel( self.HatModel, self.Att, self.PosOff , self.AngOff , self.Scl, self.HatMat, self.HatCol, ply, id )
end

function ITEM:OnHolster(ply, id)
	RS:DestroyClientModel( id )
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end
