include("shared.lua")

function ENT:Draw()

	self:DrawModel()

	
end
/*
hook.Add( "PreDrawHalos", "HaloNaDrzewach", function()

	local eye = LocalPlayer():GetEyeTrace()
	print(LocalPlayer():GetPos():DistToSqr(eye.Entity:GetPos()))
	
	if eye.Entity:GetClass() == "j_lumberjack_tree" and LocalPlayer():GetPos():DistToSqr(eye.Entity:GetPos()) < 100000 then
		halo.Add( ents.FindByClass( "j_lumberjack_tree" ), Color( 76, 153, 0 ), 4, 4, 2 )
	end

end)*/
