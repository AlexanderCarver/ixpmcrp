include("shared.lua")

surface.CreateFont( "piec", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 18,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "piecc", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 15,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )
	
	
surface.CreateFont( "piecm", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 13,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )	
	
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

	local Ang = self:GetAngles()
	local Pos = self:GetPos();
	
	local paliwo = self:Getfuel()
	local zelazo = self:GetIrons()
	
	Ang:RotateAroundAxis(self:GetAngles():Right(), -90)
	Ang:RotateAroundAxis(self:GetAngles():Up(), 70)
	
	// TIMER //
if LocalPlayer():GetPos():Distance(self:GetPos()) < 700 then	
	cam.Start3D2D( self:GetPos() + Ang:Up()*-47, Ang, 0.1 )

		draw.RoundedBox( 0, -590, -110, 22, 260, Color(0,0,0,200) )
		draw.RoundedBox( 0, -590+2, -110+2, 22-4, 260-4, Color(50,110,110,200) )

	cam.End3D2D()
	
	// STATUS //
	cam.Start3D2D( self:GetPos() + Ang:Up()*-47, Ang, 0.1 )

		draw.RoundedBox( 0, -550, -55, 40, 160, Color(0,0,0,100) )
		draw.RoundedBox( 0, -550+2, -55+2, 40-4, 160-4, Color(50,50,50,120) )
		
		if (zelazo > 0) then
			draw.RoundedBox( 0, -505, -55, 13, 160, Color(60,60,60,200) )	
			draw.RoundedBox( 0, -505+2, -55+2, 13-4, zelazo * (156/ix.config.Get("FurnaceSize", 5)), Color(0,153,153,200) )
		end

	cam.End3D2D()
	
	Ang:RotateAroundAxis(self:GetAngles():Forward(), 180)
	Ang:RotateAroundAxis(self:GetAngles():Up(), -30)
	// FUEL //
	cam.Start3D2D( self:GetPos() + Ang:Up()*58.3, Ang, 0.1 )

		draw.RoundedBox( 0, 20, 70, 332, 30, Color(0,0,0,200) )
		draw.RoundedBox( 0, 20+2, 70+2, paliwo * (328/60), 30-4, Color(255,0,0,100) )

	cam.End3D2D()
	Ang:RotateAroundAxis(self:GetAngles():Right(), -87)
	Ang:RotateAroundAxis(self:GetAngles():Up(), -18)
	Ang:RotateAroundAxis(self:GetAngles():Forward(), 10)
	// STATUS TEXT //
	cam.Start3D2D( self:GetPos() + Ang:Up()*47, Ang, 0.1 )
	if self:GetIsWorking() then
		draw.DrawText("Melting", "piec", 5, -535, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
	elseif (self:GetWorkTime() < ix.config.Get("MeltTime", 2) * 60) and paliwo == 0 then
		draw.DrawText("No coal", "piec", 5, -535, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )	
	elseif (self:GetWorkTime() == 0) then
		draw.DrawText("Take the minerals [E]", "piec", 5, -535, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
	else
		draw.DrawText("Put the minerals", "piec", 5, -535, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
	end

		if (zelazo > 0) then
		draw.DrawText(zelazo.."/"..ix.config.Get("FurnaceSize", 5), "piecm", 5, -500, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
		end

	cam.End3D2D()
	
	// TIMER//
	cam.Start3D2D( self:GetPos() + Ang:Up()*47, Ang, 0.1 )
	draw.DrawText(string.ToMinutesSeconds( self:GetWorkTime() ), "piec", 5, -585, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
	cam.End3D2D()

	Ang:RotateAroundAxis(self:GetAngles():Right(), 90)
	Ang:RotateAroundAxis(self:GetAngles():Forward(), -15)
	// FUEL //
	cam.Start3D2D( self:GetPos() + Ang:Up() * 58, Ang, 0.1 )
	draw.DrawText("Coal", "piec", 200, -20, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
	cam.End3D2D()
	end
end



function ENT:Think()

	if LocalPlayer():GetPos():Distance(self:GetPos()) < 700 then
	self.SmokeTimer = self.SmokeTimer or 0

	if (!self.emitter) then
		self.emitter = ParticleEmitter(self.Entity:GetPos())
	end

	if (!self:GetIsWorking()) then return end

	if self.SmokeTimer > CurTime() then return end

	self.SmokeTimer = CurTime() + math.Rand(0.0125,0.0150)  --0.0150

	local vOffset = self:GetPos() + Vector(math.Rand(-3, 3), math.Rand(-3, 3), math.Rand(-3, 3)) + (self:GetUp()*13) + (self:GetRight()*40) + (self:GetForward()*-10) -- random pos near entity pos
	local vNormal = (vOffset - self:GetPos()):GetNormalized() + (self:GetUp()) + (self:GetRight()*4) + (self:GetForward()*-2)-- get direction vector from ent position to random spot

	local particlee = self.emitter:Add("particles/fire1", vOffset) -- add new particle to emitter
	particlee:SetVelocity( vNormal * math.Rand( 5,15) )
    particlee:SetDieTime(0.5)
    particlee:SetStartAlpha(math.Rand(50, 150))
    particlee:SetStartSize(math.Rand(10,15))
    particlee:SetEndSize( math.Rand(5, 10))
    particlee:SetRoll( math.Rand( -0.2, 0.2 ) )
    particlee:SetColor(255, math.random(128,255), 0)
	
	end
	
end