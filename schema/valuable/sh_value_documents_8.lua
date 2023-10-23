ITEM.name = "Нечитаемая Разорванная Записка"
ITEM.description = "Клочок бумаги с неразборчивым почерком."
ITEM.longdesc = "Записка, похоже, приказ или что-то в этом роде, так как на ней две подписи. Однако вы не можете разобрать ничего из того, что там написано."
ITEM.model = "models/lostsignalproject/items/quest/notes_letter_1.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 80

ITEM.flatweight = 0.090

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 19.607843399048),
	ang = Angle(90, 180, 0),
	fov = 57.058823529412,
}

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Документ", Color(200, 200, 200))
		end
	end
end