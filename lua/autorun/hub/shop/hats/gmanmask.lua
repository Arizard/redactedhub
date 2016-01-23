ITEM.Name = "G-Man Mask"
ITEM.Description = "Rise and shine."
ITEM.StorePrice = 250
ITEM.HatModel = "models/maxofs2d/balloon_gman.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-4.2,-10)
ITEM.AngOff = Angle(0,0,0)
ITEM.Scl = 1
ITEM.IconFOV = 16
ITEM.IconPosOff = Vector(0,0,-10)

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
