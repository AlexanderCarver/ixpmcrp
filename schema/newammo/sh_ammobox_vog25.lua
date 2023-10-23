ITEM.name = "Граната ВОГ-25"
ITEM.description = ""
ITEM.longdesc = "Осколочная граната подствольного гранатомёта ГП-25 «Костёр». Радиус эффективной зоны поражения осколками составляет около 4,5 метра. Используется также в комплексе «ОЦ-14 Гроза» и гранатомёте «РГ-6»."
ITEM.model = "models/flaymi/anomaly/ammo/ammo_vog_25.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 1 -- Количество патриков в коробке.
ITEM.price = 450 --Цена.
ITEM.ammo = "ammo_vog-25" --Сами патрики.
ITEM.model = "models/flaymi/anomaly/ammo/ammo_vog_25.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Граната ВОГ-25", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
end

--Эту функцию не трогай. Ежжи.
ITEM.functions.use = {
    name = "Зарядить ВОГ-25",
    icon = "icon16/stalker/load.png",
    OnRun = function(item)
    local rounds = item:GetData("rounds", item.ammoAmount)

    ix.util.PlayerPerformBlackScreenAction(item.player, "Заряжаем гранатомет...", 8, function(player) 
      ix.chat.Send(player, "me", "заряжает гранатомет ГП-25")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}