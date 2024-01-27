
local PLUGIN = PLUGIN

PLUGIN.name = "Perma Remove"
PLUGIN.author = "alexgrist"
PLUGIN.desc = "Allows staff to permenantly remove map entities."

do
	local COMMAND = {
		description = "Навсегда удалить энтити карты.",
		superAdminOnly = true
	}

	function COMMAND:OnRun(client)
		local entity = client:GetEyeTraceNoCursor().Entity

		if (IsValid(entity) and entity:CreatedByMap()) then
			local entities = PLUGIN:GetData({})
				entities[#entities + 1] = entity:MapCreationID()
				entity:Remove()
			PLUGIN:SetData(entities)

			client:Notify("Энтити карты было удалено!")

			ix.log.Add(client, "mapEntRemoved", entity:MapCreationID(), entity:GetModel())
		else
			client:Notify("Вы смотрите не на энтити карты!")
		end
	end

	ix.command.Add("MapEntRemove", COMMAND)
end

if (SERVER) then
	function PLUGIN:LoadData()
		for _, v in ipairs(self:GetData({})) do
			local entity = ents.GetMapCreatedEntity(v)

			if (IsValid(entity)) then
				entity:Remove()
			end
		end
	end

	ix.log.AddType("mapEntRemoved", function(client, index, model)
		return string.format("%s удалил следующее энтити карты: #%d.", client:Name(), index, model)
	end)
end