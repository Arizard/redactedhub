ITEM.Name = "Jar of Head"
ITEM.Description = "\"I can't hear anything\""
ITEM.StorePrice = 120
ITEM.HatModel = "models/props_junk/glassjug01.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-2.5,5)
ITEM.AngOff = Angle(0,90,180)
ITEM.Scl = 1.6

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
