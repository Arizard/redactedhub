ITEM.Name = "Fender"
ITEM.Description = "Jam on."
ITEM.StorePrice = 230
ITEM.HatModel = "models/props_phx/misc/fender.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "chest"
ITEM.PosOff = Vector(-4,-5,3)
ITEM.AngOff = Angle(90,-150,10)
ITEM.Scl = 0.8

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

