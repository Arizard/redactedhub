function EFFECT:Init( data )
	self.data = data

	self.particles = 1

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
			local particle = emitter:Add( "vhs7/particles/vhs7_red", vOffset, true )
			if particle then
				local vel = VectorRand()*20
				vel.z = 0
				particle:SetPos( vOffset + VectorRand()*5 )
				particle:SetAngles(Angle(0,0,180))
				particle:SetVelocity( vel )
				particle:SetAirResistance( 100 )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 1 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( 8 )
				particle:SetEndSize( 6 )
				particle:SetGravity( Vector(0,0,20) )
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



