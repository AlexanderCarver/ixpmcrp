include("shared.lua")

surface.CreateFont( "sawmilltext", {
	font = "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 50,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )

surface.CreateFont( "sawmilltextt", {
	font = "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 40,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )

surface.CreateFont( "sawmilltexts", {
	font = "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )


function ENT:Initialize()
end



function ENT:Draw()

	self:DrawModel()

	local Ang = self:GetAngles()
	local Pos = self:GetPos();
	
	local drewno = self:GetLogs()
	local czas   = self:GetWorkingTime()
	
	
	
	//Ang:RotateAroundAxis(self:GetAngles():Right(), 90)
	//Ang:RotateAroundAxis(self:GetAngles():Forward(), 90)
	//Ang:RotateAroundAxis(self:GetAngles():Right(), 90)
	//Ang:RotateAroundAxis(self:GetAngles():Forward(), 180)
	//Ang:RotateAroundAxis(self:GetAngles():Right(), 270)
	Ang:RotateAroundAxis(self:GetAngles():Up(), 180)
if LocalPlayer():GetPos():Distance(self:GetPos()) < 700 then		
	cam.Start3D2D( self:GetPos() + Ang:Up()*37, Ang, 0.1 )

		draw.RoundedBox( 0, -180, -450, 60, 250, Color(0,0,0,200) )
		draw.RoundedBox( 0, -180+2, -450+2, 60-4, 250-4, Color(50,50,50,170) )
		
		draw.RoundedBox( 0, -180, -140, 60, 550, Color(0,0,0,200) )
		draw.RoundedBox( 0, -180+2, -140+2, 60-4, 550-4, Color(50,50,50,170) )
		
		-- PASEK
		
		draw.RoundedBox( 0, -195, -450, 10, 250, Color(0,0,0,200) )
		draw.RoundedBox( 0, -195+1, -450+1, 10-2, czas * (248/ix.config.Get("SawmillProgress", 40)), Color(204,204,204,100) )
		
		--draw.DrawText("Sawmill", "sawmilltext", 0,-50, Color(180,190,180), TEXT_ALIGN_CENTER )
		--draw.RoundedBox( 0, 70+2, -150+2, 22-4, 300-4, Color(50,110,110,200) )

	cam.End3D2D()
	Ang:RotateAroundAxis(self:GetAngles():Up(), -90)
	cam.Start3D2D( self:GetPos() + Ang:Up()*37, Ang, 0.1 )

		
		draw.DrawText("Logs: " ..drewno, "sawmilltextt", -440,130, Color(180,190,180), TEXT_ALIGN_LEFT )
		if (self:GetWorking()) then
		draw.DrawText("Working", "sawmilltextt", -130,130, Color(180,190,180,math.abs(math.cos(RealTime() * 3) * 255)), TEXT_ALIGN_LEFT )
		elseif (drewno == 0) then
			draw.DrawText("Put a log on the sawmill", "sawmilltextt", -130,130, Color(180,190,180), TEXT_ALIGN_LEFT )
		else	
		draw.DrawText("Press 'E' to start the sawmill", "sawmilltextt", -130,130, Color(180,190,180), TEXT_ALIGN_LEFT )
		end
		
	cam.End3D2D()
end	
end

function ENT:Think()

end