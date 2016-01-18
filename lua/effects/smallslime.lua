function EFFECT:Init( data ) -- unusual effect for hats
	self.data = data

	self.particles = 4

	self.Owner = data:GetEntity()

	self.life = 10
	
	if self.Owner == LocalPlayer() then
		if not LocalPlayer():ShouldDrawLocalPlayer() then
			self.clk = 0
		end
	end

	local data = self.data
	local vOffset = data:GetEntity():GetPos() + Vector(0,0,70)

	local att = data:GetEntity():GetAttachment( data:GetEntity():LookupAttachment("eyes") or 0 )
	if att then
		vOffset = att.Pos + att.Ang:Up()*5
	end

	local emitter = ParticleEmitter( vOffset, false )
		for i=1, self.particles do
			local particle = emitter:Add( "effects/slime1.vtf", vOffset, true )
			if particle then
				local vel = Vector(0,0,0)
				vel.z = vel.z*0.5
				particle:SetAngles(Angle(0,0,180))
				particle:SetPos( particle:GetPos() + VectorRand()*10 )
				particle:SetVelocity( vel )
				particle:SetAirResistance( 100 )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.4 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( 1 + math.random()*2 )
				particle:SetEndSize( 2 )
				particle:SetGravity( Vector(0,0,-70) )
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



