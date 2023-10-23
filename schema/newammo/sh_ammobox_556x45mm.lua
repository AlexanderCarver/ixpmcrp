ITEM.name = "Патроны 5.56x45 мм NATO"
ITEM.description = ""
ITEM.longdesc = "Малоимпульсный промежуточный патрон с бесфланцевой гильзой бутылочной формы, принятый на вооружение странами НАТО в 1980-х годах. Аналогами данного патрона являются: Советский патрон 5,45x39 мм, который создавался с учётом опыта американцев создания и применения этого типа патрона."
ITEM.model = "models/lostsignalproject/items/ammo/556x45.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 30 -- Количество патриков в коробке.
ITEM.price = 1440 --Цена.
ITEM.ammo = "ammo_556x45_fmj" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/556x45.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Штурмовой патрон калибра 5.56x45 мм NATO", Color(64, 224, 208))
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
      ix.chat.Send(player, "me", "заряжает магазины патронами 5.56x45 мм")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}