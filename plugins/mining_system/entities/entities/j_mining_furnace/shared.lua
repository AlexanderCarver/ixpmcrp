ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Furnace"
ENT.Category = "IX: Mining System"

ENT.Spawnable = true

function ENT:SetupDataTables()

	self:NetworkVar( "Int", 0, "WorkTime" )
	self:NetworkVar( "Int", 1, "fuel" )
	self:NetworkVar( "Int", 2, "Irons" )
	self:NetworkVar( "Bool", 0, "IsWorking" )
	
end
