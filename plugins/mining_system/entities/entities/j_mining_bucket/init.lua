AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include("shared.lua")



function ENT:Initialize()

	self:SetModel("models/props_clutter/bucket.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
	
	local phys = self:GetPhysicsObject()
	
	if phys:IsValid() then

		phys:Wake()

	end
	
	self:SetIsWorking(false)

	local WaterEffect = ents.Create("prop_dynamic")
	WaterEffect:SetModel("models/hunter/tubes/circle2x2.mdl")
	WaterEffect:SetPos(self:GetPos() + (self:GetUp()) + (self:GetRight()*-0.1) + (self:GetForward()*0.5));		
	WaterEffect:SetAngles(self:GetAngles());
	WaterEffect:SetModelScale(0.15)
	WaterEffect:SetParent(self)
	WaterEffect:DrawShadow(false)
	WaterEffect:Spawn();
	WaterEffect:SetMaterial("models/shadertest/predator")

end


function ENT:StartTouch( hitEnt )

	if hitEnt:GetClass() == "j_mining_ironignot" and (!self.Working) then
		self:StartWorking()
		self:SetIsWorking(true)
		self:EmitSound("ambient/machines/steam_release_2.wav")
		hitEnt:Remove()
	end
	
end		

function ENT:StartWorking()

	timer.Simple(5, function()
		if (!IsValid(self)) then return end

		ix.item.Spawn("ore_ironingot", self:GetPos() + (self:GetUp()*20) + (self:GetRight()*-0.1) + (self:GetForward()*0.5), nil, self:GetAngles())

		self:SetIsWorking(false)

		if (timer.Exists( "WaterEffect"..self:EntIndex() )) then
			timer.Remove( "WaterEffect"..self:EntIndex() )
		end	
	end)


end


function ENT:WaterEff()
	local effectData = EffectData();	
	effectData:SetStart(self:GetPos());
	effectData:SetOrigin(self:GetPos() + (self:GetUp()*10) + (self:GetRight()) + (self:GetForward()) );
	effectData:SetScale(2);	
	util.Effect("watersplash", effectData, true, true);
end;