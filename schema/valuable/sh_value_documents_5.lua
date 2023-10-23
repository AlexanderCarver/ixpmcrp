ITEM.name = "Нарисованная от руки Карта Аномалий"
ITEM.description = "Наспех нарисованная и промокшая карта аномалий."
ITEM.longdesc = "Нарисованная от руки карта с подробным описанием местоположения аномалий и характера их миграции в неопределенной области. Это может быть полезно для тех, кто изучает позиции аномалий."
ITEM.model = "models/lostsignalproject/items/quest/notes_paper_1.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1200

ITEM.flatweight = 0.180

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