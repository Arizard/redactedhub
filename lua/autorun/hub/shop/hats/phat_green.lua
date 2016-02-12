ITEM.Name = "Green Party Hat"
ITEM.Description = "Rare Item"
ITEM.StorePrice = 1200
ITEM.HatModel = "models/duncehat/duncehat.mdl"
ITEM.HatMat = "models/debug/debugwhite"
ITEM.HatCol = Color(0,255,0)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-4.2,3.5)
ITEM.AngOff = Angle(25,0,0)
ITEM.Scl = 0.5
ITEM.IconFOV = 15
ITEM.IconPosOff = Vector(0,0,-9)
ITEM.Buyable = false
ITEM.Sellable = false
ITEM.Rarity = 5

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
