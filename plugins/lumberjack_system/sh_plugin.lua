PLUGIN.name = "Lumberjack"
PLUGIN.author = "JohnyReaper"
PLUGIN.description = ""

ix.config.Add("TreeRespawn", 60, "How long does it take for a tree to regenerate? [In seconds]" , nil, {
	data = {min = 15, max = 500},
	category = "WoodCutter"
})

ix.config.Add("BigTreeRespawn", 60, "How long does it take for a big tree to regenerate? [In seconds]" , nil, {
	data = {min = 15, max = 500},
	category = "WoodCutter"
})

ix.config.Add("TreeHealth", 8, "Tree health (number of hits to fell it)" , nil, {
	data = {min = 1, max = 12},
	category = "WoodCutter"
})

ix.config.Add("BigTreeHealth", 10, "Big tree health (number of hits to fell it)" , nil, {
	data = {min = 1, max = 12},
	category = "WoodCutter"
})

ix.config.Add("SawmillProgress", 40, "How many seconds will the sawmill spend processing wood to make a board" , nil, {
	data = {min = 10, max = 120},
	category = "WoodCutter"
})

-- if (CLIENT) then

-- 	function PLUGIN:PopulateEntityInfo(ent, tooltip)
-- 		if (ent:GetClass() != "j_lumberjack_tree") and (ent:GetClass() != "j_lumberjack_tree_big") then return end

-- 		local panel = tooltip:AddRow("name")
-- 		panel:SetText("Tree")
-- 		panel:SetImportant()
--   		-- panel:SetBackgroundColor(Color(250,250,0))
--   	 	panel:SizeToContents()
  	 	

--   	 	local desc = tooltip:AddRowAfter("name", "desc")
-- 		desc:SetText("Cut with an axe to get a log")
--   		-- desc:SetBackgroundColor(Color(250,250,0))
--   	 	desc:SizeToContents()

--   	 	tooltip:SizeToContents()
-- 	end

-- end