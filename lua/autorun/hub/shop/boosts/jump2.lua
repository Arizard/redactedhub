ITEM.Name = "Jump II"
ITEM.Description = "Medium jump increase."
ITEM.StorePrice = 160

function ITEM:OnEquip(ply, id)

end

function ITEM:OnHolster(ply, id)
	ply:SetJumpPower( 290 )
end

function ITEM:OnSpawn(ply, id)
	local owns, equipped = RS:DoesPlayerOwnClass( ply, "jump1" )
	local owns1, equipped1 = RS:DoesPlayerOwnClass( ply, "jump3" )

	if equipped and (not equipped1) then
		ply:SetJumpPower( Lerp(0.666, 290,310) )
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

	draw.ShadowText("JUMP", "Screen_Large", x+117/2, y, Color(46, 204, 113), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1 )
	draw.ShadowText("II", "Screen_Medium", x+117/2, y+28, Color(46, 204, 113), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1 )
end