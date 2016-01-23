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
	local vOffset = data:GetEntity():GetPos() + Vector( 0, 0, 75 )

	local emitter = ParticleEmitter( vOffset, false )
		for i=1, self.particles do
			local randeff = table.Random( {
					"goodshit",
					"100",
					"ok",
					"rightthere"
				})
			local particle = emitter:Add( "vhs7/particles/"..randeff, vOffset, true )
			if particle then
				local vel = VectorRand()*40
				vel.z = 0
				particle:SetPos( vOffset + VectorRand()*6 )
				particle:SetAngles(Angle(0,0,180))
				particle:SetVelocity( vel )
				particle:SetAirResistance( 100 )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.7 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )

				if randeff == "100" or randeff == "ok" then
					particle:SetStartSize( 3 )
					particle:SetEndSize( 2 )
				else
					particle:SetStartSize( 8 )
					particle:SetEndSize( 6 )
				end				
				particle:SetGravity( Vector(0,0,-20) )
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



