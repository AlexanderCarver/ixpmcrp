ITEM.name = "Выстрел ОГ-7В"
ITEM.description = ""
ITEM.longdesc = "В ГНПП Базальт был выпущен на свет снаряд для РПГ-7 под кодовым названием ОГ-7В с калиберной осколочной гранатой. Она обеспечивает эффективное поражение живой силы противника в средствах индивидуальной защиты на открытой местности и в полевых сооружениях открытого типа, а также небронированной или лёгкобронированной военной техники. "
ITEM.model = "models/flaymi/anomaly/ammo/ammo_og_7b.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 1 -- Количество патриков в коробке.
ITEM.price = 750 --Цена.
ITEM.ammo = "ammo_og-7b" --Сами патрики.
ITEM.model = "models/flaymi/anomaly/ammo/ammo_og_7b.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Выстрел ОГ-7В", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
end

--Эту функцию не трогай. Ежжи.
ITEM.functions.use = {
    name = "Зарядить Выстрел ОГ-7В",
    icon = "icon16/stalker/load.png",
    OnRun = function(item)
    local rounds = item:GetData("rounds", item.ammoAmount)

    ix.util.PlayerPerformBlackScreenAction(item.player, "Заряжаем гранатомет...", 8, function(player) 
      ix.chat.Send(player, "me", "заряжает в гранатомет выстрел ОГ-7В")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}