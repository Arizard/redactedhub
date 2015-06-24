print("RedactedHub - Loaded cl_init.lua")
include("shared.lua")


local fontstandard = "Lucida Grande"
surface.CreateFont("Screen_Large", {
	font = fontstandard,
	size = 32,
	antialias = true,
	weight = 800
})
surface.CreateFont("Screen_Medium", {
	font = fontstandard,
	size = 24,
	antialias = true,
	weight = 800
})

surface.CreateFont("Screen_Small", {
	font = fontstandard,
	size = 18,
	antialias = true,
	weight = 800
})
surface.CreateFont("Screen_Tiny", {
	font = fontstandard,
	size = 12,
	antialias = true,
	weight = 600
})

function RS:ReceiveVip()
	surface.PlaySound("buttons/bell1.wav")
end

function RS:Initialize()

	print(" RedactedHub - Clientside Hub initialized")
end

net.Receive("RS:StoreChat", function()

	local msg = net.ReadString()
	chat.AddText( Color(255,255,255),"[",Color(231, 76, 60),"HUB",Color(255,255,255),"] ", msg )

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
	draw.DrawText( text, font, x+d, y+d, Color(0,0,0,col.a), ax, ay )
	draw.DrawText( text, font, x, y, col, ax, ay)
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
	RS:DestroyClientModel( net.ReadInt(32) )
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
	cmod.col = col
	cmod.ply = ply
	cmod.id = id
	cmod:SetNoDraw( true )
	cmod.isToken = token
	cmod.class = class
	cmod.id64 = id64

	

	print("RedactedHub - Creating model for",cmod.id64)

	cmod:SetModelScale( scl, 0 )

	RS.ClientSideModels[id] = cmod

	--PrintTable(cmod:GetTable())

end

RS.InPreview = false

function RS:RenderClientModels()
	
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
				m:SetPos(attach.Pos + x + y + z)
				local ang = attach.Ang
				ang:RotateAroundAxis( attach.Ang:Right(), m.angoff.pitch )
				ang:RotateAroundAxis( attach.Ang:Up(), m.angoff.yaw )
				ang:RotateAroundAxis( attach.Ang:Forward(), m.angoff.roll )

				m:SetAngles(ang)

				if (m.IsToken == false) or (not m.IsToken) then
					m:DrawModel()
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
						cam.Start3D2D(m:GetPos()+ang:Up()*3.5, ang, 0.105)
							RS.Items[m.class]:DrawTokenFace(0,0)
						cam.End3D2D()
						
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
hook.Add("CreateClientsideRagdoll", "RS:RagdollMaterials", function( ent, ragdoll )

	if ent:IsPlayer() then
		if ragdoll:IsValid() then
			ragdoll:SetMaterial( ent:GetMaterial() )
		end
	end
end)

local PLAYER = FindMetaTable("Player")

function PLAYER:IsVip()
	return self:GetNWBool("has_vip", false)
end