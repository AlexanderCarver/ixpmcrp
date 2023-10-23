ITEM.name = "Патроны 9x39 мм"
ITEM.description = ""
ITEM.longdesc = "Специальный патрон 9х39мм СП-5 гс (Индекс ГРАУ - 7Н8) с дозвуковой пулей массой 16 грамм с заостренным стальным сердечником на свинцовом поддоне, с биметаллической оболочкой, в стальной гильзе. Патрон был разработан в середине 1980-х годов на основе патрона 7,62x39мм УС гж для использования в снайперской винтовке ВСС Винторез. Патрон обладает хорошей поражающей способностью и бронепробиваемостью против базового и среднего уровня защиты. Однако, из-за своей конструкции, пуля имеет высокую вероятность отскакивания от различных поверхностей."
ITEM.model = "models/lostsignalproject/items/ammo/9x39.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 30 -- Количество патриков в коробке.
ITEM.price = 1380 --Цена.
ITEM.ammo = "ammo_9x39_pab9" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/9x39.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Винтовочный патрон калибра 9х39 мм", Color(64, 224, 208))
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
      ix.chat.Send(player, "me", "заряжает магазины патронами 9х39 мм")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}