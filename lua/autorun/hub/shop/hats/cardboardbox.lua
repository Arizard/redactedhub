ITEM.Name = "Cardboard Box"
ITEM.Description = [[You've Always Wanted.]]
ITEM.StorePrice = 150
ITEM.HatModel = "models/props_junk/cardboard_box001a.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "chest"
ITEM.PosOff = Vector(0,-2,-4)
ITEM.AngOff = Angle(90,90,0)
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

