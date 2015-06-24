ITEM.Name = "Speed III"
ITEM.Description = "High speed increase."
ITEM.StorePrice = 250

function ITEM:OnEquip(ply, id)
	
end

function ITEM:OnHolster(ply, id)
	ply:SetWalkSpeed( 250 )
end

function ITEM:OnSpawn(ply, id)
	local owns, equipped = RS:DoesPlayerOwnClass( ply, "speed2" )
	local owns1, equipped1 = RS:DoesPlayerOwnClass( ply, "speed1" )

	if equipped and equipped1 then
		ply:SetWalkSpeed( 300 )
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

	draw.ShadowText("SPEED", "Screen_Large", x+117/2, y, Color(155, 89, 182), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1 )
	draw.ShadowText("III", "Screen_Medium", x+117/2, y+28, Color(155, 89, 182), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1 )
end