ITEM.name = "Иллюстрация Сборки огнестрельного Оружия"
ITEM.description = "Единственная страница, вырванная из руководства по оружию."
ITEM.longdesc = "На этой единственной странице показаны различные элементы сборки и разборки оружия советского происхождения."
ITEM.model = "models/lostsignalproject/items/quest/notes_letter_2.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 160

ITEM.flatweight = 0.100

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