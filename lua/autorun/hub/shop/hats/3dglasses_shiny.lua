ITEM.Name = "Shiny 3D Glasses"
ITEM.Description = "The world in 3D."
ITEM.StorePrice = 300
ITEM.HatModel = "models/gmod_tower/3dglasses.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-1.4,-0.3)
ITEM.AngOff = Angle(0,0,0)
ITEM.Scl = 1
ITEM.Buyable = false
ITEM.Rarity = 3
ITEM.IconFOV = 10

function ITEM:OnEquip(ply, id)
	RS:CreateClientModel( self.HatModel, self.Att, self.PosOff , self.AngOff , self.Scl, self.HatMat, self.HatCol, ply, id )
	if SERVER then
		ply:SendLua( "RS.GlassesEffect = true" )
	end
end

function ITEM:OnHolster(ply, id)
	RS:DestroyClientModel( id )
	if SERVER then
		ply:SendLua( "RS.GlassesEffect = false" )
	end
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end

if CLIENT then
	RS.GlassesEffect = false

	
end