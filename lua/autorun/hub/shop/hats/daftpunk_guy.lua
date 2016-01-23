ITEM.Name = "Guy-Manuel"
ITEM.Description = "Half-punk"
ITEM.StorePrice = 1500
ITEM.HatModel = "models/zelpa/vhs7/ghelm.mdl"
ITEM.HatMat = ""
ITEM.HatCol = Color(255,255,255)
ITEM.Att = "eyes"
ITEM.PosOff = Vector(0,-3.2,-5.2)
ITEM.AngOff = Angle(0,0,0)
ITEM.Scl = 1
ITEM.Buyable = false
ITEM.Rarity = 5
ITEM.IconPosOff = Vector(0,0,-6)
ITEM.IconFOV = 12

function ITEM:OnEquip(ply, id)
	RS:CreateClientModel( self.HatModel, self.Att, self.PosOff , self.AngOff , self.Scl, self.HatMat, self.HatCol, ply, id )
	-- ValveBiped.Bip01_Head1 
	local bone = ply:LookupBone( "ValveBiped.Bip01_Head1" )
	if bone ~= nil then
		ply:ManipulateBoneScale( bone, Vector(1,1,1)*0.8 )
	end
end

function ITEM:OnHolster(ply, id)
	RS:DestroyClientModel( id )
	local bone = ply:LookupBone( "ValveBiped.Bip01_Head1" )
	if bone ~= nil then
		ply:ManipulateBoneScale( bone, Vector(1,1,1)*1 )
	end
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end