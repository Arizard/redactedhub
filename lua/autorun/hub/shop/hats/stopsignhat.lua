ITEM.Name = "Stop Mask"
ITEM.Description = "Hold it."
ITEM.StorePrice = 120
ITEM.HatModel = "models/props_c17/streetsign004e.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,2.3,-0.1)
ITEM.AngOff = Angle(0,-90,0)
ITEM.Scl = 0.5
ITEM.IconFOV = 14

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
