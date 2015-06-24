ITEM.Name = "Health II"
ITEM.Description = "Medium health increase."
ITEM.StorePrice = 180

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

	local owns, equipped = RS:DoesPlayerOwnClass( ply, "health1" )
	local owns1, equipped1 = RS:DoesPlayerOwnClass( ply, "health3" )

	if (equipped) and (not equipped1) then
		ply:SetHealth( Lerp(0.666, 100,200) )
	end
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end

function ITEM:DrawBoostIcon()
	// 117x117
	local x = 2
	local y = 2
	surface.SetDrawColor(16,16,16)
	surface.DrawRect(x,y,117,117)

	draw.ShadowText("HEALTH", "Screen_Large", x+117/2, y, Color(231, 76, 60), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1 )
	draw.ShadowText("II", "Screen_Medium", x+117/2, y+28, Color(231, 76, 60), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1 )
end