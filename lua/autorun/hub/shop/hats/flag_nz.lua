ITEM.Name = "New Zealand Flag"
ITEM.Description = "I'm Beached As"
ITEM.StorePrice = 100
ITEM.HatModel = "models/weapons/arizard/c_buffbanner/c_buffbanner.mdl"
ITEM.HatMat = "models/weapons/arizard/flag_nz.vmt"
ITEM.HatCol = Color(0,0,0)
ITEM.Att = "chest"
ITEM.PosOff = Vector(12,-8,-65)
ITEM.AngOff = Angle(0,-60,0)
ITEM.Scl = 1
ITEM.Buyable = true
ITEM.Rarity = 1

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
