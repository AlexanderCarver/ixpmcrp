FACTION.name = "Combatants Personnel"
FACTION.description = ""
FACTION.color = Color(47, 79, 79, 255)
FACTION.isDefault = true
FACTION.isGloballyRecognized = false
FACTION.models = {
    "models/kuge/private military contractor/pmc-5.mdl"
}

FACTION.startSkills = {
	["athletics"] = 10,
	["acrobatics"] = 10,
	["guns"] = 10,
	["unarmed"] = 5,
	["medicine"] = 5,
	["meleeguns"] = 10,
	["impulse"] = 10,
}

function FACTION:OnTransfered(client)
	local character = client:GetCharacter()
	character:SetName(self:GetDefaultName())
	character:SetModel(self.models[1])
end

/*
function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("ak47", 1)

end
*/

FACTION_COMBATANT = FACTION.index