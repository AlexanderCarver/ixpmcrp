ITEM.name = "Пустой блокнот для заметок"
ITEM.description = "Блокнот для заметок. Все страницы пусты."
ITEM.longdesc = "В этом блоке заметок нет ни одной написанной страницы. Это стоит очень мало, так как бумага редко имеет какую-либо ценность в зоне, так как многие сообщения передаются в цифровом виде. Однако некоторые старомодные люди могут найти ему применение, но вы, скорее всего, не заработаете большую сумму денег."
ITEM.model = "models/lostsignalproject/items/quest/notes_writing_book_2.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 360

ITEM.flatweight = 0.500

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 19.607843399048),
	ang = Angle(90, 180, 0),
	fov = 50,
}

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Документ", Color(200, 200, 200))
		end
	end
end