ITEM.Name = "Text Hat"
ITEM.Description = "No Preview :("
ITEM.StorePrice = 1
ITEM.Buyable = false

function ITEM:OnEquip(ply, id)
	if SERVER then
		net.Start("UpdateTextHat")
		net.WriteString( ply:SteamID64() )
		net.WriteColor( GetTextHatColor( ply ) )
		net.WriteString( GetTextHatMessage( ply ) )
		net.WriteString( GetTextHatFont( ply ) )
		net.WriteFloat( GetTextHatSize( ply ) )
		net.WriteString( GetTextHatEffect( ply ) )
		net.Broadcast()
	end
end

function ITEM:OnHolster(ply, id)
	if SERVER then
		net.Start("UpdateTextHat")
		net.WriteString( ply:SteamID64() )
		net.WriteColor( Color(0,0,0,0) )
		net.WriteString( "" )
		net.WriteString( "" )
		net.WriteFloat( 1 )
		net.WriteString( "none" )
		net.Broadcast()
	end
end

function ITEM:OnSpawn(ply, id)
end

function ITEM:OnDeath(ply, id)
end

function ITEM:OnThink(ply, id)
end


ITEM.CustomOptionsName = "Configure"
function ITEM:DoCustomOptions( id )
	RunConsoleCommand("hub_texthat_edit")
end