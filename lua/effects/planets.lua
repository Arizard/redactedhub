function EFFECT:Init( data ) -- unusual effect for hats
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
	local vOffset = data:GetEntity():GetPos() + Vector(0,0,70)

	local att = data:GetEntity():GetAttachment( data:GetEntity():LookupAttachment("eyes") or 0 )
	if att then
		vOffset = att.Pos + att.Ang:Up()*5
	end

	local planets = {
		{"vhs7/particles/earth.vmt", 1},
		{"vhs7/particles/jupiter.vmt", 2},
		{"vhs7/particles/saturn.vmt", 2},
		{"vhs7/particles/uranus.vmt", 1.5},
		{"vhs7/particles/neptune.vmt", 1.6},
	}

	local emitter = ParticleEmitter( vOffset, false )
		for i=1, self.particles do
			--print( math.floor( (CurTime()*10) % #planets) )
			local planet = planets[ 1+math.floor( (CurTime()*10) % #planets)]
			local particle = emitter:Add( planet[1] , vOffset, true )
			if particle then
				local vel = data:GetEntity():GetVelocity() + VectorRand()
				particle:SetAngles(Angle(0,0,180))
				particle:SetPos( particle:GetPos() + VectorRand()*20 )
				particle:SetVelocity( vel )
				particle:SetAirResistance( 100 )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 1.2 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( 2*planet[2] )
				particle:SetEndSize( 2*planet[2] )
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



