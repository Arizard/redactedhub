ITEM.Name = "Monitor"
ITEM.Description = "a e s t h e t i c"
ITEM.StorePrice = 250
ITEM.HatModel = "models/props_lab/monitor02.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-5,-10)
ITEM.AngOff = Angle(0,0,0)
ITEM.Scl = 0.8
ITEM.Rarity = 2

function ITEM:OnEquip(ply, id)
	RS:CreateClientModel( self.HatModel, self.Att, self.PosOff , self.AngOff , self.Scl, self.HatMat, self.HatCol, ply, id )
	ply:ConCommand("deathrun_vhs7 1")
end

function ITEM:OnHolster(ply, id)
	RS:DestroyClientModel( id )
	ply:ConCommand("deathrun_vhs7 0")
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end
