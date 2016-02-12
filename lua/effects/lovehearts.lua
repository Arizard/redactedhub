function EFFECT:Init( data ) -- unusual effect for hats
	self.data = data

	self.particles = 2

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
		"vhs7/particles/heart.vmt",
	}
		for i=1, self.particles do
			local mat = table.Random( mats )
			local particle = emitter:Add( mat , vOffset, true )
			if particle then
				local vel = Vector(0,0,0)
				vel.z = vel.z*0.5
				particle:SetAngles(Angle(0,0,180))
				
				local c = math.random()
				particle:SetColor( 200 + 55 * c, 135, 135 )
				particle:SetStartSize( math.random()*4 )

				particle:SetPos( particle:GetPos() + Vector(math.random(-16,16), math.random(-16,16), math.random(0,80)) )
				particle:SetVelocity( vel )
				particle:SetAirResistance( 100 )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.2 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				
				particle:SetEndSize( 1 )
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



