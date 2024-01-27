--[[
	This script is part of Black Mesa Roleplay schema by Zoephix and
	exclusively made for LimeFruit (www.limefruit.net)

	© Copyright 2021: Zoephix. do not share, use, re-distribute or modify
	without written permission from Zoephix.
--]]

PLUGIN.name = "Welcome"
PLUGIN.description = "Warm welcome from the administration."
PLUGIN.author = "Zoephix, Carver"

local factions = {FACTION_COMBATANT, FACTION_OFFICE, FACTION_SECURITYSERVICE, FACTION_EVENT}

if SERVER then
	function PLUGIN:OnCharacterCreated(ply, char)
		if not table.HasValue(factions, char:GetFaction()) then return end

		ix.chat.PrintChat(player.GetAll(), Color(65, 105, 225), "[ПЕЙДЖЕР: ОБЩАЯ] <:: Прибыло пополнение боевого персонала: '" .. char:GetName() .. ". ::>")
	end
end
