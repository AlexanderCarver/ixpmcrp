ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Bucket"
ENT.Category = "IX: Mining System"

ENT.Holdable = true


ENT.Spawnable = true

function ENT:SetupDataTables()

	self:NetworkVar( "Bool", 0, "IsWorking" )
	
end
