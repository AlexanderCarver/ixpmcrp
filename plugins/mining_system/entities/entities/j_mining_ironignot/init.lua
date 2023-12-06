AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include("shared.lua")



function ENT:Initialize()

	self:SetModel("models/props_clutter/ingot_iron.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType( SIMPLE_USE )
	
	
	local phys = self:GetPhysicsObject()
	
	if phys:IsValid() then

		phys:Wake()

	end
	

end

function ENT:Use(act, call)

	if (call:IsPlayer()) then
		call:Notify("вам нужно снизить температуру слитка, чтобы иметь возможность взять его в инвентарь")
	end	

end	