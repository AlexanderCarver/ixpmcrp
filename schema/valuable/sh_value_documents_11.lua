ITEM.name = "Книга исследований артефактов"
ITEM.description = "Книга исследований, содержащая каталог некоторых распространенных артефактов."
ITEM.longdesc = "Журнал исследований содержит мало полезной информации для сталкеров, но для исследователей это весьма ценно."
ITEM.model = "models/lostsignalproject/items/quest/document_01.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 5420

ITEM.flatweight = 0.920

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