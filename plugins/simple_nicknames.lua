
local PLUGIN = PLUGIN

PLUGIN.name = "Simple Nicknames"
PLUGIN.author = "alexgrist"
PLUGIN.description = "Allows players to nickname themselves."

ix.lang.AddTable("russian", {
	cmdSetNickname = "Указать своё прозвище.",
	nicknameTooLong = "Прозвище, выбранное Вами, слишком длинное!",
	nicknameNowKnown = "Вас теперь знают как %s."
})

ix.command.Add("SetNickname", {
	description = "@cmdSetNickname",
	arguments = {
		bit.bor(ix.type.text, ix.type.optional)
	},
	OnRun = function(self, client, nickname)
		local character = client:GetCharacter()
		local name = character:GetName()

		if (isstring(nickname) and nickname != "" and nickname != "none") then
			if (nickname:len() > 24) then
				return "@nicknameTooLong"
			end

			if (!string.find(name, "'")) then
				name = string.gsub(name, " ", " '" .. nickname .. "' ")
			else
				name = string.gsub(name, "'.*'", "'" .. nickname .. "'")
			end
		else
			name = string.gsub(name, "'.*' ", "")
		end

		character:SetName(name)
		return "@nicknameNowKnown", name
	end
})
