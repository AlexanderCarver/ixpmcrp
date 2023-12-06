PLUGIN.name = "Mining"
PLUGIN.author = "JohnyReaper"
PLUGIN.description = ""

ix.config.Add("MeltTime", 2, "How long does it take for a melt all the ores in the furnace? [In minutes]" , nil, {
	data = {min = 1, max = 10},
	category = "Mining System"
})

ix.config.Add("FurnaceSize", 3, "How much iron ore can the furnace hold?" , nil, {
	data = {min = 1, max = 5},
	category = "Mining System"
})

if (CLIENT) then

	function PLUGIN:PopulateEntityInfo(ent, tooltip)
		if (ent:GetClass() == "j_mining_rock") then

			local panel = tooltip:AddRow("name")
			panel:SetText("Руда")
			panel:SetImportant()
	  		-- panel:SetBackgroundColor(Color(250,250,0))
	  	 	panel:SizeToContents()
	  	 	

	  	 	local desc = tooltip:AddRowAfter("name", "desc")
			desc:SetText("Добывайте полезные ископаемые с помощью кирки")
	  		-- desc:SetBackgroundColor(Color(250,250,0))
	  	 	desc:SizeToContents()

	  	 	tooltip:SizeToContents()

	  	 end

  	 	if (ent:GetClass() == "j_mining_ironignot") then

			local panel = tooltip:AddRow("name")
			panel:SetText("Железный слиток")
			panel:SetImportant()
	  	 	panel:SizeToContents()
	  	 	

	  	 	local desc = tooltip:AddRowAfter("name", "desc")
			desc:SetText("Слишком горячий! Поместите в воду для охлаждения")
	  	 	desc:SizeToContents()

	  	 	tooltip:SizeToContents()

	  	end

	  	if (ent:GetClass() == "j_mining_bucket") then

			local panel = tooltip:AddRow("name")
			panel:SetText("Ведро с Водой")
			panel:SetImportant()
	  	 	panel:SizeToContents()
	  	 	

	  	 	local desc = tooltip:AddRowAfter("name", "desc")
			desc:SetText("Окуните сюда железо чтоб оно остыло и вы могли его взять")
	  	 	desc:SizeToContents()

	  	 	tooltip:SizeToContents()

	  	end

	end

end