AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include("shared.lua")



function ENT:Initialize()

	self:SetModel("models/props/furnitures/humans/table01.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType( SIMPLE_USE ) -- Makes the ENT.Use hook only get called once at every use.
	
	local phys = self:GetPhysicsObject()
	
	self.timer = CurTime()
	
	if phys:IsValid() then

		phys:Wake()
		timer.Simple( 1, function()
		if IsValid(self) then
		phys:EnableMotion(false)
		end
		end )

	end
	
	self:SetLogs(0)
	self:SetWorkingTime(0)
	self:SetWorking(false)
	self.log = 0
	self.saw = nil
	self.logmodel = nil
	
	
	-- timer.Simple(0.5, function()
	-- if IsValid(self) then
	-- 	local prop1 = ents.Create("j_lumberjack_sawmill_part1")
	-- 	prop1:SetPos(self:GetPos() + self:GetAngles():Up()*17 + self:GetAngles():Right())
	-- 	prop1:SetAngles(self:GetAngles())
	-- 	prop1:Spawn()
	-- 	prop1:Activate()
	-- 	prop1:SetParent(self)
	-- 	prop1:SetSolid(SOLID_VPHYSICS)
	-- end	
	-- end)
	
	
	timer.Simple(0.5, function()
	if IsValid(self) then
		local Ang = self:GetAngles()
		Ang:RotateAroundAxis(Ang:Forward(), 90)
		Ang:RotateAroundAxis(Ang:Right(), 90)
	
		local prop2 = ents.Create("j_lumberjack_sawmill_part2")
		prop2:SetPos(self:GetPos() + self:GetAngles():Up()*36 + self:GetAngles():Right())
		prop2:SetAngles(Ang)
		prop2:Spawn()
		prop2:Activate()
		prop2:SetParent(self)
		--prop2:SetSolid(SOLID_VPHYSICS)
		self:SetNWEntity("saw", prop2)
	end	
	end)


	self.AnimLerp = 0
	
	

end

function ENT:LogAnimation()

	local log = self:GetNWEntity("modeldrewna")

	if (!IsValid(log)) then return end

	local progress = (self:GetWorkingTime()/ix.config.Get("SawmillProgress", 40)) * 80


	self.AnimLerp = Lerp(1.5 * FrameTime(), self.AnimLerp, progress)

	log:SetPos(Vector(0,(-30 + self.AnimLerp),40 ))

end	


function ENT:Think()

	self:NextThink(CurTime()+0.1)
	
	if self:GetWorking() == true then
		
		local curTime = CurTime()
			if (!self.nextUse or curTime >= self.nextUse) then
		
			self:VisualEffect()
			self:EmitSound("physics/wood/wood_box_impact_hard"..math.random(1, 3)..".wav");	
			self.nextUse = curTime + 1
			end
			
		
		
		local saw = self:GetNWEntity("saw")
		local Angles = saw:GetAngles()
		Angles:RotateAroundAxis(Angles:Up(), CurTime()*10)
		saw:SetAngles(Angles)

		self:LogAnimation()
		
		if CurTime() > self.timer + 1 then
	
			self.timer = CurTime()
			
			self:SetWorkingTime(math.Clamp(self:GetWorkingTime() + 1, 0, ix.config.Get("SawmillProgress", 40)))
			-- self:SetWorkingTime(self:GetWorkingTime() + 10)
			
	
		end
		
		
		
	end


	if self:GetWorkingTime() == ix.config.Get("SawmillProgress", 40) then
		
		ix.item.Spawn("wood_board" ,self:GetPos() + self:GetAngles():Up()*47 + self:GetAngles():Right()*-34, nil, self:GetAngles())

		self:SetLogs(self:GetLogs() - 1)
		
		if self:GetLogs() == 0 then
			self:VisualLog(true)
			self:SetWorking(false)
		end
		self:SetWorkingTime(0)
		self.AnimLerp = 0
	end
	
	return true
end

function ENT:Use(act, call)

	if call:IsPlayer() then
	local logsamount = self:GetLogs()
	
		if logsamount > 0 and (!self:GetWorking()) then
			self:SetWorking(true)
			
		end
	
	
	end
	
end	

function ENT:VisualLog(Remove)


	if (Remove and IsValid(self:GetNWEntity("modeldrewna"))) then
		self:GetNWEntity("modeldrewna"):Remove()
		return
	end	

	local Ang = self:GetAngles()
	Ang:RotateAroundAxis(Ang:Forward(), -90)
	Ang:RotateAroundAxis(Ang:Up(), 90)

	local log = ents.Create("prop_dynamic")
	log:SetModel("models/props_docks/channelmarker_gib01.mdl")
	log:SetPos(self:GetPos() + self:GetAngles():Up()*40 + self:GetAngles():Right()*30)
	log:SetAngles(Ang)
	log:SetParent(self)
	log:Spawn()
	log:Activate()
	log:SetSolid(SOLID_VPHYSICS)
	self:SetNWEntity("modeldrewna", log)


end



function ENT:StartTouch(ent)

	if (ent:GetClass() == "ix_item") then
		local itemTable = ent:GetItemTable()

		if (itemTable.uniqueID != "wood_log") then return end

		if (self:GetLogs() == 0) then
			self:VisualLog()
		end	

		self:SetLogs(self:GetLogs() + 1)
		self:EmitSound("physics/wood/wood_plank_impact_hard"..math.random(1,4)..".wav")
		ent:Remove()

	end	

end	

function ENT:VisualEffect()
	local effectData = EffectData();	
	effectData:SetStart(self:GetPos());
	effectData:SetOrigin(self:GetPos() + (self:GetUp()*40) + (self:GetRight()*18) + (self:GetForward()*-0.5) );
	effectData:SetAngles(self:GetAngles() )
	effectData:SetScale(5);	
	util.Effect("GlassImpact", effectData, true,true);
end;

-- function ENT:PlaceLog()
--     self.sound = CreateSound(self, Sound("physics/wood/wood_plank_impact_hard"..math.random(1,4)..".wav"))
--     self.sound:SetSoundLevel(75)
-- 	self.sound:PlayEx(1, 100)
-- end
