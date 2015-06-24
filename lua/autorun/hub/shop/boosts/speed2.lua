ITEM.Name = "Speed II"
ITEM.Description = "Medium speed increase."
ITEM.StorePrice = 150

function ITEM:OnEquip(ply, id)
	
end

function ITEM:OnHolster(ply, id)
	ply:SetWalkSpeed( 250 )
end

function ITEM:OnSpawn(ply, id)
	local owns, equipped = RS:DoesPlayerOwnClass( ply, "speed1" )
	local owns1, equipped1 = RS:DoesPlayerOwnClass( ply, "speed3" )

	if equipped and (not equipped1) then
		ply:SetWalkSpeed( Lerp(0.6666, 250,300) )
	end
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end

function ITEM:DrawBoostIcon(x,y)
	surface.SetDrawColor(16,16,16)
	surface.DrawRect(x,y,117,117)

	draw.ShadowText("SPEED", "Screen_Large", x+117/2, y, Color(155, 89, 182), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1 )
	draw.ShadowText("II", "Screen_Medium", x+117/2, y+28, Color(155, 89, 182), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1 )
end