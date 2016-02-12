ITEM.Name = "Big Heart"
ITEM.Description = "Valentines Day 2016"
ITEM.StorePrice = 200
ITEM.HatModel = "models/balloons/balloon_classicheart.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,102,153)
ITEM.Att = "chest"
ITEM.PosOff = Vector(0,5,-4)
ITEM.AngOff = Angle(17,90,0)
ITEM.Scl = 0.5
ITEM.IconFOV = 15
ITEM.IconPosOff = Vector(0,0,-10)
ITEM.Rarity = 3
ITEM.Effect = "lovehearts"
ITEM.Interval = 0.1
ITEM.Buyable = false

function ITEM:OnEquip(ply, id)
	RS:CreateClientModel( self.HatModel, self.Att, self.PosOff , self.AngOff , self.Scl, self.HatMat, self.HatCol, ply, id )
	if SERVER then
		RS:AddEffect( ply, self.Class )
	end
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

