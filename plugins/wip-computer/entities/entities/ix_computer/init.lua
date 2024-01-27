
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
 
function ENT:Initialize()
	self:SetModel( "models/props_combine/combine_interface002.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

	self:SetIsBroken(false)
	self:SetSkin(0)

	self:EmitSound( "ambient/machines/combine_terminal_loop1.wav", 55, 120 )

	self:_SetTimer("InitComputerSound", 20, 0, function()
		if !self:GetIsBroken() then
			self:StopSound( "ambient/machines/combine_terminal_loop1.wav" )
			self:EmitSound( "ambient/machines/combine_terminal_loop1.wav", 55, 120 )
		end
	end)
end

--self:SetSkin(1)
--self:SetIsBroken(false)
--self:RemoveAllDecals()

util.AddNetworkString("ixComputer::SendNet")
function ENT:Use( pl, caller )
	if ( pl.b_InteractDelay or 0 ) > CurTime() then return end
	if ( self:GetIsBroken() or false ) then return end

	net.Start("ixComputer::SendNet")
	net.Send(pl)

	pl.b_InteractDelay = CurTime() + 3
end

function ENT:OnRemove()
	self:StopSound( "ambient/machines/combine_terminal_loop1.wav" )
end

function ENT:OnTakeDamage( dmg )
	if ( dmg:GetDamageType() == DMG_BLAST ) and !self:GetIsBroken() then
		local position = self:LocalToWorld(self:OBBCenter())
		local effect = EffectData()
			effect:SetStart(position)
			effect:SetOrigin(position)
			effect:SetScale(1)
		util.Effect("ManhackSparks", effect)

		self:StopSound( "ambient/machines/combine_terminal_loop1.wav" )
		self:SetIsBroken(true)
		self:SetSkin(1)
	end
end
