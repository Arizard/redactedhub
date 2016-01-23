ITEM.Name = "Shiny Emo"
ITEM.Description = "Hairstyle Crate"
ITEM.StorePrice = 1050
ITEM.HatModel = "models/jessev92/apb/hair_emo1.mdl"
ITEM.HatMat = "debug/env_cubemap_model.vmt"
ITEM.HatCol = Color(255,16,16)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-3.5,-67.5)
ITEM.AngOff = Angle(0,0,0)
ITEM.Scl = 1
ITEM.Buyable = false
ITEM.Rarity = 5
ITEM.IconPosOff = Vector(0,0,-70.5)
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