ITEM.Name = "Shiny Koala"
ITEM.Description = "She'll Be Right"
ITEM.StorePrice = 1150
ITEM.HatModel = "models/arizard/sniper_pocketkoala.mdl"
ITEM.HatMat = "models/arizard/sniper_pocketkoala"
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "chest"
ITEM.PosOff = Vector(-2,-4,-29)
ITEM.AngOff = Angle(0,110,0)
ITEM.Scl = 0.65
ITEM.Effect = "pocketkoala"
ITEM.Interval = 0.08
ITEM.Buyable = false
ITEM.Rarity = 5
ITEM.IconPosOff = Vector(0,0,-17)

function ITEM:OnEquip(ply, id)
	RS:CreateClientModel( self.HatModel, self.Att, self.PosOff , self.AngOff , self.Scl, self.HatMat, self.HatCol, ply, id )
	if SERVER then
		RS:AddEffect( ply, self.Class )
	end
end

function ITEM:OnHolster(ply, id)
	RS:DestroyClientModel( id )
	if SERVER then
		RS:RemoveEffect( ply, self.Class )
	end
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end
