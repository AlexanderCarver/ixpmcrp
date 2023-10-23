ITEM.name = "Патроны 7.62x54 мм"
ITEM.description = ""
ITEM.longdesc = "Унитарный винтовочный патрон с гильзой с выступающей закраиной размерностью 7,62x53,72 мм, общей максимальной длиной патрона 77,16 мм, диаметром пули 7,62 мм и дульной энергией 3500 Дж. Очень мощная штука."
ITEM.model = "models/lostsignalproject/items/ammo/762x54.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 20 -- Количество патриков в коробке.
ITEM.price = 1080 --Цена.
ITEM.ammo = "ammo_762x54_7h1" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/762x54.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Винтовочный патрон калибра 7.62x54 мм", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит гильзу", Color(64, 224, 208))
end

--Эту функцию не трогай. Ежжи.
ITEM.functions.use = {
    name = "Зарядить магазин",
    icon = "icon16/stalker/load.png",
    OnRun = function(item)
    local rounds = item:GetData("rounds", item.ammoAmount)

    ix.util.PlayerPerformBlackScreenAction(item.player, "Заряжаем магазин...", 8, function(player) 
      ix.chat.Send(player, "me", "заряжает магазины патронами 7.62x54 мм")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}