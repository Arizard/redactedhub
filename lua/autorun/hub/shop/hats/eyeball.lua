ITEM.Name = "Demon Eye"
ITEM.Description = "Always watching..."
ITEM.StorePrice = 550
ITEM.HatModel = "models/halloween/halloween_eyeball.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-2,7)
ITEM.AngOff = Angle(0,90,180)
ITEM.Scl = 0.5
ITEM.Buyable = false

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
