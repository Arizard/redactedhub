ITEM.Name = "Pan Hat"
ITEM.Description = "By Jamie Oliver."
ITEM.StorePrice = 120
ITEM.HatModel = "models/props_interiors/pot02a.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(6,-4,2)
ITEM.AngOff = Angle(220,0,0)
ITEM.Scl = 1
ITEM.IconFOV = 16
ITEM.IconPosOff = Vector(0,0,0)

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

