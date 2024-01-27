
ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "CP Terminal"
ENT.Category  = "HL2 RP"
ENT.AdminOnly = true
ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "IsBroken" )
end