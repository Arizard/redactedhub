ITEM.Name = "Inner Circle"
ITEM.Description = "Rare Token."
ITEM.StorePrice = 999999
ITEM.IsToken = true
ITEM.Buyable = false

function ITEM:OnEquip(ply, id)
	RS:CreateClientToken( ply, id, "innercircletoken")
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

function ITEM:DrawTokenFace(x,y )

	draw.NoTexture()

	surface.SetDrawColor(Color(52, 152, 219))
	surface.DrawCircle(x,y,25)

	surface.SetDrawColor(Color(41, 128, 185))
	surface.DrawCircle(x,y,22)
	draw.ShadowText("IC", "Screen_Large", x,y-18,Color(241, 196, 15),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1)

end

