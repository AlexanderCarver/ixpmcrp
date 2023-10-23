ITEM.name = "Патроны 9x18 мм"
ITEM.description = ""
ITEM.longdesc = "Пистолетный унитарный патрон с бесфланцевой гильзой, созданный для замены патрона 7,62x25мм ТТ. Разработан Б.В. Сёминым в 1951 году."
ITEM.model = "models/lostsignalproject/items/ammo/9x18_p.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 40 -- Количество патриков в коробке.
ITEM.price = 1280 --Цена.
ITEM.ammo = "ammo_9x18_fmj" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/9x18_p.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Пистолетный патрон калибра 9x18 мм", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Пистолетная гильза", Color(64, 224, 208))
end

--Эту функцию не трогай. Ежжи.
ITEM.functions.use = {
    name = "Зарядить магазин",
    icon = "icon16/stalker/load.png",
    OnRun = function(item)
    local rounds = item:GetData("rounds", item.ammoAmount)

    ix.util.PlayerPerformBlackScreenAction(item.player, "Заряжаем магазин...", 8, function(player) 
      ix.chat.Send(player, "me", "заряжает магазины патронами 9x18 мм")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}