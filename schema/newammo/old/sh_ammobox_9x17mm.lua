ITEM.name = "Патроны 9x17 мм"
ITEM.description = ""
ITEM.longdesc = "Пистолетный унитарный патрон центрального воспламенения с бесфланцевой гильзой цилиндрической формы, разработанный Джоном Браунингом в 1908 году для фирмы Colt на основе патрона 9×20 мм SR Browning Long."
ITEM.model = "models/lostsignalproject/items/ammo/9x18_p.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 40 -- Количество патриков в коробке.
ITEM.price = 1320 --Цена.
ITEM.ammo = "9x17mm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/9x18_p.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Пистолетный патрон калибра 9x17 мм", Color(64, 224, 208))
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
      ix.chat.Send(player, "me", "заряжает магазины патронами 5.45x39 мм.")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}