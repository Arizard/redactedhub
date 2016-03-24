ITEM.Name = "VHS Mask"
ITEM.Description = "Authentic 90s Relic"
ITEM.StorePrice = 400
ITEM.HatModel = "models/props/vhstape.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,1.5,0.5)
ITEM.AngOff = Angle(5,0,0)
ITEM.Scl = 1
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
