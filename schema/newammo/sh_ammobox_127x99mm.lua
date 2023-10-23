ITEM.name = "Патроны 12.7x99 мм"
ITEM.description = ""
ITEM.longdesc = "Крупнокалиберный патрон, разработанный в США. Он был создан в 1920-х годах в качестве боеприпаса для крупнокалиберного пулемёта Browning M1921. После Второй мировой войны патрон стандартизован в НАТО и выпускается различными странами-участниками НАТО по единым техническим условиям."
ITEM.model = "models/lostsignalproject/items/ammo/127x55.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 10 -- Количество патриков в коробке.
ITEM.price = 800 --Цена.
ITEM.ammo = "ammo_127x55_fmj" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/127x55.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Винтовочный патрон калибра 12.7x99 мм", Color(64, 224, 208))
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
      ix.chat.Send(player, "me", "заряжает магазины патронами 12.7x99 мм")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}