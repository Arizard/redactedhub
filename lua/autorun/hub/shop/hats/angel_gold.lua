ITEM.Name = "Gold Wings"
ITEM.Description = "Gold Angel Wings"
ITEM.StorePrice = 2200
ITEM.HatModel = "models/sinful/angel_wings.mdl"
ITEM.HatMat = "models/player/shared/gold_player.vmt"
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "chest"
ITEM.PosOff = Vector(0,-5,1.5)
ITEM.AngOff = Angle(0,0,0)
ITEM.Scl = 1
ITEM.Buyable = false
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

