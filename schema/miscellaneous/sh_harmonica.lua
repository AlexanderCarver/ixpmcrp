ITEM.name = "Губная гармоника"
ITEM.description = "Редкий представитель музыкальных инструментов... Нечасто такое тут увидишь."
ITEM.longdesc = "Музыкальный инструмент семейства гармоник. Представляет собой небольшой брусок со множеством отверстий сбоку. Выбор извлекаемых звуков осуществляется положением губ и языка на отверстиях, а также направлением движения воздуха на вдох или выдох. Можете попробовать подуть в неё."
ITEM.model = "models/lostsignalproject/items/misc/harmonica.mdl"

ITEM.width = 1
ITEM.height = 1

ITEM.price = 400

ITEM.sounds = {
	Sound("stalkersound/harmonica/harmonica_1.ogg"),
	Sound("stalkersound/harmonica/harmonica_2.ogg"),
	Sound("stalkersound/harmonica/harmonica_3.ogg"),
	Sound("stalkersound/harmonica/harmonica_4.ogg"),
	Sound("stalkersound/harmonica/harmonica_5.ogg")
}

ITEM.functions.use = { -- sorry, for name order.
	name = "Сыграть",
	OnRun = function(item)

		if(item:GetData("cooldown", 0) < os.time()) then

			local soundplay = table.Random(item.sounds)
			item.player:EmitSound(soundplay, 50, 100, 0.5)
			ix.chat.Send(item.player, "iteminternal", "берет губную гармонику двумя руками и подносит ее ко рту, начиная играть. Музыка мелодично заполняет пространство...", false)

			item:SetData("cooldown", os.time() + 15 )
		end

		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}
