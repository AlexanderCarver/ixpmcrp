ITEM.name = "Патроны 5.45x39 мм"
ITEM.description = ""
ITEM.longdesc = "Малоимпульсный советский промежуточный унитарный патрон центрального воспламенения. Малокалиберная пуля с высокой начальной скоростью обеспечивает высокую настильность траектории, обладает неплохим пробивным действием и значительной убойной силой. Малый импульс отдачи в момент выстрела благоприятно сказывается на кучности и меткости стрельбы, а уменьшение массы патрона позволяет стрелку увеличить носимый боезапас."
ITEM.model = "models/lostsignalproject/items/ammo/545x39.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 30
ITEM.price = 1440
ITEM.ammo = "ammo_545x39_fmj"
ITEM.model = "models/lostsignalproject/items/ammo/545x39.mdl"

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Штурмовой патрон калибра 5.45x39 мм", Color(64, 224, 208))
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
      ix.chat.Send(player, "me", "заряжает магазины патронами 5.45x39 мм.")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}