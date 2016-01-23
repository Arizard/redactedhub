ITEM.Name = "Pirate Hat"
ITEM.Description = "YOU ARE A PIRATE!"
ITEM.StorePrice = 230
ITEM.HatModel = "models/piratehat/piratehat.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-3,3)
ITEM.AngOff = Angle(0,180,0)
ITEM.Scl = 1
ITEM.IconFOV = 14
ITEM.IconPosOff = Vector(0,0,-5)

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

