ITEM.Name = "VHS Backpack"
ITEM.Description = "Back to Back Friends"
ITEM.StorePrice = 400
ITEM.HatModel = "models/props/vhstape.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "chest"
ITEM.PosOff = Vector(0,-7.5,0.5)
ITEM.AngOff = Angle(0,0,70)
ITEM.Scl = 3
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
