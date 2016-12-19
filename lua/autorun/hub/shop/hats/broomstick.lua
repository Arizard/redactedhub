ITEM.Name = "Broomstick"
ITEM.Description = "Don't drink and fly!"
ITEM.StorePrice = 550
ITEM.HatModel = "models/halloween/halloween_broom.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "chest"
ITEM.PosOff = Vector(0,9,-18)
ITEM.AngOff = Angle(-50,0,0)
ITEM.Scl = 1
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
