ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Sawmill"
ENT.Category = "IX: WoodCutter"

ENT.Spawnable = true

function ENT:SetupDataTables()

	self:NetworkVar( "Int", 1, "Logs" )
	self:NetworkVar( "Int", 2, "WorkingTime" )
	self:NetworkVar( "Bool", 1, "Working" )
	
end
