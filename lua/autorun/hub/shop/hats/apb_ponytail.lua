ITEM.Name = "Ponytail"
ITEM.Description = "Hairstyle Crate"
ITEM.StorePrice = 120
ITEM.HatModel = "models/jessev92/apb/hair_ponytail.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(150,150,150) -- hair color
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-3,-75)
ITEM.AngOff = Angle(0,0,0)
ITEM.Scl = 1.1
ITEM.Buyable = false
ITEM.IconPosOff = Vector(0,0,-76.5)
ITEM.IconFOV = 13
 
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
