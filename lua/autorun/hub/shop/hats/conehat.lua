ITEM.Name = "Cone Hat"
ITEM.Description = "Protect Me!"
ITEM.StorePrice = 150
ITEM.HatModel = "models/props_junk/TrafficCone001a.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-3,12)
ITEM.AngOff = Angle(0,0,0)
ITEM.Scl = 0.6
ITEM.IconFOV = 15

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