AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include("shared.lua")



function ENT:Initialize()

	models = {
	"models/props_wasteland/rockgranite02a.mdl",
	"models/props_wasteland/rockgranite02c.mdl",
	}

	self:SetModel(table.Random(models))
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
	local phys = self:GetPhysicsObject()
	
	if phys:IsValid() then

		phys:Wake()

	end
	


end



function ENT:OnTakeDamage(dmg)

	local player = dmg:GetAttacker()
	
	if( player:IsPlayer() and IsValid(player:GetActiveWeapon()) and player:GetActiveWeapon():GetClass() == "weapon_j_mining_pickaxe" ) then
		
		if (math.random(1,10) < 5) then


			local itemtype = math.random(1,100)
			local vPos = dmg:GetDamagePosition()
			
			if itemtype < 40 then
			
				ix.item.Spawn("ore_stone" ,vPos)
				
			elseif itemtype < 80 then
				
				ix.item.Spawn("ore_coal" ,vPos)
				
			elseif itemtype < 100 then

				ix.item.Spawn("ore_iron" ,vPos)
				

			end
		end
		self:RemoveAllDecals()
	end
end
