ITEM.Name = "Shiny Astronaut"
ITEM.Description = "SPAAAAAAACE!"
ITEM.StorePrice = 1250
ITEM.HatModel = "models/astronauthelmet/astronauthelmet.mdl"
ITEM.HatMat = "vhs7/nebula2.vmt"
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-3,-5)
ITEM.AngOff = Angle(0,0,0)
ITEM.IconPosOff = Vector(0,0,-5)
ITEM.Scl = 0.9
ITEM.Rarity = 5
ITEM.Effect = "planets"
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
