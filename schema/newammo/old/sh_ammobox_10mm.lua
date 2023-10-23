ITEM.name = "Патроны 10 мм"
ITEM.description = ""
ITEM.longdesc = "Патрон был разработан шведской компанией Norma Precision в 1983 году для пистолета Bren Ten, спроектированного американской фирмой Dornaus & Dixon Enterprises с целью замены Colt M1911. Калибр был выбран из-за высокой мощности, и по идее предусматривался для замены популярного патрона .45 ACP."
ITEM.model = "models/lostsignalproject/items/ammo/357.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 40 -- Количество патриков в коробке.
ITEM.price = 550 --Цена.
ITEM.ammo = "10mm" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/357.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Пистолетный патрон калибра 10 мм", Color(64, 224, 208))
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