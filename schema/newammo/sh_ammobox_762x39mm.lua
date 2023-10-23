ITEM.name = "Патроны 7.62x39 мм"
ITEM.description = ""
ITEM.longdesc = "Промежуточный патрон с невыступающей закраиной конструкции. Разработка была завершена к 1949 году, причём, несмотря на название, окончательный образец патрона сильно отличался от первоначального образца 1943 года, имевшего гильзу длиной 41 мм. В некоторых случаях патрон 7,62x39 мм упоминается как 7,62x39 мм M43."
ITEM.model = "models/lostsignalproject/items/ammo/762x39.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 20 -- Количество патриков в коробке.
ITEM.price = 1040 --Цена.
ITEM.ammo = "ammo_762x39_fmj" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/762x39.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Штурмовой патрон калибра 7.62x39 мм", Color(64, 224, 208))
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
      ix.chat.Send(player, "me", "заряжает магазины патронами 7.62x39 мм")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}