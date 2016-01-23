function EFFECT:Init( data ) -- unusual effect for hats
	self.data = data

	self.particles = 8

	self.Owner = data:GetEntity()

	self.life = 10
	
	if self.Owner == LocalPlayer() then
		if not LocalPlayer():ShouldDrawLocalPlayer() then
			self.clk = 0
		end
	end

	local data = self.data
	local vOffset = data:GetEntity():GetPos()

	local emitter = ParticleEmitter( vOffset, false )
	local mats = {
		"effects/yellowflare.vtf",
		"trails/australian_flag",
	}
		for i=1, self.particles do
			local mat = table.Random( mats )
			local particle = emitter:Add( mat , vOffset, true )
			if particle then
				local vel = Vector(0,0,0)
				vel.z = vel.z*0.5
				particle:SetAngles(Angle(0,0,180))
				if mat == "trails/australian_flag" then
					particle:SetColor(255,255,255)
					particle:SetAngles(Angle(-45,0,0))
					particle:SetStartSize( 3 + math.random()*3 )
				else
					local c = math.random(1,10)
					particle:SetColor( c > 5 and 205 or 0, 205, c > 5 and 205 or 0 )
					particle:SetStartSize( 5 + math.random()*3 )
				end
				particle:SetPos( particle:GetPos() + Vector(math.random(-16,16), math.random(-16,16), math.random(0,80)) )
				particle:SetVelocity( vel )
				particle:SetAirResistance( 100 )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.2 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				
				particle:SetEndSize( 2 )
				particle:SetGravity( Vector(0,0,0) )
			end
		end
	emitter:Finish()
	self.clk = 0
	
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
	return false
end



