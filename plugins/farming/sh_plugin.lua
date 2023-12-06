local PLUGIN = PLUGIN
PLUGIN.name = "Farming System"
PLUGIN.author = "DrodA & AleXXX_007"
PLUGIN.description = "New Brand Farming System."
function PLUGIN:SaveData()
	local savedTable = {}

	for k, v in ipairs(ents.GetAll()) do
		if (v:GetClass() == "ix_culture") then
			table.insert(savedTable, {
				pos = v:GetPos(),
				ang = v:GetAngles(),
				model = v:GetModel(),
				spawn = v:GetNetVar("spawn"),
				grow = v:GetNetVar("grow"),
				uid = v.uid,
			})
		end
	end

	self:SetData(savedTable)
end

function PLUGIN:LoadData()
	local savedTable = self:GetData() or {}

	for k, v in ipairs(savedTable) do
		local culture = ents.Create("ix_culture")
		culture:SetPos(v.pos)
		culture:SetAngles(v.ang)
		culture:SetNetVar("spawn", v.spawn)
		culture:SetNetVar("grow", v.grow)
		culture:Spawn()
		culture:Activate()
		culture:SetModel(v.model)
		culture.uid = v.uid
	end
end