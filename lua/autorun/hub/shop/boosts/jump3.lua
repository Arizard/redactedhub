ITEM.Name = "Jump III"
ITEM.Description = "Large jump increase."
ITEM.StorePrice = 260

function ITEM:OnEquip(ply, id)

end

function ITEM:OnHolster(ply, id)
	ply:SetJumpPower( 200 )
end

function ITEM:OnSpawn(ply, id)
	local owns, equipped = RS:DoesPlayerOwnClass( ply, "jump2" )
	local owns1, equipped1 = RS:DoesPlayerOwnClass( ply, "jump3" )

	if (equipped) and (equipped1) then
		ply:SetJumpPower( 260 )
	end
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end

function ITEM:DrawBoostIcon(x,y)
	surface.SetDrawColor(16,16,16)
	surface.DrawRect(x,y,117,117)

	draw.ShadowText("JUMP", "Screen_Large", x+117/2, y, Color(46, 204, 113), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1 )
	draw.ShadowText("III", "Screen_Medium", x+117/2, y+28, Color(46, 204, 113), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1 )
end