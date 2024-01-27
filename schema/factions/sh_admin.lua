FACTION.name = "Event Character"
FACTION.description = ""
FACTION.color = Color(112, 128, 144, 255)
FACTION.isDefault = false
FACTION.isGloballyRecognized = false
FACTION.models = {
    "models/leygun/rfarmy/soilder_rf_07.mdl"
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

FACTION_EVENT = FACTION.index