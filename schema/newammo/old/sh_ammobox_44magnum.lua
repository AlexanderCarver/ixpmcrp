ITEM.name = "Патроны .44 Magnum"
ITEM.description = ""
ITEM.longdesc = "Револьверный боеприпас высокой мощности, разработанный на базе удлиненного патрона .44 S&W Special. Помимо револьверов используется в некоторых карабинах и винтовках. Несмотря на обозначение '.44', пули имеют диаметр около 10,9 мм."
ITEM.model = "models/lostsignalproject/items/ammo/357.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 30 -- Количество патриков в коробке.
ITEM.price = 1200 --Цена.
ITEM.ammo = "44magnum" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/357.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Револьверный патрон калибра .44 Magnum", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
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