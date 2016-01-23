function EFFECT:Init( data ) -- unusual effect for hats
	self.data = data

	self.particles = 10

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
	local mats = {
		"effects/fire_cloud1.vtf",
		"effects/fire_embers2.vtf",
		"effects/fire_embers1.vtf",
		"effects/fire_embers3.vtf"
	}
		for i=1, self.particles do
			local particle = emitter:Add( table.Random(mats), vOffset, true )
			if particle then
				local vel = VectorRand()*25
				vel.z = 50
				particle:SetColor( 255,200,200 )
				particle:SetAngles(AngleRand())
				particle:SetPos( particle:GetPos() + VectorRand()*10 )
				particle:SetVelocity( vel )
				particle:SetAirResistance( 100 )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.2 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( 2 + math.random()*3 )
				particle:SetEndSize( 0 )
				particle:SetGravity( Vector(0,0,70) )
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
