ITEM.Name = "Angel Wings"
ITEM.Description = "Summer Lovin' Crate"
ITEM.StorePrice = 1200
ITEM.HatModel = "models/sinful/angel_wings.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "chest"
ITEM.PosOff = Vector(0,-5,1.5)
ITEM.AngOff = Angle(0,0,0)
ITEM.Scl = 1
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

