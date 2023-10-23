ITEM.name = "Патроны .357 SIG"
ITEM.description = ""
ITEM.longdesc = "Револьверный патрон повышенной мощности, созданный в 1994 году швейцарской компанией SIG Sauer совместно с американской компанией Federal Cartridge на основе гильзы .40 S&W. Ввиду высокой точности и хороших останавливающего и пробивного действий используется рядом полицейских департаментов и секретной службой США. Крайне новая находка для нашего времени."
ITEM.model = "models/lostsignalproject/items/ammo/357.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 40 -- Количество патриков в коробке.
ITEM.price = 1480 --Цена.
ITEM.ammo = "57mm" --Сами патрики. По велению Карвера они сломаны ради 50ae для Дигла, вот как их починить, заменить 9 строчку на это : ammo_357_hp_mag
ITEM.model = "models/lostsignalproject/items/ammo/357.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Револьверный патрон калибра .357 SIG", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
end

--Эту функцию не трогай. Ежжи.
ITEM.functions.use = {
    name = "Зарядить магазин",
    icon = "icon16/stalker/load.png",
    OnRun = function(item)
    local rounds = item:GetData("rounds", item.ammoAmount)

    ix.util.PlayerPerformBlackScreenAction(item.player, "Заряжаем магазин...", 8, function(player) 
      ix.chat.Send(player, "me", "заряжает магазины патронами .357 мм")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}