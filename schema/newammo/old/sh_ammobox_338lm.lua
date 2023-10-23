ITEM.name = "Патроны .338 Lapua Magnum"
ITEM.description = ""
ITEM.longdesc = "Специальный винтовочный патрон для стрельбы на большие дистанции, на сегодняшний момент широко используется также охотниками и стрелками-спортсменами. Целью разработки патрона было создать боеприпас и винтовку под него с возможностью прогнозируемой стрельбы по «ростовой мишени» до 1800 м, то есть винтовку, способную стрелять дальше, чем .300 Win.Mag и при этом легче, чем винтовки под патрон .50 BMG."
ITEM.model = "models/kek1ch/ammo_86x70_fmj.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 15 -- Количество патриков в коробке.
ITEM.price = 975 --Цена.
ITEM.ammo = "338lm" --Сами патрики.
ITEM.model = "models/kek1ch/ammo_86x70_fmj.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Винтовочный патрон калибра .338 Lapua Magnum", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит винтовочную гильзу", Color(64, 224, 208))
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