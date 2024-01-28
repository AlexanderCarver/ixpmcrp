FACTION.name = "Office Personnel"
FACTION.description = ""
FACTION.color = Color(245, 245, 245, 255)
FACTION.isDefault = false
FACTION.isGloballyRecognized = false
FACTION.models = {
    "models/kuge/private military contractor/pmc-5.mdl"
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

FACTION_OFFICE = FACTION.index