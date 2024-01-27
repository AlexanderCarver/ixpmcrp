local PLUGIN = PLUGIN

PLUGIN.name = "Extra Commands"
PLUGIN.author = "TPTD"
PLUGIN.description = "Some shit like /try, /event, /localevent."


do
ix.chat.Register("globalevent", {
	description = "Чат для глобального ивента. Слышат абсолютно все на карте.",
	CanHear = 1000000,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(128, 0, 0), text)
	end,
	indicator = "chatPerforming"
})

ix.chat.Register("localevent", {
	description = "Чат для локального ивента. Слышат только люди в определённом радиусе.",
	CanHear = ix.config.Get("localEventRange", 560),
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(128, 0, 0), text)
	end,
	indicator = "chatPerforming"
})


ix.chat.Register("try", {
 	format = "** [Попытка] %s %s",
 	GetColor = function() return Color(140, 122, 230)end,
 	CanHear = ix.config.Get("chatRange", 280) * 2,
 	prefix = {},
	description = "@cmdMe",
 	indicator = "Пытается сделать что-то...",
	deadCanChat = true
})
end

ix.command.Add("Event", {
    description = "@cmdEvent",
    arguments = ix.type.text,
    superAdminOnly = true,
    OnRun = function(self, client, text)
        ix.chat.Send(client, "event", text)
    end
})

ix.command.Add("LocalEvent", {
    description = "Локальная версия команды /event для отыгровки событий.",
    arguments = ix.type.text,
    adminOnly = true,
    OnRun = function(self, client, text)
        ix.chat.Send(client, "localevent", text)
    end
})

ix.command.Add("try", {
	description = "Попробовать сделать что-то, указав это в прошедшем времени.",
	arguments = ix.type.text,
	OnRun = function(self, client, text)
        local str
        if not string.EndsWith(text,".") then
            text = text.."."
        end
        local git = tobool(math.random(0, 1))
        if git then 
            str= " удалось "..text
        else
            str = " не удалось "..text
        end
		ix.chat.Send(client, "try", str)
        

	end
})


ix.command.Add("clearitems", {
	description = "Очистить карту от предметов.",
	adminOnly = true,
	alias = {"removeitems", "cleanitems"},
	OnRun = function(self, client, arguments)

		for k, v in pairs(ents.FindByClass("ix_item")) do
			v:Remove()
		end

		client:Notify("Карта была очищена от предметов.")
	end
})

ix.command.Add("clearnpcs", {
	description = "Очистить карту от неписей.",
	adminOnly = true,
	alias = {"removenpcs", "cleannpcs"},
	OnRun = function(self, client, arguments)

	for k, v in pairs( ents.GetAll( ) ) do
	if IsValid( v ) and ( v:IsNPC() or baseclass.Get( v:GetClass() ).Base == 'base_nextbot' or baseclass.Get( v:GetClass() ).Base == 'nz_base' or  baseclass.Get( v:GetClass() ).Base == 'nz_risen' ) and !IsFriendEntityName( v:GetClass() ) then

		  v:Remove()

	   end
    end
	client:Notify("Все неписи были удалены с карты.")

	end
})

ix.command.Add("setdata", {
	description = "Установить дату для предмета, на который Вы смотрите. Используй в том случае, если знаешь, куда лезешь.",
	adminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.number
	},
	OnRun = function(self, client, key, data)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local stasheditem = ix.item.instances

		if (!data or !isnumber(data) or data < 0) then
			return "@invalidArg", 2
		end

		for k, v in pairs( stasheditem ) do
			if v:GetEntity() then
			local dist = hitpos:Distance(client:GetPos())
			local distance = v:GetEntity():GetPos():Distance( hitpos )
				if distance <= 32 then
					v:SetData(key, data)

					client:Notify( "Дата была установлена.")
				end
			end
		end
	end
})

ix.command.Add("CharResetValues", {
    adminOnly = true,
    description = "Сбросить потребности определённого персонажа (голод, жажда, радиация и так далее).",
    arguments = {bit.bor(ix.type.string, ix.type.optional)},
    OnRun = function(self, client, target)
        if not target or target == "" then
            target = client:GetCharacter():GetName()
        end

        local target = ix.util.FindPlayer(target)

        if not target then
            client:Notify("Неправильная цель!")

            return
        end

        target:SetPsyHealth(100)
        target:SetHunger(100)
        target:SetThirst(100)
        target:setRadiation(0)
        target:SetHealth(100)
        target:SetLocalVar("stm", 100)
        target:ResetDrunkLevel()

        if client == target then
            client:Notify("Вы сбросили потребности своего персонажа.")
        else
            client:Notify("Вы сбросили потребности персонажа: " .. target:Name() .. ".")
            target:Notify("Администратор "..client:Name().." полностью сбросил потребности Вашего персонажа.")
        end

        target:UpdatePsyHealthState(target)
        target:UpdateHungerState(target)
        target:UpdateThirstState(target)
    end
})

-- Credit goes to SmithyStanley
ix.command.Add("clearinv", {
	description = "Удаляет все предметы из инвентаря персонажа.",
	adminOnly = true,
	arguments = {
		ix.type.character
	},
	OnRun = function (self, client, character)
		local target = character

		if (target) then
			for k, v in pairs(target:GetInventory():GetItems()) do
				v:Remove()
			end
			client:Notify("Инвентарь "..target:GetName().." был полностью очищен.")
			ix.weight.Update(target)
			client:Notify("Вес инвентаря "..target:GetName().." был полностью сброшен..")
		end
	end
})

ix.command.Add("plytogglehidden", {
	description = "Скрывает персонажа от отображения в таблице игроков.",
	adminOnly = true,
	arguments = {
		ix.type.player
	},
	OnRun = function (self, client, target)
		if (target) then
			if target:GetNetVar("scoreboardhidden", false) then
				target:SetNetVar("scoreboardhidden", false)
				client:Notify(target:GetName().." is now displayed on the scoreboard.")
			else
				target:SetNetVar("scoreboardhidden", true)
				client:Notify(target:GetName().." has been hidden on the scoreboard.")
			end
		end
	end
})

function PLUGIN:ShouldShowPlayerOnScoreboard(client)
	if client:GetNetVar("scoreboardhidden", false) == true then
		return false
	end
end

ix.command.Add("coinflip", {
	description = "Подбросить монетку и проверить свою удачу.",
	OnRun = function(self, client, arguments)
		local coinSide = math.random(0, 1)
		if (coinSide > 0) then
			ix.chat.Send(client, "me", "подбрасывает монетку. Выпала решка.")
		else
			ix.chat.Send(client, "me", "подбрасывает монетку. Выпал орёл.")
		end
	end,
})