ITEM.name = "Патроны .50 Action Express"
ITEM.description = ""
ITEM.longdesc = "Патрон 12,7мм, разработанный в 1988 году для израильского пистолета Desert Eagle. Один из самых мощных унитарных пистолетных патронов в мире. Имеет тупоконечную пулю, которая обуславливает огромное останавливающее действие данного патрона."
ITEM.model = "models/lostsignalproject/items/ammo/50cal_hs.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 30 -- Количество патриков в коробке.
ITEM.price = 1260 --Цена.
ITEM.ammo = "ammo_357_hp_mag" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/50cal_hs.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Пистолетный патрон калибра .50 Action Express", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит пистолетную гильзу", Color(64, 224, 208))
end

--Эту функцию не трогай. Ежжи.
ITEM.functions.use = {
    name = "Зарядить магазин",
    icon = "icon16/stalker/load.png",
    OnRun = function(item)
    local rounds = item:GetData("rounds", item.ammoAmount)

    ix.util.PlayerPerformBlackScreenAction(item.player, "Заряжаем магазин...", 8, function(player) 
      ix.chat.Send(player, "me", "заряжает магазины патронами .50 мм")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}