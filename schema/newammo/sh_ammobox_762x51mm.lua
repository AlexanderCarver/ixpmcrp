ITEM.name = "Патроны 7.62x51 мм NATO"
ITEM.description = ""
ITEM.longdesc = "Стандартный винтовочно-пулемётный боеприпас стран — участниц НАТО. Принят в 1954 году под обозначением T65, впоследствии неоднократно модернизирован. Этот патрон разрабатывался после Второй мировой войны как облегчённый вариант устаревшего .30-06, в расчёте на достижение той же баллистики и энергетики боеприпаса при уменьшении его размеров за счёт меньшего по массе заряда более мощного и современного пороха в уменьшенной гильзе."
ITEM.model = "models/lostsignalproject/items/ammo/762x51.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 20 -- Количество патриков в коробке.
ITEM.price = 1080 --Цена.
ITEM.ammo = "ammo_762x51_fmj" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/762x51.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Винтовочный патрон калибра 7.62x51 мм NATO", Color(64, 224, 208))
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
      ix.chat.Send(player, "me", "заряжает магазины патронами 7.62x51 мм")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}