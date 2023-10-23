ITEM.name = "Патроны 12-го калибра"
ITEM.description = ""
ITEM.longdesc = "Патрон с картечью 12/70 для ружей 12 калибра."
ITEM.model = "models/lostsignalproject/items/ammo/12x76.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 25 -- Количество патриков в коробке.
ITEM.price = 1050 --Цена.
ITEM.ammo = "ammo_12x70_buck" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/12x76.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Ружейный патрон 12-го калибра", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
end

--Эту функцию не трогай. Ежжи.
ITEM.functions.use = {
    name = "Зарядить магазин",
    icon = "icon16/stalker/load.png",
    OnRun = function(item)
    local rounds = item:GetData("rounds", item.ammoAmount)

    ix.util.PlayerPerformBlackScreenAction(item.player, "Заряжаем магазин...", 8, function(player) 
      ix.chat.Send(player, "me", "заряжает картечью 12x70 мм")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}