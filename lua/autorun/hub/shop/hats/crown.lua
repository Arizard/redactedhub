ITEM.Name = "Crown"
ITEM.Description = "Regal."
ITEM.StorePrice = 1750
ITEM.HatModel = "models/arizard/crown/crown.mdl"
ITEM.HatMat = "models/arizard/crown/crown_sheet.vmt"
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-2.7,3.2)
ITEM.AngOff = Angle(-10,0,0)
ITEM.Scl = 1
ITEM.Buyable = false
ITEM.Rarity = 4
ITEM.IconPosOff = Vector(0,0,-5)
ITEM.IconFOV = 12

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
