include("shared.lua")


function ENT:Initialize()
	self.Created = CurTime()
	self.emitter = ParticleEmitter(self.Entity:GetPos())

end

function ENT:OnRemove()
	
	if !(self.emitter == nil) then
		self.emitter:Finish()
	end
	
end
function ENT:Draw()

	self:DrawModel()

end

function ENT:Think()

	if LocalPlayer():GetPos():Distance(self:GetPos()) < 700 then
	self.SmokeTimer = self.SmokeTimer or 0

	if (!self.emitter) then
		self.emitter = ParticleEmitter(self.Entity:GetPos())
	end

	if (!self:GetIsWorking()) then return end

	if self.SmokeTimer > CurTime() then return end

	self.SmokeTimer = CurTime() + math.Rand(0.08,0.1)  --0.0150

	local vOffset = self:GetPos() + Vector(math.Rand(-3, 3), math.Rand(-3, 3), math.Rand(-3, 3)) + (self:GetUp()*10) + (self:GetRight()*-0.1) + (self:GetForward()*0.5) -- random pos near entity pos
	local vNormal = (vOffset - self:GetPos()):GetNormalized() + (self:GetUp()*2) + (self:GetRight()) + (self:GetForward()) -- get direction vector from ent position to random spot

	local particlee = self.emitter:Add("particles/smokey", vOffset) -- add new particle to emitter
	particlee:SetVelocity( vNormal * math.Rand( 5,15) )
    particlee:SetDieTime(0.5)
    particlee:SetStartAlpha(math.Rand(50, 150))
    particlee:SetStartSize(math.Rand(5,10))
    particlee:SetEndSize( math.Rand(5, 10))
    particlee:SetRoll( math.Rand( -0.2, 0.2 ) )
    particlee:SetColor(255, 255,255)
	
	end
	
end
