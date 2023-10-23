ITEM.name = "Биографические данные ученого"
ITEM.description = "Папка, содержащая информацию о работе и достижениях местного профессора."
ITEM.longdesc = "Эта биографическая справка содержит различные даты работы ученого в разных компаниях, большинстве институтов Украины. Вы можете сказать, что большинство из них очень старые, последние были незадолго до распада Советского Союза."
ITEM.model = "models/lostsignalproject/items/quest/notes_photo.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 2500

ITEM.flatweight = 0.150

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 19.607843399048),
	ang = Angle(90, 180, 0),
	fov = 30,
}

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Документ", Color(200, 200, 200))
		end
	end
end