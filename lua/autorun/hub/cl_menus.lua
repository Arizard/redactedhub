print("loaded cl_menus.lua")
include("cl_jukebox_songs.lua")

local blur = Material("pp/blurscreen")
function HubDrawBlur(panel, amount)

	local x, y = panel:LocalToScreen(0,0)
	local w, h = ScrW(), ScrH()

	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(blur)

	for i = 1, 3 do -- 3 pass blur i guess?
		blur:SetFloat("$blur", (i/3) * (amount or 7))
		blur:Recompute()

		render.UpdateScreenEffectTexture()

		surface.DrawTexturedRect(x*-1,y*-1,w,h)
	end
end



local WINDOW = {}

function WINDOW:Init()

	self.w = 360
	self.h = 240
	self.padding = 8 

	-- add stuff below 8 + 16 + 8 (32)

	self.Title = "Blank Window"

	self:SetSize(self.w, self.h)
	self:Center()

	self.close = vgui.Create("DButton", self)
	self.close:SetSize(32,16)
	self.close:SetPos( self:GetWide() - 32 - self.padding, self.padding)
	self.close:SetText("")

	function self.close.Paint()
		surface.SetDrawColor( 215,0,0 )
		surface.DrawRect(0,0,32,16)
		--surface.SetDrawColor( 0,0,0,50 )
		--surface.DrawRect(0,10,32,6)
		--surface.SetDrawColor(255,0,0)
		--surface.DrawOutlinedRect(0,0,32,16)
	end

	function self.close.DoClick( self2 )
		self2:GetParent():Remove()
	end

	self:MakePopup()
end

function WINDOW:PerformLayout()
	self.close:SetPos( self:GetWide() - 32 - self.padding, self.padding)
end

function WINDOW:Paint()
	HubDrawBlur(self, 6)

	surface.SetDrawColor( HexColor("#ecf0f1") )
	surface.DrawRect(0,0, self:GetWide(), self:GetTall())

	draw.ShadowText( self.Title, "Screen_Medium", self.padding, self.padding/4, HexColor("#2ecc71"), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1 )

end

function WINDOW:SetTitle(title)
	self.Title = title
end
function WINDOW:GetTitle()
	return self.Title
end

vgui.Register("hub_window", WINDOW)


local BUTTN = {} -- custom buttons

function BUTTN:Init()
	self.w, self.h = 64,24
	self.color = {}
	self.color.up = Color(192, 57, 43)
	self.color.hover = Color(231, 76, 60)
	self.hover = false
	self.active = false

	self.font = "Screen_Small"
	self.offsets = {0,-11}

	self.text = "Label"

	self.b = vgui.Create("DButton", self)

	self.b.OnCursorEntered = function()
		self.hover = true
	end

	self.b.OnCursorExited = function()
		self.hover = false
	end

	self.b.OnMousePressed = function( self2, mkey )

		self:OnMousePressed(mkey)
	end

	function self.b:Paint() end
	self.b:SetText("")

	self.textcol = Color(255,255,255)
	self.textshad = 1
	--self.b.DoClick = function() self:DoClick() end

	self:SetColors( HexColor("#2ecc71"), HexColor("#3ad87d") )

end

function BUTTN:SetTextColor( col )
	self.textcol = col
end

function BUTTN:SetTextShadow( s )
	self.textshad = s
end

function BUTTN:PerformLayout()
	self.b:SetSize(self:GetWide(),self:GetTall())
end

function BUTTN:PaintOver()
	if self.hover == true or self.active == true then
		surface.SetDrawColor(self.color.hover)
	elseif self.hover == false then
		surface.SetDrawColor(self.color.up)
	end
	surface.DrawRect(0,0,self:GetWide(),self:GetTall())

	draw.ShadowText(self.text,self.font,self:GetWide()/2 , self:GetTall()/2 , self.textcol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, self.textshad)
end

function BUTTN:SetFont(fo)
	self.font = fo
end

function BUTTN:SetOffsets(x,y)
	self.offsets = {x,y}
end

function BUTTN:SetSelected( bool )

	self.active = bool

end

function BUTTN:SetText( text )

	self.text = text

end

function BUTTN:SetColors(upcol, hovercol)
	self.color.up = upcol
	self.color.hover = hovercol
end

function BUTTN:DoClick()

end

function BUTTN:DoRightClick()
end

function BUTTN:OnMousePressed( mkey )

	if mkey == MOUSE_LEFT then
		self:DoClick()
	end

	if mkey == MOUSE_RIGHT then
		self:DoRightClick()
	end

end

function BUTTN:IsDown()

	if self.hover == true then
		if input.IsMouseDown( MOUSE_LEFT ) then
			return true
		end
	end

	return false
end


vgui.Register("hub_button",BUTTN)


--hub multi panels

local MPANEL = {}

function MPANEL:Init()

	self.numbutts = 0

	self.buttonoffset = 0

	self:SetSize(640,320)
	self.panels = {}
	self.buttons = {}
	self.tabs = {}

	self.color = {
		HexColor("#2ecc71"), HexColor("#3ad87d")
	}

	self:PerformLayout()

	self.activetab = 0

	self.spacer = vgui.Create("DPanel",self)

	function self.spacer:Paint()
		surface.SetDrawColor(self:GetParent().color[2])
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())
	end
	self.spacer:SetPos(0,24)
	 -- Color(46, 204, 113)
	  -- Color(39, 174, 96)
	self.navleft = vgui.Create("hub_button", self)
	self.navleft:SetColors( Color(39, 174, 96), Color(46, 204, 113))
	self.navleft:SetText( "<" )
	self.navleft:SetSize(24,24)

	function self.navleft:Think()
		if self:IsDown() then
			self:GetParent().buttonoffset = self:GetParent().buttonoffset + 2 * (FrameTime()/(1/100))
			self:GetParent():PerformLayout()
		end
	end

	self.navright = vgui.Create("hub_button", self)
	self.navright:SetColors( Color(39, 174, 96), Color(46, 204, 113))
	self.navright:SetText( ">" )
	self.navright:SetSize(24,24)

	function self.navright:Think()
		if self:IsDown() then
			print("moving right")
			self:GetParent().buttonoffset = self:GetParent().buttonoffset - 2 * (FrameTime()/(1/100))
			self:GetParent():PerformLayout()
		end
	end

	self.navleft:SetZPos(99)
	self.navright:SetZPos(98)

	self:ArrowsVisible( false )
end

function MPANEL:ArrowsVisible( bool )

	self.navleft:SetVisible( bool )
	self.navright:SetVisible( bool )

end

function MPANEL:SetTab( idx )

	for i = 1, #self.tabs do
		
		self.buttons[self.tabs[i]]:SetSelected( false )
		self.panels[self.tabs[i]]:SetVisible( false )

	end

	self.buttons[self.tabs[idx]]:SetSelected( true )
	self.panels[self.tabs[idx]]:SetVisible( true )

end

function MPANEL:SetColors(c1, c2)
	self.color[1] = c1
	self.color[2] = c2

end

function MPANEL:AddTab(str_name)

	self.buttons[str_name] = vgui.Create("hub_button", self)
	self.buttons[str_name]:SetSize(92,24)
	self.buttons[str_name]:SetText(str_name)
	self.buttons[str_name]:SetColors(self.color[1], self.color[2])

	self.tabs[#self.tabs+1] = str_name

	self.activetab = #self.tabs
	self.buttons[str_name].idx = #self.tabs

	

	local temp = self.buttons[str_name]

	function temp:DoClick()
		local parent = self:GetParent()
		parent:SetTab( self.idx )
	end

	self.panels[str_name] = vgui.Create("DPanel", self)
	self.panels[str_name]:SetSize(self:GetWide(),self:GetTall()-28)
	self.panels[str_name]:SetPos(0,28)
	self.panels[str_name]:SetVisible(false)

	self.panels[str_name].Paint = function(self, w, h)
		surface.SetDrawColor( Color(0,0,0,0) )
		surface.DrawRect(0,0,w, h) -- meh
	end

	self:PerformLayout()

	self:SetTab( self.activetab )

	self.numbutts = self.numbutts + 1
	if self.numbutts * 92 > self:GetWide()-50 then
		self:ArrowsVisible( true )
	end

	return self.panels[str_name]

end

function MPANEL:PerformLayout()
	
	local maxoff = -((#self.tabs * 92) - self:GetWide()) -24*2 -8
	--print( #self.tabs * 92, self:GetWide() )
	if self.buttonoffset > 8 then self.buttonoffset = 8 end
	if self.buttonoffset < maxoff then self.buttonoffset = maxoff end

	if maxoff > 0 then self.buttonoffset = 8 end
	
	if self.navright then
		self.navright:SetPos(self:GetWide() - 24)
	end

	if self.spacer then
		self.spacer:SetSize(self:GetWide(), 4)
	end
	--print("perofrm ing layrioru", #self.tabs)
	for i = 1,#self.tabs do
		--print(i)
		self.buttons[self.tabs[i]]:SetPos(24+(i-1)*92+self.buttonoffset,0)
		self.buttons[self.tabs[i]].OriginalX = 8+(i-1)*92
		self.panels[self.tabs[i]]:SetSize(self:GetWide(),self:GetTall()-28)

	end

	--self.spacer:SetSize(self:GetWide(), 4)
end

-- function MPANEL:UpdateButtonOffset()
-- 	for i = 1,#self.tabs do
-- 		self.buttons[self.tabs[i]]:SetPos(8+(i-1)*92 + self.buttonoffset,0)
-- 	end
-- end



vgui.Register("hub_multipanel", MPANEL)

local M2PANEL = {}

function M2PANEL:Init()

	self:SetSize(640,320)
	self.panels = {}
	self.buttons = {}
	self.tabs = {}

	self.color = {
		HexColor("#2ecc71"), HexColor("#3ad87d")
	}

	self:PerformLayout()

	self.activetab = 0

	self.spacer = vgui.Create("DPanel",self)

	function self.spacer:Paint()
		surface.SetDrawColor(self:GetParent().color[2])
		--surface.DrawRect(0,0,self:GetWide(),self:GetTall())
	end
	self.spacer:SetPos(0,24)

	self.DisabledTabs = {}

end

function M2PANEL:DisableTab( idx )
	table.insert(self.DisabledTabs, idx)
	self.buttons[self.tabs[idx]]:SetSelected(false)
end

function M2PANEL:EnableTab( idx )
	table.RemoveByValue(self.DisabledTabs, idx)
end

function M2PANEL:SetTab( idx )

	if table.HasValue(self.DisabledTabs, idx) then return end

	for i = 1, #self.tabs do
		
		self.buttons[self.tabs[i]]:SetSelected( false )
		self.panels[self.tabs[i]]:SetVisible( false )

	end

	self.buttons[self.tabs[idx]]:SetSelected( true )
	self.panels[self.tabs[idx]]:SetVisible( true )

end

function M2PANEL:SetColors(c1, c2)
	self.color[1] = c1
	self.color[2] = c2

end

function M2PANEL:AddTab(str_name)

	self.buttons[str_name] = vgui.Create("hub_button", self)
	self.buttons[str_name]:SetSize(168,32)
	self.buttons[str_name]:SetText(str_name)
	self.buttons[str_name]:SetColors(self.color[1], self.color[2])

	self.tabs[#self.tabs+1] = str_name

	self.activetab = #self.tabs
	self.buttons[str_name].idx = #self.tabs

	

	local temp = self.buttons[str_name]

	function temp:DoClick()
		local parent = self:GetParent()
		parent:SetTab( self.idx )
	end

	self.panels[str_name] = vgui.Create("DPanel", self)
	self.panels[str_name]:SetSize(self:GetWide(),self:GetTall()-40)
	self.panels[str_name]:SetPos(0,40)
	self.panels[str_name]:SetVisible(false)

	self.panels[str_name].Paint = function() end

	self:PerformLayout()

	self:SetTab( self.activetab )

	return self.panels[str_name]

end

function M2PANEL:PerformLayout()
	if self.spacer then
		self.spacer:SetSize(self:GetWide(), 4)
	end
	--print("perofrm ing layrioru", #self.tabs)
	for i = 1,#self.tabs do
		--print(i)
		self.buttons[self.tabs[i]]:SetWide( self:GetWide()/#self.tabs * 1.01 )
		self.buttons[self.tabs[i]]:SetPos((i-1)*(self:GetWide()/#self.tabs),0)
		self.panels[self.tabs[i]]:SetSize(self:GetWide(),self:GetTall()-28)

	end

	--self.spacer:SetSize(self:GetWide(), 4)
end

vgui.Register("hub_multipanel2", M2PANEL)


local LABEL = {}

function LABEL:Init()
	self.text = "Label"
	self.color = Color(255,255,255)
	self.offsets = {0,0}
	self.font = "Screen_Small"
end

function LABEL:Paint()
	draw.ShadowText(self.text, self.font, 4,self:GetTall()/2,self.color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER,1)
end

function LABEL:SetText(text)
	self.text = text
end

function LABEL:SetColor(col)
	self.color = col
end

function LABEL:SetOffsets(x,y)
	self.offsets = {x,y}
end

function LABEL:SetFont( font )
	self.font = font
end

vgui.Register("hub_label",LABEL)

local hubdata = {}

net.Receive("OpenHub",function()
	hubdata = net.ReadTable()
	--print(hubdata.opentab)
	RS:CreateHubWindow( hubdata, tonumber( hubdata.opentab ) )
end)


local ICON = {}

function ICON:Init()
	self:SetSize(121,196)
	self.item = nil

	self.isToken = false

	self.inv = false

	self.equipped = false

	self.model = vgui.Create("DModelPanel", self)
	self.model:SetPos(2,2)
	self.model:SetSize(117,117)

	self.id = 0

	function self.model:OnCursorEntered() self:GetParent():OnCursorEntered2() end
	function self.model:OnCursorExited() self:GetParent():OnCursorExited2() end
	function self.model:OnMousePressed() self:GetParent():OnMousePressed2() end

	

	self.stock = 0

	self.b = vgui.Create("hub_button", self)
	self.b:SetSize(117, 22)
	self.b:SetPos(2,196-24)
	self.b:SetColors(Color(128,128,128), Color(255,75,75))
	
	
	self.trail = Material(")") -- brank

	self:PerformLayout()
end

function ICON:PerformLayout()

	if self.inv == false then
		if self.item then
			self.b:SetText(tostring(self.item.StorePrice).." "..RS.Currency )

			function self.b:DoClick()
				self.m = vgui.Create("DMenu")
				self.m.pur = self.m:AddOption("Purchase ("..tostring(self:GetParent().item.StorePrice).." "..RS.Currency..")", function() BuyItem( self:GetParent().item.Class ) end):SetIcon( "icon16/coins_delete.png")
			
				self.m:Open()
			end
		end
	end

	if self.inv == true then
		self.b:SetText("Options")

		function self.b:DoClick()

			self.m = vgui.Create("DMenu")
			if self:GetParent().item.Category ~= "crates" then
				self.m.e = self.m:AddOption( "Toggle", function() ToggleItem( self:GetParent():GetID() ) end ):SetIcon( "icon16/user_green.png" )
			else
				self.m.e = self.m:AddOption( "Open", function() OpenCrate( self:GetParent():GetID() ) end ):SetIcon( "icon16/briefcase.png" )
			end
			self.m.s = self.m:AddOption( "Sell ("..tostring(math.floor(self:GetParent().item.StorePrice * RS.RefundRatio)).." "..RS.Currency..")", function() SellItem( self:GetParent():GetID() ) end ):SetIcon( "icon16/coins_add.png")

			self.m.send = self.m:AddSubMenu("Send To")

			for k,v in ipairs(player.GetAll()) do
				if v ~= LocalPlayer() then
					self.m.send:AddOption( v:Nick(), function() 
						
						RunConsoleCommand( "shop_senditem", string.Split(v:Nick(), " ")[1], tostring(self:GetParent():GetID()) )
					end):SetIcon("icon16/email_go.png")
				end
			end

			self.m:Open()

		end

		self.b:SetColors(Color(128,128,128), Color(75,255,75))
	end

	self.b:SetWide( self:GetWide()-4 )
	self.model:SetWide( self:GetWide()-4 )

end
local eqmat = Material("icon16/user_green.png")
function ICON:Paint()
	surface.SetDrawColor(Color(48,48,48,170))
	surface.DrawRect(0,0,self:GetWide(),self:GetTall())

	if not self.item then return nil end

	draw.ShadowText(self.item.Name, "Screen_Small", self:GetWide()/2, 121, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1)
	draw.ShadowText(self.item.Description, "Screen_Tiny", self:GetWide()/2, 121+18, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1)
	if self.inv == false then
		draw.ShadowText(tostring(self.stock).." In Stock", "Screen_Tiny", self:GetWide()/2, 121+17*2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1)
	else
		draw.ShadowText("No. "..tostring(self:GetID()), "Screen_Tiny", self:GetWide()/2, 121+17*2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1)
	end
	--draw.ShadowText("No. "..tostring(self.id), "Screen_Tiny", self:GetWide()/2, 121+17*2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1)
	--image/color/model size: 117/117
	if self.item.Category == "colours" then
		surface.SetDrawColor(self.item.Col)
		surface.DrawRect(self:GetWide()/2 - 117/2,2,117,117)
	elseif self.item.Category == "trails" then
		surface.SetMaterial( self.trail )
		surface.SetDrawColor(self.item.Col)
		surface.DrawTexturedRect(self:GetWide()/2 - 117/2,2,117,117)
	end

	if self.isToken == true then

		surface.SetDrawColor(32,32,32)
		surface.DrawRect(2,2,117,117)

		self.item:DrawTokenFace(60,60)

	end

	if self.item.Category == "boosts" then
		self.item:DrawBoostIcon(self:GetWide()/2 - 117/2, 2)
	end

	if self.item.Category == "taunts" then
		draw.ShadowText("Click to listen.", "Screen_Tiny", self:GetWide()/2, 80, Color(0,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1)
		draw.ShadowText("Press B to taunt.", "Screen_Tiny", self:GetWide()/2, 90, Color(0,255,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1)
	end

	if self.equipped == true then
		surface.SetMaterial( eqmat )
		surface.SetDrawColor(255,255,255)
		surface.DrawTexturedRect(4,4,16,16)
	end

	if (self.item.StorePrice <= LocalPlayer():GetMoney()) or self.inv == true then
		self.b:SetColors(Color(128,128,128), Color(75,255,75))
	else
		self.b:SetColors(Color(128,128,128), Color(255,75,75))
	end

end
function ICON:SetItem( tab )
	self.item = tab

	if not self.item then
		self:Remove()
		return false
	end

	self.b:SetColors(Color(128,128,128), Color(255,40,40))
	
	self.oldcol = VecToCol(LocalPlayer():GetPlayerColor())
	self.oldmat = LocalPlayer():GetMaterial()
	self.oldpmod = LocalPlayer():GetModel()

	self.b:SetText(tostring(self.item.StorePrice).." "..RS.Currency)
	if self.item.Category == "colours" then
		self.model:SetModel("models/props_junk/metal_paintcan001a.mdl")
		self.model:SetLookAt(Vector(0,0,0))
		self.model:SetFOV(20)

	elseif self.item.Category == "materials" then
		self.model:SetModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
		self.model:SetLookAt(Vector(0,0,0))
		self.model:SetFOV(25)
		self.model.Entity:SetMaterial( self.item.Material )
		--print("Material is",self.item.Material)
	elseif self.item.Category == "trails" then
		self.model:SetVisible(false)
		self.trail = Material(self.item.Trail)
	elseif self.item.Category == "skins" then
		self.model:SetModel(self.item.PlayerModel)
		self.model:SetFOV(20)
		self.model:SetLookAt(Vector(0,0,60))

		function self.model:LayoutEntity(ent)
			ent:SetAngles(Angle(0,20,0))
		end

	elseif self.item.Category == "boosts" then
		self.model:SetModel("models/props_c17/utilityconnecter006.mdl")
		self.model:SetFOV(50)
		self.model:SetCamPos( Vector(0,50,40))
		self.model:SetLookAt( Vector(0,0,12) )
		function self.model:LayoutEntity( ent )
			ent:SetModelScale(2,0)
			ent:SetAngles( Angle( ent:GetAngles().pitch +2,90,0) )
		end
	elseif self.item.Category == "taunts" then
		self.model:SetModel("models/props_lab/huladoll.mdl")
		self.model:SetFOV(10)
		self.model:SetLookAt(Vector(0,0,0))
	elseif self.item.Category == "hats" then
		self.model:SetModel(self.item.HatModel)
		self.model:SetFOV(25)
		self.model:SetLookAt(Vector(0,0,0))
		self.model.Entity:SetMaterial( self.item.HatMat )
		self.model.Entity:SetColor( self.item.HatCol )
	elseif self.item.Category == "crates" then
		self.model:SetModel(self.item.CrateModel)
		self.model:SetFOV(35)
		self.model:SetLookAt(Vector(0,0,5))
		self.model.Entity:SetMaterial( self.item.CrateMat )
	end

	self:PerformLayout()
end
function ICON:SetStock( amt )
	self.stock = amt
end
function ICON:OnCursorEntered2()

	--print("Entered",self.item.Category)

	if not self.item then return end

	if self.item.Category == "materials" then
		
		RS.PlayerModelPreview.Entity:SetMaterial( self.item.Material )
	end
	
	if self.item.Category == "skins" then
		RS.PlayerModelPreview:SetModel(self.item.PlayerModel)
	end

	if self.item.Category == "hats" then
		local idtouse = self:GetID()
		self.item:OnEquip( LocalPlayer(), idtouse )
	end

	if self.item.Category == "colours" then
		
		RS.PlayerModelPreview:SetColor( self.item.Col )
		RS.PlayerModelPreview.Entity.PlyCol = ColToVec( self.item.Col )
		--print(ColToVec( self.item.Col ))
		RS:InvalidatePlayerColor()
	end

end

function ICON:OnCursorExited2()

	--print("Exited",self.item.Category)

	if not self.item then return end
	if self.item.Category == "colours" then
		RS.PlayerModelPreview:SetColor( LocalPlayer():GetColor() or Color(255,255,255) )
		RS.PlayerModelPreview.Entity.PlyCol = LocalPlayer():GetPlayerColor()
		--print(LocalPlayer():GetPlayerColor())
	elseif self.item.Category == "materials" then
		RS.PlayerModelPreview.Entity:SetMaterial( LocalPlayer():GetMaterial() )
	elseif self.item.Category == "skins" then
		RS.PlayerModelPreview:SetModel(LocalPlayer():GetModel())
		
		RS.PlayerModelPreview:SetColor( LocalPlayer():GetColor() or Color(255,255,255) )
		RS.PlayerModelPreview.Entity.PlyCol = LocalPlayer():GetPlayerColor() -- we need heasp of stuff because playermodel resets shit
		RS.PlayerModelPreview.Entity:SetMaterial( LocalPlayer():GetMaterial() )


	elseif self.item.Category == "hats" then
		--RS.PlayerModelPreview.Entity.HatPreviewID = self.id
		
		local idtouse = self:GetID()
		if type(idtouse) == "string" or self.equipped == false then
			self.item:OnHolster( LocalPlayer(), idtouse )
		end
	end

end

function ICON:OnMousePressed2()

	if not self.item then return end
	if self.item.Category == "taunts" then
		surface.PlaySound(self.item.TauntSound)
	end

end

function ICON:SetInventoryItem( bool )
	self.inv = bool
	self:PerformLayout()
end

function ICON:SetEquipped( bool )
	self.equipped = bool
	--print(bool)
	if self.item then
		if bool == true then
			if self.item.Category == "materials" then
				RS.Items[self.item.Class]:OnEquip( RS.PlayerModelPreview.Entity )
			end
		else
			if self.item.Category == "materials" then
				RS.Items[self.item.Class]:OnHolster( RS.PlayerModelPreview.Entity )
			end
		end
	end

end

function ICON:SetID( num )
	--print("Attempting to set id "..tostring(num))
	self.id = num
	self:PerformLayout()
end

function ICON:GetID()
	if self.id == 0 then
		return self.item.Class
	else
		return self.id
	end
end

function ICON:SetIsToken( bool )
	self.isToken = bool
end

vgui.Register("hub_icon",ICON)

function RS:StoreMessage( msg )
	RS.PlayerModelPreview.LastMsg = msg
	RS.PlayerModelPreview.Alpha = 700
end

if not RS.JukeQueue then
	RS.JukeQueue = {}
end

RS.JukeQueue_Played = {}
RS.JukeSongs_Played = {}

RS.JukeQueueIndex = 1
RS.JukeState = "cyclequeue"
local JukeStates = {
	["shuffleall"] = "Shuffle All",
	["shufflequeue"] = "Shuffle Queue",
	["cycleall"] = "Cycle All",
	["cyclequeue"] = "Cycle Queue"
}

function RS:JukeboxPickRandom()
	local songlist = {}
	local possiblesongs = {}
	for artist, songs in orderedPairs( RS.JukeSongs ) do -- we need to put all the songs into a niiiiice format - table = {{artist, name, link}}
		
		for songname, link in orderedPairs( songs ) do
			table.insert(songlist, {artist, songname, link})
		end

	end

	for k, data in ipairs( songlist ) do
		if not RS.JukeSongs_Played[data[1].." "..data[2]] then
			RS.JukeSongs_Played[data[1].." "..data[2]] = 0
		end
	end

	local lowest = 999999
	local song = ""

	for k,v in pairs( RS.JukeSongs_Played ) do
		if lowest > v then
			lowest = v
			song = k
		end
	end
	if song == "" then
		lowest = 0
	end

	-- now get all the possible songs (songs which have equal plays to the minimum)
	for k,data in ipairs( songlist ) do
		if lowest == RS.JukeSongs_Played[data[1].." "..data[2]] then
			table.insert( possiblesongs, data )
		end
	end

	local chosen = table.Random( possiblesongs ) -- YOU WERE MEANT TO BE THE CHOSEN ONE!
	RS.JukeSongs_Played[chosen[1].." "..chosen[2]] = RS.JukeSongs_Played[chosen[1].." "..chosen[2]] + 1

	--PrintTable( RS.JukeSongs_Played );
	return chosen

end

function RS:JukeboxPlayPrevious()
	if RS.JukeState == "cyclequeue" then
		if #RS.JukeQueue == 0 then return false end
		RS.JukeQueueIndex = RS.JukeQueueIndex -1
		if RS.JukeQueueIndex < 1 then RS.JukeQueueIndex = #RS.JukeQueue end
		local data = RS.JukeQueue[RS.JukeQueueIndex]
		RS:JukeboxStartPlayer( data[1], data[2], data[3] )
	end
	if RS.JukeState == "shuffleall" then
		RS:JukeboxPlayNext()
	end
	if RS.JukeState == "shufflequeue" then

		RS:JukeboxPlayNext()
	end
end

function RS:JukeboxPlayNext()
	if RS.JukeState == "cyclequeue" then

		if #RS.JukeQueue == 0 then return false end

		RS.JukeQueueIndex = RS.JukeQueueIndex +1
		if RS.JukeQueueIndex > #RS.JukeQueue then RS.JukeQueueIndex = 1 end
		local data = RS.JukeQueue[RS.JukeQueueIndex]
		RS:JukeboxStartPlayer( data[1], data[2], data[3] )
	end
	if RS.JukeState == "shuffleall" then
		local data = RS:JukeboxPickRandom()
		
		RS:JukeboxStartPlayer( data[1], data[2], data[3] )
	end
	if RS.JukeState == "shufflequeue" then
		if #RS.JukeQueue == 0 then return false end
		for k, song in ipairs( RS.JukeQueue ) do
			local data = song
			if not RS.JukeQueue_Played[data[1].." "..data[2]] then
				RS.JukeQueue_Played[data[1].." "..data[2]] = 0
			end
		end

		--find least played song
		local lowest = 999999999
		local song = ""

		for k,v in pairs( RS.JukeQueue_Played ) do
			if lowest > v then
				lowest = v
				song = k
			end
		end

		if song == "" then
			lowest = 0
		end

		local possiblesongs = {}
		for k, song in ipairs( RS.JukeQueue ) do
			local data = song
			if lowest == RS.JukeQueue_Played[data[1].." "..data[2]] then
				table.insert(possiblesongs, song)
			end
		end

		local data = table.Random(possiblesongs)

		if not data then return false end

		local timeout = 0

		-- while (data[2] == RS.JukeCurrent[2] or data[2] != "No Song" ) and timeout < 20 do
		-- 	data = table.Random(possiblesongs) -- this shoudlnt happen
		-- 	timeout = timeout + 1
		-- end

		

		RS:JukeboxStartPlayer( data[1], data[2], data[3] )

		RS.JukeQueue_Played[data[1].." "..data[2]] = RS.JukeQueue_Played[data[1].." "..data[2]] + 1 -- increase play counter

		-- print("Lowest: ", lowest, "song: ", song, "timeout: ", timeout )
		-- PrintTable( RS.JukeQueue )
		-- PrintTable( RS.JukeQueue_Played )
	end
end

function RS:JukeboxStartPlayer( artist, song, link )
	
	link = string.Replace(link, "https://www.youtube.com/watch?v=", "")
	link = string.Replace(link, "http://www.youtube.com/watch?v=", "")
	--link = string.Replace(link, "/watch?v=","/embed/")
	--link = link.."?autoplay=1"
	local embed = "http://arizard.github.io/youtube_jukebox/host.html?v=" .. link .."&volume="..tostring(GetConVarNumber("grhub_jukebox_volume"))
	--``print(embed)
	RS.JukePlayer:OpenURL(embed)
	RS.JukePlayer:SetAllowLua( true )
	RS.JukeCurrent = {artist,song,embed} -- parents everyehwere

	timer.Create("FixJukeboxVolumeStuff", 3,0, function()
		RS.JukePlayer:Call("ytplayer.setVolume( "..tonumber( GetConVarNumber("grhub_jukebox_volume") ).." );")
		
		-- net.Start("RS_JukeboxNowPlaying")
		-- net.WriteString( util.TableToJSON( RS.JukeCurrent ) )
		-- net.SendToServer()
	end )

	
end

if not file.Exists("grhub_jukebox_queue.txt", "DATA") then
	file.Write("grhub_jukebox_queue.txt", "[]")
end

RS.JukeQueue = util.JSONToTable(file.Read("grhub_jukebox_queue.txt", "DATA"))

function RS:UpdateJukeQueue()

	self.JukeQueueList:Clear()

	local lb = self.JukeQueueList:Add("hub_label")
	lb:SetSize(self.JukeQueueList:GetWide(), 64)
	lb:SetText( "Queued Songs" )
	lb:SetFont("Screen_Medium")
	lb:SetColor(HexColor("#2ecc71"))
	lb:SetOffsets( 0,0 )

	for i=1,#RS.JukeQueue do
		local track = RS.JukeQueue[i]

		local artist = track[1]
		local song = track[2]
		local link = track[3]

		local jb = self.JukeQueueList:Add( "hub_button" )
		jb:SetSize(self.JukeQueueList:GetWide()-1, 28)
		jb:SetText(artist.." - "..song)
		jb:SetTextColor( HexColor("#606060") )
		jb:SetTextShadow( 0 )
		jb:SetColors(Color(128,128,128, 90), Color(52, 152, 219, 90))
		jb.link = link
		jb.name = song
		jb.artist = artist
		jb.index = i

		function jb:DoClick()
			local mn = vgui.Create("DMenu", self)
			mn:AddOption("Play Song", function()
				RS:JukeboxStartPlayer( artist, song, link )
			end):SetIcon("icon16/control_play_blue.png")
			mn:AddOption("Unqueue Song", function()
				table.remove(RS.JukeQueue, self.index )
				RS:UpdateJukeQueue()
			end):SetIcon("icon16/script_delete.png")

			mn:Open()
		end
	
	end

	file.Write("grhub_jukebox_queue.txt", util.TableToJSON( RS.JukeQueue ) )

end

function RS:ImproveScrollbar( vbar )
	vbar:SetWidth( 8 )

	function vbar:Paint(w, h)
		draw.RoundedBox(4, 0,0,w,h, Color(0,0,0,80) )
	end
	function vbar.btnUp:Paint(w, h) end
	function vbar.btnDown:Paint(w, h) end
	function vbar.btnGrip:Paint(w, h)
		draw.RoundedBox(4, 0,0,w,h, Color(0,0,0,200) )
	end
end

function RS:CreateHubWindow( hubdata, opentab )

	RS.InPreview = true

	local hub = vgui.Create("hub_window")
	hub:SetTitle(RS.HubTitle)
	hub:SetSize(ScrW()-16, ScrH()-16)
	--hub:SetSize(800,600)

	RS.HubWindow = hub
	
	hub:Center()

	function hub:OnRemove()
		RS.InPreview = false
	end

	hub.largemulti = vgui.Create("hub_multipanel2",hub)

	-- padded size: 1008, 536
	-- top left: 8, 32

	hub.largemulti:SetSize(hub:GetWide()-16, hub:GetTall() - 32 - 8)
	hub.largemulti:SetPos(8,32)
	local storetab = hub.largemulti:AddTab("Store")
	--local inventory = hub.largemulti:AddTab("Inventory")
	local juketab = hub.largemulti:AddTab("Jukebox")
	local supp = hub.largemulti:AddTab("Support Us")
	local info = hub.largemulti:AddTab("Commands")

	-- info panel, i.e commands
	info.html = vgui.Create("DHTML", info)
	info.html:SetSize(info:GetWide(),info:GetTall())
	info.html:SetPos(0,0)
	info.html:SetHTML( RS.InfoHTML )
	function info.html:Paint()
		surface.SetDrawColor(32,32,32)
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())
	end
	
	if LocalPlayer():IsSuperAdmin() then
		local adm = hub.largemulti:AddTab("Admin")

		-- admin tab
		adm.scr = vgui.Create("DScrollPanel", adm)
		adm.scr:SetSize(adm:GetWide()-4, adm:GetTall() -16 -4)
		adm.scr:SetPos(2,2)
		RS:ImproveScrollbar( adm.scr:GetVBar() )

		-- create a list of players and then give them properties

		adm.list = vgui.Create("DListView")
		adm.scr:AddItem( adm.list )
		adm.list:SetPos(0,0)
		adm.list:SetSize( adm.scr:GetWide(), adm.scr:GetTall() )
		
		adm.list:AddColumn("Player")
		adm.list:AddColumn("SteamID")
		adm.list:AddColumn("Balance")
		adm.list:AddColumn("Is Admin")

		for k,v in ipairs( player.GetAll() ) do
			local line = adm.list:AddLine( v:Nick(), v:SteamID(), v:GetMoney(), v:IsSuperAdmin() and "Super Admin" or "" )
		end

		function adm.list:OnClickLine( li, is )
			local menu = DermaMenu()

			local givevip = menu:AddOption("Give VIP")
			local takevip = menu:AddOption("Revoke VIP")
			local sid = menu:AddOption("Copy SteamID")

			givevip:SetIcon("icon16/star.png")
			takevip:SetIcon("icon16/box.png")
			sid:SetIcon("icon16/page_copy.png")

			function givevip:DoClick()
				RunConsoleCommand("shop_givevip", li:GetValue(1) )
			end
			function takevip:DoClick()
				RunConsoleCommand("shop_takevip", li:GetValue(1) )
			end
			function sid:DoClick()
				SetClipboardText( li:GetValue(2) )
			end

			menu:Open()
		end
	end



	supp.html = vgui.Create("DHTML", supp)
	supp.html:OpenURL("http://steamcommunity.com/groups/vhs7")
	supp.html:SetSize(supp:GetWide(),supp:GetTall())
	--we need to create a button over the screen, so that when they click it opens through the steam overlay.
	supp.butt = vgui.Create("DButton", supp)
	supp.butt:SetSize(supp:GetWide(), supp:GetTall())
	supp.butt:SetText("")
	supp.butt.Paint = function(self, w, h)
		surface.SetDrawColor(64,64,64,100)
		surface.DrawRect(0,0,w,h)
		draw.ShadowText("Click to view in Steam Overlay", "Screen_Large", w/2, h/2-32, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1)
	end
	supp.butt.DoClick = function() gui.OpenURL("http://steamcommunity.com/groups/vhs7") end

	--hub.largemulti:DisableTab( 6 )
	--hub.largemulti:DisableTab( 2 )

	-- below the navbar
	-- top left: 8, 72
	-- preview store items
	local previewcon = vgui.Create("DPanel", storetab)
	previewcon:SetSize( storetab:GetWide()*0.3333333333 -8, storetab:GetTall() - 36)
	previewcon:SetPos(storetab:GetWide()*0.66666666666 + 8, 24)
	function previewcon:Paint()
		surface.SetDrawColor(225,225,225)
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())

		local cs = 24
		local cnw = math.ceil(self:GetWide()/(cs*2))
		local cnh = math.ceil(self:GetTall()/(cs))

		surface.SetDrawColor(210,210,210)
		
			
		for i = 1, cnw do	
			for j = 1, cnh do
				local cx = ((i-1)*cs)*2
				local cy = ((j-1)*cs)
				if j%2 == 1 then
					cx = cx + cs 
				end
				surface.DrawRect(cx,cy,cs,cs)
				--draw.SimpleText(tostring(i)..","..tostring(j%2),"Screen_Tiny",cx,cy,Color(0,0,0))
			end
		end
	end

	local moneybg = vgui.Create("DPanel", previewcon)
	moneybg:SetSize(previewcon:GetWide(), 64)
	moneybg:SetPos(0,previewcon:GetTall()-64)

	function moneybg:Paint()
		surface.SetDrawColor( HexColor("#2ecc71") )
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())

		draw.ShadowText("You have "..tostring(LocalPlayer():GetMoney()).." "..RS.Currency, "Screen_Medium", self:GetWide()/2, self:GetTall()/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1)
	end

	local smoneybg = vgui.Create("DPanel", previewcon)
	smoneybg:SetSize(previewcon:GetWide(), 64)
	smoneybg:SetPos(0,0)

	function smoneybg:Paint()
		surface.SetDrawColor( HexColor("#2ecc71") )
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())

		draw.ShadowText("The Store has "..tostring(GetGlobalInt("StoreMoney")).." "..RS.Currency, "Screen_Medium", self:GetWide()/2, self:GetTall()/2, HexColor("#ecf0f1"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1)
	end

	RS.PlayerModelPreview = vgui.Create("DModelPanel",previewcon)
	RS.PlayerModelPreview:SetSize(previewcon:GetWide(), previewcon:GetTall()-128)
	RS.PlayerModelPreview:SetPos(0,64)
	RS.PlayerModelPreview:SetModel( LocalPlayer():GetModel() )
	RS.PlayerModelPreview.Entity.PlyCol = LocalPlayer():GetPlayerColor()
	RS.PlayerModelPreview.Entity.NCol = LocalPlayer():GetColor() or Color(255,255,255)

	--function RS.PlayerModelPreview.Entity:GetColor() return self.NCol end
	RS.PlayerModelPreview.rot = 0
	RS.PlayerModelPreview.rotmod = 0
	RS.PlayerModelPreview.ox = 0
	RS.PlayerModelPreview.nx = 0
	RS.PlayerModelPreview.dragging = false
	function RS.PlayerModelPreview:LayoutEntity(ent)
		ent:SetAngles(Angle(0,self.rot + self.rotmod,0))
		
	end
	function RS.PlayerModelPreview:OnMousePressed( key )
		if key == MOUSE_LEFT then
			self.dragging = true
		end
	end
	function RS.PlayerModelPreview:OnMouseReleased( key )
		if key == MOUSE_LEFT then
			self.dragging = false
			--self.rot = self.rotmod
		end
	end

	function RS.PlayerModelPreview:OnCursorMoved( cx, cy )
		if self.dragging then
			self.nx = cx
			self.rot = self.rot + self.nx - self.ox
		end
			self.ox = cx

		--print(self.rot,self.ox,self.nx,self.dragging)
	end
	function RS.PlayerModelPreview:DrawModel()
		local x, y = self:LocalToScreen( 0, 0 )	

		if not LocalPlayer():Alive() or LocalPlayer():GetObserverMode() ~= OBS_MODE_NONE then return else self.Entity:DrawModel() end

		for id, m in pairs(RS.ClientSideModels) do
			if IsValid(m) then

				if m.ply == LocalPlayer() and RS.InPreview == true then
					local atid = self.Entity:LookupAttachment(m.att)
					local attach = self.Entity:GetAttachment(atid)

					if attach then
					
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
						m:SetColor( m.col or Color(255,255,255) )						
						m:DrawModel()


						if m.isToken then
							if RS.Items[m.class].IsToken == true then
								--print("Drawing Token")
								ang:RotateAroundAxis( ang:Up(), 90 )
								--cam.Start3D2D(Vector( m:GetPos().x, m:GetPos().y, m:GetPos().z ) * (1/self:GetFOV()), ang, 0.105)
								cam.IgnoreZ( true )
								cam.Start3D2D(m:GetPos() + ang:Up()*2.75 + ang:Right()*-20.75 + ang:Forward()*-115.3, ang, 0.105)
								--print(m:GetPos())
									RS.Items[m.class]:DrawTokenFace(30,30)
								cam.End3D2D()
								cam.IgnoreZ( false )
							end
						end

					end
				end
			end
		end

		self.Entity:SetColor( self.Entity.NCol )
	end
	RS.PlayerModelPreview:SetFOV( 50 )

	RS.PlayerModelPreview.LastMsg = "Initialized Preview."
	RS.PlayerModelPreview.Alpha = 700

	function RS.PlayerModelPreview:PaintOver()
		local m = self.LastMsg
		local a = self.Alpha

		--if a > 255 then a = 255 end

		local w, h = self:GetWide()*0.95, 30
		local x = self:GetWide()/2 - w/2
		local y = 16

		surface.SetDrawColor(HexColor("#E74C3C",a))
		surface.DrawRect(x,y, w, h)

		draw.ShadowText(m, "Screen_Small", self:GetWide()/2, y + h/2, Color(255,255,255,a > 255 and 255 or ( a > 0 and a or 0 )), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1)

		if self.Alpha > 0 then
			self.Alpha = self.Alpha - 255 * FrameTime() * 1/2
			--print(FrameTime())
		elseif self.Alpha < 0 then
			self.Alpha = 0
		end
		local x, y = self:LocalToScreen( 0, 0 )	
		-- cam.IgnoreZ( true )
		-- cam.Start3D( self:GetCamPos(), self:GetLookAng(), self:GetFOV(), x, y, self:GetWide(), self:GetTall() )
		-- 	cam.Start3D2D( self.Entity:GetPos(), self.Entity:GetAngles(), 0.25 )
		-- 		surface.SetDrawColor( 255,0,0 )
		-- 		surface.DrawRect( -500, -500, 1000, 1000 )
		-- 	cam.End3D2D()
		-- cam.End3D()
		-- cam.IgnoreZ( false )

	end

	function RS.PlayerModelPreview.Entity:GetPlayerColor() 
		print( self.PlyCol, "meme" )
		return self.PlyCol 
	end



	local store = vgui.Create("hub_multipanel", storetab)
	store:SetPos(0,0)
	store:SetSize(store:GetParent():GetWide()*0.666666666,store:GetParent():GetTall())
	
	store.Categories = {}
	for k,v in ipairs(RS.Categories) do
		if v ~= "tokens" then
			local tab = store:AddTab(string.CapFirst(v))
			tab.scr = vgui.Create("DScrollPanel", tab)
			tab.scr:SetSize(tab:GetWide()-4, tab:GetTall()-16-4)
			tab.scr:SetPos(2,2)

			RS:ImproveScrollbar( tab.scr:GetVBar() )

			tab.list = vgui.Create("DIconLayout")
			tab.scr:AddItem(tab.list)
			tab.list:SetSize(tab.scr:GetWide(), tab.scr:GetTall())
			tab.list:SetSpaceX(4)
			tab.list:SetSpaceY(4)
			tab.list:SetPos(0,0)

			store.Categories[v] = tab.list
		end
	end

	if RS.Items then
		for k,v2 in pairs(RS.ItemsOrdered) do
			v = RS.Items[v2] -- some black magic to make it all ordered. I'm pretty sure i'm my own grandfather now.
			if v.Buyable == true then
				local icon = vgui.Create("hub_icon")
				icon:SetItem(v)
				icon:SetStock( hubdata.stock[v.Class] )
				--icon:SetWide( store.Categories[ v.Category ]:GetWide()/6 - 7*4 )
				--print(v.Category)
				store.Categories[ v.Category ]:Add( icon )
			else
				local icon = vgui.Create("hub_icon")
				icon:SetItem(v)
				icon:SetStock( 0 )
				if store.Categories[ v.Category ] then
					store.Categories[ v.Category ]:Add( icon )
				end
			end
		end
	end
	
	store:PerformLayout()

	local inventory = store:AddTab("Inventory")

	inventory.scr = vgui.Create("DScrollPanel", inventory)
	inventory.scr:SetSize(inventory:GetWide()-4, inventory:GetTall() -16 -4)
	inventory.scr:SetPos(2,2)
	RS:ImproveScrollbar( inventory.scr:GetVBar() )

	inventory.list = vgui.Create("DIconLayout")
	inventory.scr:AddItem( inventory.list )
	inventory.list:SetPos(0,0)
	inventory.list:SetSpaceX(4)
	inventory.list:SetSpaceY(4)
	inventory.list:SetSize(inventory.scr:GetWide()-4, inventory.scr:GetTall())

	RS.InventoryList = inventory.list

	--add inventory items
	if hubdata.owneditems then
		for k,v in ipairs(hubdata.owneditems) do
			local icon = vgui.Create("hub_icon")
			local worked = icon:SetItem(RS.Items[v["class"]])
			if worked ~= false then
				icon:SetInventoryItem( true )
				icon:SetEquipped( tobool(v["equipped"]) )
				icon:SetID( tonumber(v["ID"]) )

				icon:SetIsToken( RS.Items[v["class"]].IsToken )

				inventory.list:Add(icon)
			end
		end
	end

	-- --information
	-- info.html = vgui.Create("DHTML", info)
	-- info.html:SetSize(info:GetWide(),info:GetTall())
	-- info.html:SetPos(0,0)
	-- info.html:OpenURL("http://gameredacted.net")
	-- function info.html:Paint()
	-- 	surface.SetDrawColor(32,32,32)
	-- 	surface.DrawRect(0,0,self:GetWide(),self:GetTall())
	-- end

	local juke = vgui.Create("hub_multipanel", juketab)
	juke:ArrowsVisible( false )

	local queue = vgui.Create("hub_multipanel", juketab)
	queue:ArrowsVisible( false )
	queue:SetPos( queue:GetParent():GetWide()/2+4, 0 )
	queue:SetSize( queue:GetParent():GetWide()/2 - 4, queue:GetParent():GetTall())
	queue.browse = queue:AddTab("Queue")
	
	juke:SetPos(0,0)
	juke:SetSize(juke:GetParent():GetWide()/2 - 4,juke:GetParent():GetTall())


	juke.browse = juke:AddTab("Tracklist")


	--jukebox controls size: parentwidth, 100
	juke.play = vgui.Create("hub_button", juke.browse)
	juke.play:SetSize(92,92)
	juke.play:SetPos(2, juke.browse:GetTall()-106)
	juke.play:SetFont("Screen_Large")
	juke.play:SetText("▶")
	juke.play:SetColors( HexColor("#2ecc71"), HexColor("#3ad87d") )
	juke.play:SetOffsets(0,0)
	function juke.play:DoClick()
		RS.JukePlayer:OpenURL(RS.JukeCurrent[3])
	end

	--stop ■
	juke.stop = vgui.Create("hub_button", juke.browse)
	juke.stop:SetSize(92,92)
	juke.stop:SetPos(92+4, juke.browse:GetTall()-106)
	juke.stop:SetFont("Screen_Small")
	juke.stop:SetText("■")
	juke.stop:SetOffsets(0,-10)
	function juke.stop:DoClick()
		RS.JukePlayer:OpenURL("http://gameredacted.net/deathrun")
	end
	juke.stop:SetColors( HexColor("#2ecc71"), HexColor("#3ad87d") )

	juke.prev = vgui.Create("hub_button", juke.browse)
	juke.prev:SetSize(92,92)
	juke.prev:SetPos((92+2)*2 + 2, juke.browse:GetTall()-106)
	juke.prev:SetFont("Screen_Small")
	juke.prev:SetText("<<")
	juke.prev:SetOffsets(0,0)
	function juke.prev:DoClick()
		RS:JukeboxPlayPrevious()
	end
	juke.prev:SetColors( HexColor("#2ecc71"), HexColor("#3ad87d") )

	juke.nxt = vgui.Create("hub_button", juke.browse)
	juke.nxt:SetSize(92,92)
	juke.nxt:SetPos((92+2)*3 + 2, juke.browse:GetTall()-106)
	juke.nxt:SetFont("Screen_Small")
	juke.nxt:SetText(">>")
	juke.nxt:SetOffsets(0,-0)
	function juke.nxt:DoClick()
		RS:JukeboxPlayNext();
	end
	juke.nxt:SetColors( HexColor("#2ecc71"), HexColor("#3ad87d") )

	-- cycle modes
	juke.cycleall = vgui.Create("hub_button", juke.browse)
	juke.cycleall:SetSize(92,92/4)
	juke.cycleall:SetPos((92+2)*4 + 2, juke.browse:GetTall()-106 + (92/4)*0)
	juke.cycleall:SetFont("Screen_Tiny")
	juke.cycleall:SetText("Cycle All")
	juke.cycleall:SetOffsets(0,-0)
	function juke.cycleall:DoClick()
		RS.JukeState = "cycleall"
	end
	juke.cycleall:SetColors( HexColor("#2ecc71"), HexColor("#3ad87d") )
	
	juke.cyclequeue = vgui.Create("hub_button", juke.browse)
	juke.cyclequeue:SetSize(92,92/4)
	juke.cyclequeue:SetPos((92+2)*4 + 2, juke.browse:GetTall()-106 + (92/4)*1)
	juke.cyclequeue:SetFont("Screen_Tiny")
	juke.cyclequeue:SetText("Cycle Queue")
	juke.cyclequeue:SetOffsets(0,-0)
	function juke.cyclequeue:DoClick()
		RS.JukeState = "cyclequeue"
	end
	juke.cyclequeue:SetColors( HexColor("#2ecc71"), HexColor("#3ad87d") )

	juke.shuffleall = vgui.Create("hub_button", juke.browse)
	juke.shuffleall:SetSize(92,92/4)
	juke.shuffleall:SetPos((92+2)*4 + 2, juke.browse:GetTall()-106 + (92/4)*2)
	juke.shuffleall:SetFont("Screen_Tiny")
	juke.shuffleall:SetText("Shuffle All")
	juke.shuffleall:SetOffsets(0,-0)
	function juke.shuffleall:DoClick()
		RS.JukeState = "shuffleall"
	end
	juke.shuffleall:SetColors( HexColor("#2ecc71"), HexColor("#3ad87d") )

	juke.shufflequeue = vgui.Create("hub_button", juke.browse)
	juke.shufflequeue:SetSize(92,92/4)
	juke.shufflequeue:SetPos((92+2)*4 + 2, juke.browse:GetTall()-106 + (92/4)*3)
	juke.shufflequeue:SetFont("Screen_Tiny")
	juke.shufflequeue:SetText("Shuffle Queue")
	juke.shufflequeue:SetOffsets(0,-0)
	function juke.shufflequeue:DoClick()
		RS.JukeState = "shufflequeue"
	end
	juke.shufflequeue:SetColors( HexColor("#2ecc71"), HexColor("#3ad87d") )

	juke.displaymode = vgui.Create("hub_button", juke.browse)
	juke.displaymode:SetSize(juke.browse:GetWide() - (92+2)*5 - 4,92)
	juke.displaymode:SetPos((92+2)*5 + 2, juke.browse:GetTall()-106)
	juke.displaymode:SetFont("Screen_Medium")
	juke.displaymode:SetText(JukeStates[ RS.JukeState ] )
	juke.displaymode:SetOffsets(0,0)
	function juke.displaymode:Think()
		self:SetText(JukeStates[ RS.JukeState ])
	end
	juke.displaymode:SetColors( HexColor("#2ecc71"), HexColor("#3ad87d") )

	juke.browse.scroll = vgui.Create("DScrollPanel",juke.browse)
	juke.browse.scroll:SetSize( juke.browse:GetWide(), juke.browse:GetTall()-108 )
	juke.browse.scroll:SetPos(0,0)

	RS:ImproveScrollbar( juke.browse.scroll:GetVBar() )

	juke.browse.list = vgui.Create("DIconLayout")
	juke.browse.scroll:AddItem(juke.browse.list)
	juke.browse.list:SetSize( juke.browse.scroll:GetWide(), juke.browse.scroll:GetTall())
	juke.browse.list:SetSpaceY(2)
	juke.browse.list:SetPos(2,0)

	for k,v in orderedPairs(RS.JukeSongs) do
		local artist = k
		local songs = v
		local lb = juke.browse.list:Add("hub_label")
		lb:SetSize(juke.browse.list:GetWide(), 64)
		lb:SetText( artist )
		lb:SetFont("Screen_Medium")
		lb:SetColor( HexColor("#2ecc71") )
		lb:SetOffsets( 0,0 )

		for kk,vv in orderedPairs(v) do

			local jb = juke.browse.list:Add( "hub_button" )
			jb:SetSize(juke.browse:GetWide(), 28)
			jb:SetText(kk)
			jb:SetTextColor( HexColor("#606060") )
			jb:SetTextShadow( 0 )
			jb:SetColors(Color(128,128,128, 90), Color(52, 152, 219, 90))
			jb.link = vv
			jb.name = kk
			jb.artist = artist

			function jb:DoClick()
				local mn = vgui.Create("DMenu", self)
				mn:AddOption("Play Song", function()
					RS:JukeboxStartPlayer( self.artist, self.name, self.link )
				end):SetIcon("icon16/control_play_blue.png")
				mn:AddOption("Queue Song", function()
					table.insert(RS.JukeQueue, {self.artist, self.name, self.link} )
					RS:UpdateJukeQueue()
				end):SetIcon("icon16/script_add.png")

				mn:Open()
			end

			function jb:DoRightClick(mousekey)
				
			end

		end
	end

	-- queued songs
	queue.browse.scroll = vgui.Create("DScrollPanel",queue.browse)
	queue.browse.scroll:SetSize( queue.browse:GetWide(), queue.browse:GetTall()-108 )
	queue.browse.scroll:SetPos(0,0)

	RS:ImproveScrollbar( queue.browse.scroll:GetVBar() )

	queue.browse.list = vgui.Create("DIconLayout")
	queue.browse.scroll:AddItem(queue.browse.list)
	queue.browse.list:SetSize( queue.browse.scroll:GetWide()-4, queue.browse.scroll:GetTall())
	queue.browse.list:SetSpaceY(2)
	queue.browse.list:SetPos(2,0)

	juke.info = vgui.Create("DPanel", queue)
	juke.info:SetSize((queue:GetWide()-4)*0.66666 -1, 92)
	juke.info:SetPos(2, queue:GetTall()-106)
	function juke.info:Paint()
		surface.SetDrawColor(HexColor("#2ecc71"))
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())
		
		draw.ShadowText("Now Playing: "..RS.JukeCurrent[2],"Screen_Large",16,8,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM,1)
		draw.ShadowText("By "..RS.JukeCurrent[1],"Screen_Medium",17,42,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM,1)
	end
	juke.volume = vgui.Create("DPanel", queue)
	juke.volume:SetSize((queue:GetWide()-4)*0.33333, 92)
	juke.volume:SetPos(2 + (queue:GetWide()-4)*0.66666 +1, queue:GetTall()-106)
	function juke.volume:Paint()
		surface.SetDrawColor(HexColor("#2ecc71"))
		surface.DrawRect(0,0,self:GetWide(),self:GetTall())
		draw.ShadowText("Volume: "..tostring( math.floor(RS.JukeVolume) ), "Screen_Medium", self:GetWide()/2, 10, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1)
	end

	local sl = vgui.Create("Slider", juke.volume)
	sl:SetSize(juke.volume:GetWide() * 0.9, 64)
	sl:SetPos(0,20)
	sl:CenterHorizontal()
	sl:SetMin( 0 )
	sl:SetMax( 100 )
	sl:SetValue( GetConVarNumber("grhub_jukebox_volume") )
	sl:SetDecimals(0)
	sl.TextArea:SetVisible( false )
	sl:InvalidateLayout()
	--PrintTable(sl:GetTable())


	function sl:Paint()
		surface.SetDrawColor(Color(255,255,255))
		surface.DrawLine(8,sl:GetTall()/2,sl:GetWide()-10,sl:GetTall()/2)
	end
	sl.oldx = 0
	function sl:OnValueChanged()
		RS.JukePlayer:Call("ytplayer.setVolume( "..tonumber( self:GetValue() ).." );")
		RS.JukeVolume = tonumber( math.ceil(self:GetValue()) )
		RunConsoleCommand("grhub_jukebox_volume", math.ceil(self:GetValue()) )
	end


	RS.JukeQueueList = queue.browse.list
		
	RS:UpdateJukeQueue()

	RS.JukeVolume = GetConVarNumber( "grhub_jukebox_volume" )

	--print(type(opentab), opentab)
	hub.largemulti:SetTab( opentab ) -- set the current open tab after everything is initialised

	RS:ResetPlayerModelPreview()

end

RS.JukeVolume = 0

CreateClientConVar("grhub_jukebox_volume", 40, true, false)
cvars.AddChangeCallback("grhub_jukebox_volume", function(cname, cold, cnew)

	RS.JukePlayer:Call("ytplayer.setVolume( "..cnew.." );")
	RS.JukeVolume = cnew

end)

RS.JukeCurrent = {"No Artist","No Song", "http://gameredacted.net/deathrun"}

hook.Add("InitPostEntity", "CreatePlayWindow",function()
	if RS.JukePlayer then
		RS.JukePlayer:Remove()
	end


	RS.JukePlayer = vgui.Create("DHTML")
	RS.JukePlayer:SetSize(200,100)
	RS.JukePlayer:SetPos(20,20)
	RS.JukePlayer:SetVisible(false)
end)

function BuyItem( class )
	net.Start("BuyItem")
	net.WriteString( class )
	net.SendToServer()
end

function SellItem( id )
	net.Start("SellItem")
	net.WriteInt( tonumber(id), 32 )
	net.SendToServer()
	--LocalPlayer():ChatPrint( "networking item sale "..tostring(id) )
end

function ToggleItem( id )
	net.Start("ToggleItem")
	net.WriteInt( id, 32 )
	net.SendToServer()
end

function OpenCrate( id )
	net.Start("OpenCrate")
	net.WriteInt( id, 32 )
	net.SendToServer()
end

net.Receive("UpdateInventory", function()

	if not IsValid( RS.HubWindow ) or RS.HubWindow == nil then return end

	local owneditems = net.ReadTable()

	RS.InventoryList:Clear()

	if owneditems then
		for k,v in ipairs(owneditems) do
			local icon = vgui.Create("hub_icon")
			icon:SetItem(RS.Items[v["class"]])
			icon:SetInventoryItem( true )
			icon:SetEquipped( tobool(v["equipped"]) )
			icon:SetID( tonumber(v["ID"]) )
			if RS.Items[v["class"]] then
				icon:SetIsToken( RS.Items[v["class"]].IsToken )
			end
			RS.InventoryList:Add(icon)
		end
	end
	--print(LocalPlayer():GetPlayerColor())
	--refresh the preview
	RS:ResetPlayerModelPreview()
	timer.Create("ReloadPreview",1,1, function()
		RS:ResetPlayerModelPreview()
	end)

end)

function RS:ResetPlayerModelPreview()
	if RS.PlayerModelPreview.Entity then
		--print( LocalPlayer():GetPlayerColor(), RS.PlayerModelPreview.Entity.PlyCol )
		RS.PlayerModelPreview:SetModel( LocalPlayer():GetModel() )
		
		RS.PlayerModelPreview.Entity:SetMaterial( LocalPlayer():GetMaterial() )
		RS.PlayerModelPreview.Entity.NCol = LocalPlayer():GetColor() or Color(255,255,255)
		RS.PlayerModelPreview:SetColor( LocalPlayer():GetColor() or Color(255,255,255) )

		RS.PlayerModelPreview.Entity.PlyCol = LocalPlayer():GetPlayerColor()
		--print( LocalPlayer():GetPlayerColor(), RS.PlayerModelPreview.Entity.PlyCol )
		--function RS.PlayerModelPreview.Entity:GetPlayerColor() return self.PlyCol end
		--function RS.PlayerModelPreview.Entity:GetColor() return self.NCol end

		RS:InvalidatePlayerColor()
	end
end

function RS:InvalidatePlayerColor()
	if RS.PlayerModelPreview then
		function RS.PlayerModelPreview.Entity:GetPlayerColor() 
			--print( self.PlyCol, "meme" )
			return self.PlyCol 
		end
	end
end

net.Receive("OpenCrateGUI", function( len )
	RS:OpenCrateGUI( net.ReadString(), net.ReadString() )
end)

function RS:OpenCrateGUI( result, class ) -- class as in crate class

	local crate = RS.Items[class]
	local item = RS.Items[result]

	local frame = vgui.Create("hub_window")
	frame:SetSize( 640,360 )
	frame:Center()
	frame:MakePopup()
	frame:SetTitle("Opening "..crate.Name.." Crate")

	function frame:PaintOver(w,h)
		local x, y = 320-40 + math.sin(CurTime()*4)*7, 170

		local tri = {
			{x+40, y-10},
			{x+80, y+20},
			{x+40, y+50}
		}

		draw.NoTexture()
		surface.SetDrawColor( HexColor("#2ecc71") )
		surface.DrawRect(x,y,41,40)
		surface.EasyPoly( tri )
	end

	local cratepanel = vgui.Create("DPanel", frame)
	cratepanel:SetWide(cratepanel:GetParent():GetWide()/2 -12)
	cratepanel:SetTall(cratepanel:GetWide())
	cratepanel:SetPos(8,cratepanel:GetParent():GetTall() - cratepanel:GetTall()-8)
	function cratepanel:Paint( w, h )
		surface.SetDrawColor(48,48,48,170)
		--surface.DrawRect(0,0,w,h)
	end

	local cratemodel = vgui.Create("DModelPanel", cratepanel)
	cratemodel:SetModel( crate.CrateModel )
	cratemodel:SetSize(cratemodel:GetParent():GetSize())
	cratemodel:SetLookAt( Vector(0,0,5) )
	cratemodel:SetFOV( 40 )
	cratemodel.Entity:SetMaterial( crate.CrateMat )

	local resultpanel = vgui.Create("DPanel", frame)
	resultpanel:SetWide(resultpanel:GetParent():GetWide()/2 - 12)
	resultpanel:SetTall(resultpanel:GetWide())
	resultpanel:SetPos(resultpanel:GetParent():GetWide()-resultpanel:GetWide()-8,resultpanel:GetParent():GetTall() - resultpanel:GetTall()-8)

	resultpanel.clk = 0
	resultpanel.dt = 0
	resultpanel.last = CurTime()

	surface.PlaySound("crates/item_open_crate_short.ogg")

	resultpanel.countdown = 3
	function resultpanel:PaintOver( w, h )
		self.dt = CurTime() - self.last
		self.last = CurTime()

		self.clk = self.clk + self.dt

		if self.clk > 1 then
			self.countdown = self.countdown - 1
			if self.countdown == 0 then
				local icon = vgui.Create("hub_icon", self)
				icon:SetItem( item )
				icon:SetInventoryItem( false)
				icon:SetEquipped( false )
				icon:SetStock( 1 )
				if item then
					icon:SetIsToken( item.IsToken )
				end

				surface.PlaySound("crates/killstreak.ogg")

				function icon.b:OnMousePressed() end
				function icon.b:Paint() end
				icon.b.text = "Woohoo!"
				icon:Center()
				icon.ox, icon.oy = icon:GetPos()
				function icon:Think()
					self:SetPos( self.ox, self.oy + math.sin(CurTime()*2)*8 )
				end
			end
			self.clk = 0
		end

		if self.countdown <= 0 then return end

		surface.SetDrawColor( HexColor("#ecf0f1") )
		surface.DrawRect(0,0,w,h)

		local m = Matrix()
		m:Translate( Vector( self:LocalToScreen( w/2 ), self:LocalToScreen( -h-20 ) ) )
		--m:Scale( Vector(1,1,1)*1.1 )
		m:Rotate( Angle(0, math.sin(CurTime()*16)*7, 0) )
		m:Translate( -Vector( self:LocalToScreen( w/2 ), self:LocalToScreen( -h-20 ) ) )

		cam.PushModelMatrix( m )

		draw.ShadowText( tostring(self.countdown).."...", "Screen_XLarge", w/2, h/2-8, HexColor("#2ecc71"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1)
		
		cam.PopModelMatrix()
	end

	function resultpanel:Paint(w,h) -- pinwheel animation

		local clk = CurTime()
		local x, y = w/2, h/2

		surface.SetDrawColor( HexColor("#2ecc71") )
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor( HexColor("#ecf0f1", math.sin(CurTime() + math.pi/2)*127 + 127) )
		surface.DrawRect(0,0,w,h)

		for i = 1, 6 do
			local arclength = ( 360/(6*2) ) * math.pi/180
			local interval = ( 360/6 ) * math.pi/180
			local k = i-1
			local d = 400
			local tri = {
				{x,y},
				{x + math.cos( clk + interval*k )*d, y+math.sin( clk + interval*k )*d},
				{x + math.cos( clk + interval*k + arclength )*d, y+math.sin( clk + interval*k + arclength )*d},
			}
			draw.NoTexture()
			surface.SetDrawColor( Color(255,0,255) )
			surface.EasyPoly( tri )

			surface.SetDrawColor( Color(0,255,255, math.sin(CurTime())*127 + 127) )
			surface.EasyPoly( tri )
		end

	end

	

end