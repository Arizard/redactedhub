function EFFECT:Init( data )
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
	local vOffset = data:GetEntity():GetPos() + Vector( 0, 0, 70 )

	local emitter = ParticleEmitter( vOffset, false )
		for i=1, self.particles do
			local particle = emitter:Add( "effects/yellowflare.vtf", vOffset, true )
			if particle then
				local vel = VectorRand()*50
				vel.z = 0
				particle:SetAngles(Angle(0,0,180))
				particle:SetVelocity( vel )
				particle:SetAirResistance( 100 )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.7 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( 3 + math.random()*3 )
				particle:SetEndSize( 2 )
				particle:SetGravity( Vector(0,0,-50) )
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



