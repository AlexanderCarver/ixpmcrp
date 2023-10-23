ITEM.name = "Торговая книга"
ITEM.description = "Блокнот с каракулями, описывающими транзакции."
ITEM.longdesc = "В блоке заметок многие страницы заполнены каракулями, большинство из которых нечитабельны. Страницы содержат в основном документацию о совершенных сделках, включая различные регистрации доходов на страницах."
ITEM.model = "models/lostsignalproject/items/quest/notes_writing_book_1.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 730

ITEM.flatweight = 0.550

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-1, 0, 200),
	ang = Angle(90, 180, 0),
	fov = 5,
}


if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Документ", Color(200, 200, 200))
		end
	end
end