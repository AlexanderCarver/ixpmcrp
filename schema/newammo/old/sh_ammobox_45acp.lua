ITEM.name = "Патроны .45 ACP"
ITEM.description = ""
ITEM.longdesc = "Американский пистолетный унитарный патрон с бесфланцевой гильзой цилиндрической формы, разработанный в 1904 году. Принят на снабжение Армии США в 1911 году вместе с принятием на вооружение пистолета M1911. Был основным армейским пистолетным патроном США обе мировые войны."
ITEM.model = "models/lostsignalproject/items/ammo/45cal.mdl"
ITEM.useSound = "weapons/cloth3.wav"

ITEM.ammoAmount = 40 -- Количество патриков в коробке.
ITEM.price = 1260 --Цена.
ITEM.ammo = "ammo_1143x23_fmj" --Сами патрики.
ITEM.model = "models/lostsignalproject/items/ammo/45cal.mdl" --Моделька.

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Пистолетный патрон калибра .45 ACP", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит порох", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Содержит пистолетную гильзу", Color(64, 224, 208))
end

--Эту функцию не трогай. Ежжи.
ITEM.functions.use = {
    name = "Зарядить магазин",
    icon = "icon16/stalker/load.png",
    OnRun = function(item)
    local rounds = item:GetData("rounds", item.ammoAmount)

    ix.util.PlayerPerformBlackScreenAction(item.player, "Заряжаем магазин...", 8, function(player) 
      ix.chat.Send(player, "me", "заряжает магазины патронами .45 ACP")
    end)
      item.player:GiveAmmo(rounds, item.ammo)
      item.player:EmitSound(item.useSound, 110)
    return true
  end,
}