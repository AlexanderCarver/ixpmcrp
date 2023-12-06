AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include("shared.lua")



function ENT:Initialize()

	local modelsTree = {
	"models/props_foliage/urban_tree_giant02.mdl",
	}

	self:SetModel(table.Random(modelsTree))
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
	
	local phys = self:GetPhysicsObject()
	
	if phys:IsValid() then

		phys:Wake()

	end
	
	self.health = ix.config.Get("BigTreeHealth", 8)
	self.Respawning = false
	self.Posi = nil

end

function ENT:Odradzanie()

if (self.Respawning) then
	local respawnTime = ix.config.Get("BigTreeRespawn", 60)
	timer.Simple( 10, function() 
		if IsValid(self) then
			if (self.Respawning) then
			
			self.health = ix.config.Get("BigTreeHealth", 8)
			self.Respawning = false
			self:SetMaterial()
			self:SetCollisionGroup(0)
			self:SetPos(self.Posi)
			self:RemoveAllDecals() 
			
			end
			
		end
	end )
end
	
end

function ENT:OnTakeDamage(dmg)

	local player = dmg:GetAttacker()
	
	if( player:IsPlayer() and IsValid(player:GetActiveWeapon()) and player:GetActiveWeapon():GetClass() == "weapon_j_lumberjack_axe" ) then
		
		self:hitSound()
		
		self.health = self.health - 1
		
		if (!self.Respawning) and self.health == 0 then
		
			self.Posi = self:GetPos()

			ix.item.Spawn("wood_log" ,self:GetPos() + Vector(0,0,30))
			ix.item.Spawn("wood_log" ,self:GetPos() + Vector(0,0,87))
			ix.item.Spawn("wood_log" ,self:GetPos() + Vector(0,0,144))

			local breakSounds = {
			"physics/wood/wood_box_break2.wav",
			"physics/wood/wood_furniture_break2.wav",
			"physics/wood/wood_furniture_break2.wav",
			}
			self:EmitSound(table.Random(breakSounds))

			self:SetMaterial("Models/effects/vol_light001");
			self:SetCollisionGroup(10)
			
			self.Respawning = true
			self:SetPos(self:GetPos() + Vector(0,0,-300))
			self:Odradzanie()
			
		end
		

	end
end

function ENT:hitSound()
	Sounds = {
	"physics/wood/wood_strain1.wav",
	"physics/wood/wood_strain3.wav",
	"physics/wood/wood_strain4.wav",
	"physics/wood/wood_strain5.wav",
	"physics/wood/wood_plank_break4.wav",
	"physics/wood/wood_plank_break3.wav",
	"physics/wood/wood_plank_break2.wav",
	"physics/wood/wood_plank_break1.wav",
	
	}

    self.sound = CreateSound(self, Sound(table.Random(Sounds)))
    self.sound:SetSoundLevel(75)
	self.sound:PlayEx(1, 100)
end