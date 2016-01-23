ITEM.Name = "Civil Protection"
ITEM.Description = "Pick up that can."
ITEM.StorePrice = 150
ITEM.HatModel = "models/nova/w_headgear.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-4,-4)
ITEM.AngOff = Angle(90,-90,00)
ITEM.Scl = 1

ITEM.IconFOV = 12
ITEM.IconPosOff = Vector(0,0,-5)
ITEM.IconLayoutEntity = function(self, ent)
	ent:SetAngles(Angle(0,0,120))
end

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

