print("RedactedHub - Loaded cl_init.lua")
include("shared.lua")


local fontstandard = "Roboto"
surface.CreateFont("Screen_XLarge", {
	font = fontstandard.." Black",
	size = 56,
	antialias = true,
})
surface.CreateFont("Screen_Large", {
	font = fontstandard.." Black",
	size = 32,
	antialias = true,
})
surface.CreateFont("Screen_Medium", {
	font = fontstandard.." Bold",
	size = 26,
	antialias = true,
})

surface.CreateFont("Screen_Small", {
	font = fontstandard.." Regular",
	size = 20,
	antialias = true,
})
surface.CreateFont("Screen_Small2", {
	font = "Roboto Condensed",
	size = 20,
	antialias = true,
})
surface.CreateFont("Screen_Tiny", {
	font = "Roboto Condensed",
	size = 14,
	antialias = true,
})

local drawhats = CreateClientConVar("hub_hats",1,true,false)
local drawgifts = CreateClientConVar("hub_gift_notif", 1, true, false)
local drawtexthats = CreateClientConVar("hub_texthats", 1, true, false)

RS.Options = { -- gets drawn in the options tab
	{"h1", "Options"},
	{"bool","hub_hats","Hats Visible"},
	{"bool","hub_gift_notif", "Gift Notifications"},
	{"bool","hub_texthats", "Texthats Visible"}
}

function RS:ReceiveVip()
	surface.PlaySound("buttons/bell1.wav")
end

function RS:Initialize()

	print(" RedactedHub - Clientside Hub initialized")
end

net.Receive("RS:StoreChat", function()

	local msg = net.ReadString()
	chat.AddText( Color(255,255,255),"[",AuColors.New.E,"HUB",Color(255,255,255),"] ", msg )

end)

function surface.EasyPoly(tbl) -- needs a table in format { {x1,y1}, {x2,y2} }
	local poly = {}

	for i = 1, #tbl do
		local temp = {}
		temp['x'] = tbl[i][1]
		temp['y'] = tbl[i][2]

		table.insert(poly, temp)
	end

	
	surface.DrawPoly(poly)
	

end

function surface.DrawCircle(x, y, r)

	local segments = 45

	local poly = {}

	for i = 1, segments do
		local temp = {}
		temp['x'] = math.cos( (math.ceil(i*(360/segments)) )*(math.pi/180) ) * r + x
		temp['y'] = math.sin( (math.ceil(i*(360/segments)))*(math.pi/180) ) * r + y

		table.insert(poly, temp)
	end

	surface.DrawPoly(poly)

end

function surface.DrawSector(x, y, r, ang, rot)

	local segments = 360
	local segmentstodraw = 360 * (ang/360)
	rot = rot* (segments/360)
	local poly = {}

	local temp = {}
	temp['x'] = x
	temp['y'] = y
	table.insert(poly, temp)

	for i = 1+rot, segmentstodraw+rot do
		local temp = {}
		temp['x'] = math.cos( (i*(360/segments) )*(math.pi/180) ) * r + x
		temp['y'] = math.sin( (i*(360/segments) )*(math.pi/180) ) * r + y

		table.insert(poly, temp)
	end
	
	surface.DrawPoly(poly)

end

function draw.ShadowText( text, font, x, y, col, ax, ay , d)
	draw.SimpleText( text, font, x+d*2, y+d*2, Color(0,0,0,col.a*0.1), ax, ay )
	draw.SimpleText( text, font, x+d, y+d, Color(0,0,0,col.a*0.3), ax, ay )
	draw.SimpleText( text, font, x, y, col, ax, ay)
end



local PLAYER = FindMetaTable("Player")

function PLAYER:GetMoney()
	return self:GetNWInt(RS.PDataMoney, 0)
end

--hats



net.Receive("CreateClientModel", function()
	local data = net.ReadTable()
	--PrintTable( data )
	RS:CreateClientModel( data.mdl, data.att, data.posoff, data.angoff, data.scl, data.mat, data.col, data.ply, data.id, data.isToken, data.class, data.id64 )
end)

net.Receive("SendClientModelsOnSpawn", function()

	local mdls = net.ReadTable()

	print("Received Clientside Models from server.")
	--PrintTable(mdls)

	for k, cmod in ipairs( mdls ) do
		--if cmod.isToken == false then
			RS:CreateClientModel( cmod.mdl, cmod.att, cmod.posoff, cmod.angoff, cmod.scl, cmod.mat, cmod.col, cmod.ply, cmod.id, cmod.isToken, cmod.class, cmod.id64 )
		--else
			--RS:CreateClientToken( cmod.ply, cmod.id, cmod.class )
		--end
	end

	--PrintTable(RS.ClientSideModels)

end)

net.Receive("DestroyClientModel", function()
	RS:DestroyClientModel( tostring(net.ReadInt(32)) )
end)

function RS:DestroyClientModel(id)

	SafeRemoveEntity( RS.ClientSideModels[id] )

end

function RS:CreateClientModel( mdl, att, posoff, angoff, scl, mat, col, ply, id, token, class, id64 )

	if RS.ClientSideModels[id] then
		SafeRemoveEntity(RS.ClientSideModels[id])
	end

	local cmod = ClientsideModel(mdl)
	cmod.att = att
	cmod.posoff = posoff
	cmod.angoff = angoff
	cmod.scl = scl
	cmod.mat = mat
	cmod.col = col or Color(255,255,255)
	cmod.ply = player.GetBySteamID64( id64 )
	cmod.id = id
	cmod:SetNoDraw( true )
	cmod.isToken = token
	cmod.class = class
	cmod.id64 = id64

	

	print("RedactedHub - Creating model for",player.GetBySteamID64(cmod.id64), mdl, cmod.id)

	cmod:SetModelScale( scl, 0 )

	RS.ClientSideModels[id] = cmod

	--PrintTable(cmod:GetTable())

end

concommand.Add("hub_dump_clientmodels", function()
	for k,v in pairs(RS.ClientSideModels) do
		print(k, type(k),(IsValid(v) and v:GetModel() or "destroyed"), v.ply)
	end
end)

concommand.Add("hub_dump_lastrenderedmodels", function()
	for k,v in pairs(RS.LastRenderedModels) do
		print(k, type(k),(IsValid(v) and v:GetModel() or "destroyed"), v.ply)
	end
end)

RS.InPreview = false
RS.LastRenderedModels = {}

function RS:RenderClientModels()
	RS.LastRenderedModels = {}
	if drawhats:GetBool() == true then
		for id, m in pairs(RS.ClientSideModels) do
			if (m.ply == nil or (not IsValid(m.ply)) ) and m.id64 then
				local newply = player.GetBySteamID64( m.id64 )
				if newply ~= false and IsValid( newply ) then
					m.ply = newply
				else
					m.ply = nil
				end
			end
			if IsValid(m) and RS.InPreview == false then
				
				if IsValid(m.ply) then
					if ( (LocalPlayer() ~= m.ply) or LocalPlayer():ShouldDrawLocalPlayer() ) then
						-- 

						-- if m.ply:GetObserverMode() ~= OBS_MODE_NONE then return end
						-- if not m.ply:Alive() then return end

						local draw = true
						if LocalPlayer():GetObserverTarget() == m.ply then
							if LocalPlayer():GetObserverMode() == OBS_MODE_IN_EYE then
								draw = false
							end
						end


						local atid = m.ply:LookupAttachment(m.att)
						local attach = m.ply:GetAttachment(atid)

						if attach == nil then draw = false end
						
						if draw then
							local x = m.posoff.x * attach.Ang:Right()
							local y = m.posoff.y * attach.Ang:Forward()
							local z = m.posoff.z * attach.Ang:Up()
							--print(x,y,z)
							--print( Vector(x,y,z) )
							--print(posoff2)
							m:SetPos(attach.Pos + x + y + z)
							local ang = attach.Ang
							ang:RotateAroundAxis( attach.Ang:Right(), m.angoff.pitch )
							ang:RotateAroundAxis( attach.Ang:Up(), m.angoff.yaw )
							ang:RotateAroundAxis( attach.Ang:Forward(), m.angoff.roll )

							m:SetAngles(ang)
							m:SetMaterial( m.mat )

							if (m.IsToken == false) or (not m.IsToken) then
								m:DrawModel()
							end
							table.insert( RS.LastRenderedModels, m )
						end
					end
				end

			end
		end
	end
end
hook.Add("PreDrawTranslucentRenderables","RS:RenderClientModels", RS.RenderClientModels)

function RS:RenderClientTokens()

	for id, m in pairs(RS.ClientSideModels) do
		if (m.ply == nil or not IsValid(m.ply)) and m.id64 then
			local found = nil
			for k,v in ipairs(player.GetAll()) do
				if m.id64 ~= nil then
					if m.id64 == v:SteamID64() then
						found = v
					end
				end
			end
			if found ~= nil then m.ply = found else return end
		end


		if IsValid(m) and IsValid(m.ply) and RS.InPreview == false then

			if ((LocalPlayer() ~= m.ply) or LocalPlayer():ShouldDrawLocalPlayer()) then
				if m.isToken == true then
					
					if LocalPlayer():GetObserverTarget() == m.ply then
						if LocalPlayer():GetObserverMode() == OBS_MODE_IN_EYE then
							return 
						end
					end

					if m.ply:GetObserverMode() ~= OBS_MODE_NONE then return end
					if not m.ply:Alive() then return end

					


					local atid = m.ply:LookupAttachment(m.att)
					local attach = m.ply:GetAttachment(atid)

					if attach == nil then return end
					
					local x = m.posoff.x * attach.Ang:Right()
					local y = m.posoff.y * attach.Ang:Forward()
					local z = m.posoff.z * attach.Ang:Up()
					--print(x,y,z)
					--print( Vector(x,y,z) )
					--print(posoff2)
					--m:SetPos(attach.Pos + x + y + z)
					local ang = attach.Ang
					ang:RotateAroundAxis( attach.Ang:Right(), m.angoff.pitch )
					ang:RotateAroundAxis( attach.Ang:Up(), m.angoff.yaw )
					ang:RotateAroundAxis( attach.Ang:Forward(), m.angoff.roll )

					ang:RotateAroundAxis( ang:Up(), 90)
				
					--print(m.class)
					if RS.Items[m.class].IsToken == true then
						--print("Drawing Token")
						cam.IgnoreZ( true )
						cam.Start3D2D(m:GetPos()+ang:Up()*3.5, ang, 0.105)
							RS.Items[m.class]:DrawTokenFace(0,0)
						cam.End3D2D()
						cam.IgnoreZ( false )
						
					end
				end
			end

		end
	end


end

hook.Add("PostDrawTranslucentRenderables", "RS:RenderClientTokens", RS.RenderClientTokens)

local TauntKey = KEY_B

-- taunt interface
function RS:TauntKeys( cmd )

	if input.WasKeyPressed( TauntKey ) and not vgui.CursorVisible() then
		RunConsoleCommand("shop_taunt")
	end

	--quickie, open the hub on F3 HARDCODEEEEE
	if input.WasKeyPressed( KEY_F3 ) and not vgui.CursorVisible() then
		--RunConsoleCommand("hub_open2")
	end

end
hook.Add("CreateMove", "RS:TauntKeys", RS.TauntKeys)

-- materials on death
local deathmats = {}
net.Receive("RSPlayerKilled", function()
	local id64 = net.ReadString()
	local mat = net.ReadString()

	print( id64, mat)

	for k,v in ipairs(player.GetAll()) do
		if v:SteamID64() == id64 then
			deathmats[v] = mat
		end
	end

end)

hook.Add("Tick", "DeadMaterials", function()
	for ply, mat in pairs( deathmats ) do
		if IsValid( ply ) then
			if IsValid(ply:GetRagdollEntity()) then
				ply:GetRagdollEntity():SetMaterial( mat )
				deathmats[ply] = nil
			end
		else
			deathmats[ply] = nil
		end
	end
end)

local PLAYER = FindMetaTable("Player")

function PLAYER:IsVip()
	return self:GetNWBool("has_vip", false)
end

hook.Add("PreDrawPlayerHands", "HandMaterials", function( hands, vm, ply, wep )
	hands:SetMaterial( ply:GetMaterial() or "" )
	--hands:SetColor( ply:GetColor() or Color(255,255,255) )

	local c = ply:GetColor()
	render.SetColorModulation( c.r/255, c.g/255, c.b/255 )

	--PrintTable( vm:GetMaterials() )
end)

hook.Add("PreDrawViewModel", "HandMaterials", function( vm, ply, wep )
	--`PrintTable( vm:GetMaterials() )
	if vm then
		--print( vm:GetModel() )
		PrintTable( vm:GetTable() )
		if vm:GetMaterials()[1] == "models/weapons/v_hand/v_hand_sheet" then
			vm:SetSubMaterial( 0, ply:GetMaterial() or "" )
		else
			vm:SetSubMaterial( 0, "" )
		end
	end
end)

hook.Add("PostDrawPlayerHands", "HandMaterials", function( hands, vm, ply, wep )
	render.SetColorModulation( 1,1,1 )
end)

--text hats

local hatfonts = {
	{"texthat_comic_sans","Comic Sans MS"},
	{"texthat_coolvetica","Coolvetica"},
	{"texthat_roboto", "Roboto Black"},
	{"texthat_system","System"},
	{"texthat_impact","Impact"},
	{"texthat_greek", "Symbol"},
	{"texthat_oldenglish","Old English Text MT"},
	{"texthat_bodoni","Bodoni MT"}
}

local validfonts = {}

RS.TextHatFonts = hatfonts

for k,v in ipairs( hatfonts ) do
	surface.CreateFont( v[1],
	{
		font = v[2],
		size = 60,
		antialias = true,
		outline = true,
	})

	surface.CreateFont( v[1].."_preview",
	{
		font = v[2],
		size = 28,
		antialias = true,
		outline = true,
	})

	table.insert( validfonts, v[1] )
end

local textHatCache = {
	["76561198020843439"] = {
		col = Color(255,0,255),
		effect	=	"wave",
		font	=	"texthat_comic_sans",
		frac	=	0,
		size	=	0.050000000745058,
		text	=	"If you can read this, I'm going too slow!"
	}
}

net.Receive("UpdateTextHat", function()
	local id = net.ReadString()
	textHatCache[ id ] = {
		col = net.ReadColor(),
		text = net.ReadString(),
		font = net.ReadString(),
		size = math.Clamp( net.ReadFloat(), 0, 0.075),
		effect = net.ReadString(),
		frac = 0,
	}

	if not table.HasValue( validfonts, textHatCache[ id ].font ) then
		textHatCache[ id ].font = "texthat_comic_sans"
	end

	--PrintTable( textHatCache )
end)

function DrawTextHatText( text, font, color, offset, y, fx )
	if fx == "wave" then
		local chars = string.Split(text, "")
		local tracking = 1
		surface.SetFont( font )
		local widthcount = 0
		local tw, ch = surface.GetTextSize( text )
		cw = tw / #chars
		for i = 1, #chars do
			local char = chars[i]
			

			draw.SimpleText( char, font, offset + widthcount - tw/2, 16*(ch/70)*math.sin(-CurTime()*5 + i*(180/math.pi)) + y, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

			widthcount = widthcount + cw * tracking

		end
	elseif string.sub(fx,1,4) == "glow" then
		local glows = {
			["glow1"] = {Color(255,255,255), Color(255,0,0) },
			["glow2"] = {Color(0,0,255), Color(0,255,255)},
			["glow3"] = {Color(255,0,255), Color(0,255,255)},
			["glow4"] = {Color(255,0,0), Color(255,255,0)}
		}

		if glows[fx] then
			local col1 = table.Copy( glows[fx][1] )
			local col2 = table.Copy( glows[fx][2] )

			col2.a = 255*( math.max( math.sin(CurTime()*0.75), 0 ) )
			col1.a = 255 - 255*( math.max( math.sin(CurTime()*0.75), 0 ) )

			draw.SimpleText( text, font, offset, y, col1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( text, font, offset, y, col2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	elseif string.sub(fx,1,5) == "flash" then
		local flashs = {
			["flash1"] = {Color(255,255,255), Color(255,0,0) },
			["flash2"] = {Color(0,0,255), Color(0,255,255)},
			["flash3"] = {Color(255,0,255), Color(0,255,255)},
			["flash4"] = {Color(255,0,0), Color(255,255,0)}
		}

		if flashs[fx] then
			local col1 = table.Copy( flashs[fx][1] )
			local col2 = table.Copy( flashs[fx][2] )

			col2.a = 255*( math.floor((CurTime()*2)%2) )
			col1.a = 255 - 255*( math.floor((CurTime()*2)%2) )

			draw.SimpleText( text, font, offset, y, col1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( text, font, offset, y, col2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	elseif fx == "rainbow" then
		local col1 = HSVToColor( (CurTime()*100)%360, 1, 1 )
		draw.SimpleText( text, font, offset, y, col1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	else
		draw.SimpleText( text, font, offset, y, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
end

RS.TextHatEffects = {
	"none","glow1","glow2","glow3","glow4","flash1","flash2","flash3","flash4", "wave", "rainbow"
}

hook.Add("PostPlayerDraw", "TextHats", function(ply)
	if textHatCache[ply:SteamID64()] and drawtexthats:GetBool() == true then
		if ply:Alive() and ply:GetObserverMode() == OBS_MODE_NONE and textHatCache[ply:SteamID64()].col.a > 0 then
			local tx = textHatCache[ply:SteamID64()]
			local pos = ply:GetPos() + Vector(0,0,ply:Crouching() and 65 or 80)
			local ang = LocalPlayer():EyeAngles()
			ang:RotateAroundAxis( LocalPlayer():EyeAngles():Right(), 90 )
			ang:RotateAroundAxis( LocalPlayer():EyeAngles():Forward(), 90 )

			ang.roll = 90

			cam.Start3D2D( pos, ang, 0.03 + tx.size )
				surface.SetFont( tx.font )
				local tw, th = surface.GetTextSize( tx.text )
				tw = tw + 32
				local marquee_w = 600
				local ox = -tx.frac

				tx.frac = tx.frac + FrameTime()*60

				if ox <= -tw then
					tx.frac = 0
				end

				if tw < marquee_w then 
					tx.frac = 0
					marquee_w = tw 
				end

				-- https://facepunch.com/showthread.php?t=1274569&p=40851965&viewfull=1#post40851965

				render.ClearStencil()
				render.SetStencilEnable(true)

				render.SetStencilFailOperation(STENCILOPERATION_KEEP)
				render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
				render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
				render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
				render.SetStencilReferenceValue(1)

				surface.SetDrawColor(Color(0,0,0,1))
				surface.DrawRect( -marquee_w/2, -200, marquee_w, 400 )

				render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_LESSEQUAL)
				render.SetStencilPassOperation(STENCILOPERATION_REPLACE)

				if tx.effect ~= nil then
					DrawTextHatText( tx.text, tx.font, tx.col, ox, 0, tx.effect )
					DrawTextHatText( tx.text, tx.font, tx.col, ox - tw, 0, tx.effect )
					DrawTextHatText( tx.text, tx.font, tx.col, ox + tw, 0, tx.effect )
				end
				
				render.SetStencilEnable(false)
				
			cam.End3D2D()
		end
	end
end)

-- gifts

net.Receive("GiftNotify", function()
	RS:GiftNotify( net.ReadString() )
end)

function RS:GiftNotify( msg )
	if drawgifts:GetBool() == true then
		RS.Gifts.show = true
		RS.Gifts.timer = 6
		RS.Gifts.msg = msg
		surface.PlaySound( "garrysmod/save_load3.wav" )
	end
end

local gifts = {}
RS.Gifts = gifts
gifts.show = false
gifts.dy = -100
gifts.frac = 0
gifts.msg = "Meme"
gifts.timer = 0
hook.Add("HUDPaint","drawgifts", function()

	if gifts.timer > 0 then
		gifts.frac = gifts.frac + FrameTime()*4
	else
		gifts.frac = gifts.frac - FrameTime()*2
	end

	gifts.frac = math.Clamp( gifts.frac, 0, 1 )

	gifts.timer = gifts.timer - FrameTime()

	gifts.timer = math.Clamp( gifts.timer, 0, 60 )

	local x,y = ScrW()/2, ScrH() + 50 + QuadLerp( gifts.frac, 0, gifts.dy)

	surface.SetFont( "Screen_Small" )
	local tw, th = surface.GetTextSize( gifts.msg )
	tw = tw + 32

	local m = Matrix()
	m:Translate( Vector(x,y) )
	m:Rotate( Angle(0,4*math.sin(CurTime()*7),0) )
	m:Translate( -Vector(x,y) )

	cam.PushModelMatrix( m )

	surface.SetDrawColor( AuColors.New.E )
	surface.DrawRect(x-tw/2, y-16, tw, 32 )

	AuShadowText( gifts.msg, "Screen_Small", x,y, AuColors.New.B, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1)

	cam.PopModelMatrix()

end)

--RS:GiftNotify("Clientside lua refreshed!")

-- effects

hook.Add("PostPlayerDraw","EffectCreator", function( ply )
	if not ply.Effects then
		ply.Effects = {}
	end
	if ply:Alive() then
		for k,v in pairs( ply.Effects ) do
			--if #v > 0 then
				if v.enabled and v.last then
					if (CurTime() - v.last) > RS.Items[k].Interval then
						local ed = EffectData()
						ed:SetEntity( ply )
						util.Effect( RS.Items[k].Effect, ed )
						v.last = CurTime()
					end
				end
			--end
		end
	end
end)

net.Receive("SendHubEffect", function()
	local id64 = net.ReadString()
	local eff = net.ReadString()
	local add = tobool(net.ReadBit())

	local ply = player.GetBySteamID64( id64 )
	if IsValid( ply ) then
		if not ply.Effects then
			ply.Effects = {}
		end
		if add then
			ply.Effects[eff] = { enabled = true, last = CurTime() }
		else
			ply.Effects[eff] = { enabled = false, last = CurTime() }
		end

		--print(ply)
		--PrintTable( ply.Effects )
	end
end)

-- 3d stereoscopy effect

local RenderedIT = CreateMaterial("StereoSuperMat","UnlitTwoTexture",{["$basetexture"] = "dev/dev_measuregeneric01",["$texture2"] = "dev/dev_measuregeneric01"})
tex_LeftEye = render.GetMorphTex0()
tex_RightEye = render.GetMorphTex1()

local tabr = {}
	tabr[ "$pp_colour_addr" ] = 0
	tabr[ "$pp_colour_addg" ] = 255
	tabr[ "$pp_colour_addb" ] = 255
	tabr[ "$pp_colour_brightness" ] = 0
	tabr[ "$pp_colour_contrast" ] = 1
	tabr[ "$pp_colour_colour" ] = 1
	tabr[ "$pp_colour_mulr" ] = 1
	tabr[ "$pp_colour_mulg" ] = 0
	tabr[ "$pp_colour_mulb" ] = 0
local tabb = {}
	tabb[ "$pp_colour_addr" ] = 255
	tabb[ "$pp_colour_addg" ] = 0
	tabb[ "$pp_colour_addb" ] = 0
	tabb[ "$pp_colour_brightness" ] = 0
	tabb[ "$pp_colour_contrast" ] = 1
	tabb[ "$pp_colour_colour" ] = 1
	tabb[ "$pp_colour_mulr" ] = 0
	tabb[ "$pp_colour_mulg" ] = 1
	tabb[ "$pp_colour_mulb" ] = 1

function RS:RenderStereoscopy( ViewOrigin, ViewAngles )
	
	
	
	local OldRT = render.GetRenderTarget()

	--render.Clear( 0, 0, 0, 255 )
	
	local w = ScrW()
	local h = ScrH()
	
	local Right = ViewAngles:Right() * 1
	
	local view = {}
	
	view.y = ScrH() / 2 - h / 2
	view.w = w
	view.h = h
	view.angles = ViewAngles
	view.drawhud = true


	
	--Left
	view.origin = ViewOrigin + Right
	render.SetRenderTarget( tex_LeftEye )
	render.Clear(0,0,0,255)
	--
	render.RenderView( view )
	DrawColorModify( tabb )
	
	RenderedIT:SetTexture( "$basetexture",tex_LeftEye )

	-- Right
	view.origin = ViewOrigin - Right
	render.SetRenderTarget( tex_RightEye )
	render.Clear(0,0,0,255)
	--DrawColorModify( tabr )
	render.RenderView( view )
	DrawColorModify( tabr )
	
	RenderedIT:SetTexture( "$texture2",tex_RightEye )
	
	render.SetRenderTarget(OldRT)
	render.Clear(0,0,0,255)
	render.SetMaterial(RenderedIT)
	render.DrawScreenQuad()

	render.RenderHUD( 0, 0, ScrW(), ScrH() )
	
end



--[[---------------------------------------------------------
   The function to draw the bloom (called from the hook)
-----------------------------------------------------------]]
local function DrawInternal( ViewOrigin, ViewAngles, ViewFOV )

	if RS.GlassesEffect then
		RS:RenderStereoscopy( ViewOrigin, ViewAngles )
		-- Return true to override drawing the scene
		return true
	end

end
hook.Add("InitPostEntity","CoolEffects", function()
	hook.Add( "RenderScene", "RenderStereoscopyMeme", DrawInternal )
end)