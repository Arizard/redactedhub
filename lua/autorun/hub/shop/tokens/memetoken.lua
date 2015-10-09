ITEM.Name = "Meme Face"
ITEM.Description = "Rare Meme."
ITEM.StorePrice = 999999
ITEM.IsToken = true
ITEM.Buyable = false

function ITEM:OnEquip(ply, id)
	RS:CreateClientToken( ply, id, "memetoken")
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

	surface.SetDrawColor(Color(255,230,230))
	surface.DrawCircle(x,y,25)

	surface.SetDrawColor(Color(255,255,255))
	surface.DrawCircle(x,y,22)
	draw.ShadowText("( ͡° ͜ʖ ͡°)", "Screen_Medium", x,y,Color(200, 50, 50),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1)

end

