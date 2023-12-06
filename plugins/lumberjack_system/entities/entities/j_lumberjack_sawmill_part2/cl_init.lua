include("shared.lua")


function ENT:Initialize()
end

function ENT:Draw()

	self:DrawModel()

	local Ang = self:GetAngles()
	local Pos = self:GetPos();
	
	//Ang:RotateAroundAxis(self:GetAngles():Right(), 90)
	//Ang:RotateAroundAxis(self:GetAngles():Forward(), 90)
	//Ang:RotateAroundAxis(self:GetAngles():Right(), 90)
	//Ang:RotateAroundAxis(self:GetAngles():Forward(), 180)
	//Ang:RotateAroundAxis(self:GetAngles():Right(), 270)
	
	cam.Start3D2D( self:GetPos() + Ang:Up() * 7.1, Ang, 0.1 )
		--draw.WordBox( 4, -115, -50, "Ulepszenie [Szybkość]", "test", Color(100,100,100, 100), Color(240,240,240) )
		--draw.RoundedBox( 0, 70, -150, 22, 300, Color(0,0,0,200) )		
	cam.End3D2D()
	
end

function ENT:Think()

end