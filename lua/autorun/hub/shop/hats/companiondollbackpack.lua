ITEM.Name = "Companion Doll"
ITEM.Description = "Feel the love."
ITEM.StorePrice = 200
ITEM.HatModel = "models/maxofs2d/companion_doll.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "chest"
ITEM.PosOff = Vector(0,-5,-9)
ITEM.AngOff = Angle(10,170,0)
ITEM.Scl = 0.7

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

