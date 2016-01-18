ITEM.Name = "Shiny Antlion"
ITEM.Description = "Keep off the sand."
ITEM.StorePrice = 1050
ITEM.HatModel = "models/Gibs/Antlion_gib_Large_2.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-0.5,0.5)
ITEM.AngOff = Angle(0,0,0)
ITEM.Scl = 1
ITEM.Effect = "smallslime"
ITEM.Interval = 0.08
ITEM.Buyable = false
ITEM.Rarity = 5

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
