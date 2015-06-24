ITEM.Name = "Health I"
ITEM.Description = "Small health increase."
ITEM.StorePrice = 80

function ITEM:OnEquip(ply, id)

end

function ITEM:OnHolster(ply, id)
	if ply:Health() > 100 then
		ply:SetHealth( 100 )
		ply:SetMaxHealth( 100 )
	end
end

function ITEM:OnSpawn(ply, id)
	ply:SetMaxHealth( 200 )

	local owns, equipped = RS:DoesPlayerOwnClass( ply, "health2" )
	local owns1, equipped1 = RS:DoesPlayerOwnClass( ply, "health3" )

	if (not equipped) or (not equipped1) then
		ply:SetHealth( Lerp(0.333, 100,200) )
	end
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end

function ITEM:DrawBoostIcon(x,y)
	surface.SetDrawColor(16,16,16)
	surface.DrawRect(x,y,117,117)

	draw.ShadowText("HEALTH", "Screen_Large", x+117/2, y, Color(231, 76, 60), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1 )
	draw.ShadowText("I", "Screen_Medium", x+117/2, y+28, Color(231, 76, 60), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1 )
end