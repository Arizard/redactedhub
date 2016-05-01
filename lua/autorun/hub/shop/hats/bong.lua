ITEM.Name = "Bong"
ITEM.Description = "Go Green!"
ITEM.StorePrice = 200
ITEM.HatModel = "models/katharsmodels/contraband/waterpijp/waterpijp.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "chest"
ITEM.PosOff = Vector(0,-8,-12)
ITEM.AngOff = Angle(0,180,0)
ITEM.Scl = 0.5
ITEM.IconFOV = 10

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
