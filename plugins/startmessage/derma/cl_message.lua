local PLUGIN = PLUGIN

local PANEL = {}

hook.Add("PopulateHelpMenu", "ixHelpMenu", function(tabs)
    tabs["commands"] = nil
    tabs['plugins'] = nil
	tabs["flags"] = function(container)
		-- info text
		local info = container:Add("DLabel")
		info:SetFont("ixSmallFont")
		info:SetText(L("helpFlags"))
		info:SetContentAlignment(5)
		info:SetTextColor(color_white)
		info:SetExpensiveShadow(1, color_black)
		info:Dock(TOP)
		info:DockMargin(0, 0, 0, 8)
		info:SizeToContents()
		info:SetTall(info:GetTall() + 16)

		info.Paint = function(_, width, height)
			surface.SetDrawColor(ColorAlpha(derma.GetColor("Info", info), 160))
			surface.DrawRect(0, 0, width, height)
		end

		-- flags
		for k, v in SortedPairs(ix.flag.list) do
			local background = ColorAlpha(
				LocalPlayer():GetCharacter():HasFlags(k) and derma.GetColor("Success", info) or derma.GetColor("Error", info), 88
			)

			local panel = container:Add("Panel")
			panel:Dock(TOP)
			panel:DockMargin(0, 0, 0, 8)
			panel:DockPadding(4, 4, 4, 4)
			panel.Paint = function(_, width, height)
				derma.SkinFunc("DrawImportantBackground", 0, 0, width, height, background)
			end

			local flag = panel:Add("DLabel")
			flag:SetFont("ixMonoMediumFont")
			flag:SetText(string.format("[%s]", k))
			flag:Dock(LEFT)
			flag:SetTextColor(color_white)
			flag:SetExpensiveShadow(1, color_black)
			flag:SetTextInset(4, 0)
			flag:SizeToContents()
			flag:SetTall(flag:GetTall() + 8)

			local description = panel:Add("DLabel")
			description:SetFont("ixMediumLightFont")
			description:SetText(v.description)
			description:Dock(FILL)
			description:SetTextColor(color_white)
			description:SetExpensiveShadow(1, color_black)
			description:SetTextInset(8, 0)
			description:SizeToContents()
			description:SetTall(description:GetTall() + 8)

			panel:SizeToChildren(false, true)
		end
	end

	tabs["commands"] = function(container)
		-- info text
		local info = container:Add("DLabel")
		info:SetFont("ixSmallFont")
		info:SetText(L("helpCommands"))
		info:SetContentAlignment(5)
		info:SetTextColor(color_white)
		info:SetExpensiveShadow(1, color_black)
		info:Dock(TOP)
		info:DockMargin(0, 0, 0, 8)
		info:SizeToContents()
		info:SetTall(info:GetTall() + 16)

		info.Paint = function(_, width, height)
			surface.SetDrawColor(ColorAlpha(derma.GetColor("Info", info), 160))
			surface.DrawRect(0, 0, width, height)
		end

		-- commands
		for uniqueID, command in SortedPairs(ix.command.list) do
			if (command.OnCheckAccess and !command:OnCheckAccess(LocalPlayer())) then
				continue
			end

			local bIsAlias = false
			local aliasText = ""

			-- we want to show aliases in the same entry for better readability
			if (command.alias) then
				local alias = istable(command.alias) and command.alias or {command.alias}

				for _, v in ipairs(alias) do
					if (v:lower() == uniqueID) then
						bIsAlias = true
						break
					end

					aliasText = aliasText .. ", /" .. v
				end

				if (bIsAlias) then
					continue
				end
			end

			-- command name
			local title = container:Add("DLabel")
			title:SetFont("ixMediumLightFont")
			title:SetText("/" .. command.name .. aliasText)
			title:Dock(TOP)
			title:SetTextColor(ix.config.Get("color"))
			title:SetExpensiveShadow(1, color_black)
			title:SizeToContents()

			-- syntax
			local syntaxText = command.syntax
			local syntax

			if (syntaxText != "" and syntaxText != "[none]") then
				syntax = container:Add("DLabel")
				syntax:SetFont("ixMediumLightFont")
				syntax:SetText(syntaxText)
				syntax:Dock(TOP)
				syntax:SetTextColor(color_white)
				syntax:SetExpensiveShadow(1, color_black)
				syntax:SetWrap(true)
				syntax:SetAutoStretchVertical(true)
				syntax:SizeToContents()
			end

			-- description
			local descriptionText = command:GetDescription()

			if (descriptionText != "") then
				local description = container:Add("DLabel")
				description:SetFont("ixSmallFont")
				description:SetText(descriptionText)
				description:Dock(TOP)
				description:SetTextColor(color_white)
				description:SetExpensiveShadow(1, color_black)
				description:SetWrap(true)
				description:SetAutoStretchVertical(true)
				description:SizeToContents()
				description:DockMargin(0, 0, 0, 8)
			elseif (syntax) then
				syntax:DockMargin(0, 0, 0, 8)
			else
				title:DockMargin(0, 0, 0, 8)
			end
		end
	end

	tabs["Начало игры"] = function(container)
        container.greyheader = container:Add("DLabel")
        container.greyheader:SetFont("ixSmallFont")
        container.greyheader:SetText("< Часто задаваемые вопросы >")
        container.greyheader:SetContentAlignment(5)
        container.greyheader:SetTextColor(color_white)
        container.greyheader:SetExpensiveShadow(1, color_black)
        container.greyheader:Dock(TOP)
        container.greyheader:DockMargin(0, 0, 0, 8)
        container.greyheader:SizeToContents()
        container.greyheader:SetTall(container.greyheader:GetTall() + 16)
        container.greyheader.Paint = function(_, width, height)
            surface.SetDrawColor(40, 40, 40)
            surface.DrawRect(0, 0, width, height)
        end

        container.BetaText = container:Add("DLabel")
        container.BetaText:SetFont("ixGuideSmallFont")
        container.BetaText:SetText("\n1) О чём сюжет?\nСюжет повествует о многострадальной России, которая столкнулась с внешними и внутренними врагами. По лору сейчас октябрь 1996 года. На дворе кризис - в стране идёт вторая перестройка. Только-только кончилась первая чеченская, а на фондовом рынке очередной обвал. Общество хоть и держится, но наблюдается сильный упадок нравственности, что ведёт к рассвету наркомании, проявлениям алкоголизма и распространению бандитизма... Буквально месяц назад Вы по IC услышали, что в Сибири происходят странные вещи: стягивание федеральных войск, создание кордонов, эвакуация мирного населения из ближайших пунктов... И Вы решили прийи сюда. Миновав военные патрули, Вы добрались до Территории. Зачем Вы здесь? Ради славы? Ради богатств? Из-за интереса?.. Кто знает. Вам нужно придумать свою историю и задать себе цель, чтобы определить свою роль в этой истории. Более подробные аспекты лора и вопросы по нему можно узнать в Дискорде.")
        container.BetaText:Dock(TOP)
        container.BetaText:SetTextColor(color_white)
        container.BetaText:SetExpensiveShadow(1, color_black)
        container.BetaText:SetWrap(true)
        container.BetaText:SetAutoStretchVertical(true)
        container.BetaText:SizeToContents()
        container.BetaText:DockMargin(10, 10, 0, 0)
	


	    container.BetaText = container:Add("DLabel")
        container.BetaText:SetFont("ixGuideSmallFont")
        container.BetaText:SetText("\n\n2) Где я появился? Что за блядский подвал?\nВаш персонаж появился в админ-зоне - специально оборудованной OOC-локации. OOC - это Out-Of-Character, что буквально означает 'вне персонажа'/'NonRP'. Здесь безопасно, несмотря на сырость и темноту, да и OOC-общение разрешено. Вам нужно пройти ролевое одобрение, чтобы Ваш персонаж соответствовал игровой вселенной, а потом получить стартовый подарок от администрации и доброе напутствие. Думаешь, что второе необязательно? Поверь: Территория опасна, так как тварей (которые преследуют тебя всю карту), там различных хватает. Тебе сейчас нужно отписаться в OOC-чат (//) или в тикет (@), чтобы к тебе прилетел администратор и объяснил механики игры (а у нас их много, так как есть система ближнего боя, система уклонений и система передозировки).")
        container.BetaText:Dock(TOP)
        container.BetaText:SetTextColor(color_white)
        container.BetaText:SetExpensiveShadow(1, color_black)
        container.BetaText:SetWrap(true)
        container.BetaText:SetAutoStretchVertical(true)
        container.BetaText:SizeToContents()
        container.BetaText:DockMargin(10, 10, 0, 0)



        container.BetaText = container:Add("DLabel")
        container.BetaText:SetFont("ixGuideSmallFont")
        container.BetaText:SetText("\n\n3) О чём сервер?\nСервер повсящён хорошему РП, историям персонажей в стиле текстового РП (взаимоотношениям персонажей, грубо говоря), и хорошо оформленной атмосфере ужасных 90-ых. Нашему проекту вот уже 3.5 года. У нас можно найти интересные механики (начиная от психики со здоровьем и заканчивая иным подходом к ивентам, который предполагает бросок кубика даже при хождении по крыше), качественный подход к реализации РП-процесса и отзывычивое, но строгое сообщество. С точки зрения гендера, сервер, по большей части, технически относится к 'StalkerRP', так как тут тоже есть фракции и артефакты с обособленной территорией, где происходят разные ужасы. Отличает нас только кастомная история и немного иной подход к миру, так как тут он более мрачный и политичный (можно хоть скинхеда отыгрывать, ей Богу).")
        container.BetaText:Dock(TOP)
        container.BetaText:SetTextColor(color_white)
        container.BetaText:SetExpensiveShadow(1, color_black)
        container.BetaText:SetWrap(true)
        container.BetaText:SetAutoStretchVertical(true)
        container.BetaText:SizeToContents()
        container.BetaText:DockMargin(10, 10, 0, 0)



        container.BetaText = container:Add("DLabel")
        container.BetaText:SetFont("ixGuideSmallFont")
        container.BetaText:SetText("\n\n4) Дискорд?/Коллекция?/Донат?!\nВсё лежит ниже. Если не нашли ответ на свой вопрос - обратитесь к администрации через тикет (@) или OOC-чат (//).")
        container.BetaText:Dock(TOP)
        container.BetaText:SetTextColor(color_white)
        container.BetaText:SetExpensiveShadow(1, color_black)
        container.BetaText:SetWrap(true)
        container.BetaText:SetAutoStretchVertical(true)
        container.BetaText:SizeToContents()
        container.BetaText:DockMargin(10, 10, 0, 0)

    end

	tabs["Ссылки"] = function(container)
        container.greyheader = container:Add("DLabel")
        container.greyheader:SetFont("ixSmallFont")
        container.greyheader:SetText("")
        container.greyheader:SetContentAlignment(5)
        container.greyheader:SetTextColor(color_white)
        container.greyheader:SetExpensiveShadow(1, color_black)
        container.greyheader:Dock(TOP)
        container.greyheader:DockMargin(0, 0, 0, 8)
        container.greyheader:SizeToContents()
        container.greyheader:SetTall(container.greyheader:GetTall() + 16)
        container.greyheader.Paint = function(_, width, height)
            surface.SetDrawColor(40, 40, 40)
            surface.DrawRect(0, 0, width, height)
        end

        container.discord = container:Add("DButton")
        container.discord:SetFont("ixMenuButtonFontSmall")
        container.discord:SetText("Правила (в Дискорде есть краткая версия)")
        container.discord:SetContentAlignment(5)
        container.discord:SetTextColor(color_white)
        container.discord:SetExpensiveShadow(1, color_black)
        container.discord:Dock(TOP)
        container.discord:DockMargin(0, 0, 0, 8)
        container.discord:SizeToContents()
        container.discord:SetTall(container.discord:GetTall() + 24)
        container.discord.Paint = function(this, width, height)
            surface.SetDrawColor(Color(0, 0, 205))
            surface.DrawRect(0, 0, width, height)
        end
        container.discord.DoClick = function(this)
            gui.OpenURL('https://docs.google.com/document/d/1nqcRzwCG-ZofQucxOkHkEvddk_DLAAWkv5AP3XQ231A/edit?usp=sharing')
        end

        container.website = container:Add("DButton")
        container.website:SetFont("ixMenuButtonFontSmall")
        container.website:SetText("Discord")
        container.website:SetContentAlignment(5)
        container.website:SetTextColor(color_white)
        container.website:SetExpensiveShadow(1, color_black)
        container.website:Dock(TOP)
        container.website:DockMargin(0, 0, 0, 8)
        container.website:SizeToContents()
        container.website:SetTall(container.website:GetTall() + 24)
        container.website.Paint = function(this, width, height)
            surface.SetDrawColor(Color(114, 137, 218))
            surface.DrawRect(0, 0, width, height)
        end
        container.website.DoClick = function(this) 
            gui.OpenURL('https://discord.gg/xq9tB6p84B')
        end

        container.website = container:Add("DButton")
        container.website:SetFont("ixMenuButtonFontSmall")
        container.website:SetText("Коллекция")
        container.website:SetContentAlignment(5)
        container.website:SetTextColor(color_white)
        container.website:SetExpensiveShadow(1, color_black)
        container.website:Dock(TOP)
        container.website:DockMargin(0, 0, 0, 8)
        container.website:SizeToContents()
        container.website:SetTall(container.website:GetTall() + 24)
        container.website.Paint = function(this, width, height)
            surface.SetDrawColor(Color(138, 43, 226))
            surface.DrawRect(0, 0, width, height)
        end
        container.website.DoClick = function(this) 
            gui.OpenURL('https://steamcommunity.com/sharedfiles/filedetails/?id=1972458913')
        end
    end
end)

function PANEL:Init()
	if (IsValid(PLUGIN.panel)) then
		PLUGIN.panel:Remove()
	end

	self:SetSize(850, 700)
	self:Center()
    self:SetTitle("Помощь")
	self:SetBackgroundBlur(true)
	self:SetDeleteOnClose(true)
    self:SetDraggable(false)
    self:ShowCloseButton(false)

    self:Add('ixHelpMenu')

	self:MakePopup()

    self.close = self:Add("ixMenuButton")
    self.close:Dock(BOTTOM)
    self.close:SetSize(100, 50)
    self.close:SetText("Закрыть")
    self.close.DoClick = function()
        self:Remove()
    end

	PLUGIN.panel = self
end

function PANEL:OnRemove()
	PLUGIN.panel = nil
    ix.option.Set("showStartMessage", false)
end

vgui.Register("ixStartMessage", PANEL, "DFrame")