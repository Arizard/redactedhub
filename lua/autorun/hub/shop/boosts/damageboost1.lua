ITEM.Name = "Damage Boost"
ITEM.Description = "Small damage increase."
ITEM.StorePrice = 220

function ITEM:OnEquip(ply, id)

end

function ITEM:OnHolster(ply, id)
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end

function ITEM:DrawBoostIcon(x,y)
	
	surface.SetDrawColor(16,16,16)
	surface.DrawRect(x,y,117,117)

	draw.ShadowText("DAMAGE", "Screen_Large", x+117/2, y, Color(230, 126, 34), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1 )
	draw.ShadowText("BOOST", "Screen_Medium", x+117/2, y+28, Color(230, 126, 34), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1 )
end

if SERVER then
	hook.Add("EntityTakeDamage", "DamageBoostItem", function( ent, dmginfo )

		if dmginfo:GetAttacker():IsPlayer() then
			local ply = dmginfo:GetAttacker()
			local owns, equipped = RS:DoesPlayerOwnClass( ply, "damageboost1" )

			if equipped then
				dmginfo:ScaleDamage(1.15)
			end

			//print(dmginfo:GetDamage())
		end

	end)
end