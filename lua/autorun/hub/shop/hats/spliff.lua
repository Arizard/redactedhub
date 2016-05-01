ITEM.Name = "Spliff"
ITEM.Description = "Go Green!"
ITEM.StorePrice = 100
ITEM.HatModel = "models/katharsmodels/contraband/jointjes/jointjes.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(-1.25,2.5,-3.25)
ITEM.AngOff = Angle(-10,30,0)
ITEM.Scl = 0.8
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
