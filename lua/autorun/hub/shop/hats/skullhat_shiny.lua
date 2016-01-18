ITEM.Name = "Shiny Skull"
ITEM.Description = "SPOOKY!"
ITEM.StorePrice = 1100
ITEM.HatModel = "models/gibs/hgibs.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-3,0)
ITEM.AngOff = Angle(-15,0,0)
ITEM.Scl = 1.75
ITEM.Effect = "smallflames"
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
