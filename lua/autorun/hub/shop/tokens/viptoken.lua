ITEM.Name = "Donator Token"
ITEM.Description = "Rare Token."
ITEM.StorePrice = 999999
ITEM.IsToken = true
ITEM.Buyable = false

function ITEM:OnEquip(ply, id)
	RS:CreateClientToken( ply, id, "viptoken")
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

function ITEM:DrawTokenFace(x,y)

	draw.NoTexture()

	surface.SetDrawColor(Color(241, 196, 15))
	surface.DrawCircle(x,y,25)

	surface.SetDrawColor(Color(243, 156, 18))
	surface.DrawCircle(x,y,22)
	draw.ShadowText("★", "Screen_Large", x,y-25,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1)
	draw.ShadowText("VIP", "Screen_Tiny", x,y+6,Color(255,255,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1)

end