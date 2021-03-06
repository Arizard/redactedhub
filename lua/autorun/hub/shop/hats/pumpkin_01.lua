ITEM.Name = "Spooky Pumpkin"
ITEM.Description = "Spooky!"
ITEM.StorePrice = 550
ITEM.HatModel = "models/halloween/pumpkin_01.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-6,-8)
ITEM.AngOff = Angle(0,-160,0)
ITEM.Scl = 0.65
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
