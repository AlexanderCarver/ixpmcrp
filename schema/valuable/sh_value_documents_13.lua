ITEM.name = "Производство зубчатых колес"
ITEM.description = "Заводское руководство по созданию зубчатых колес."
ITEM.longdesc = "Совершенно новое руководство для заводских рабочих о том, как создавать различные типы зубчатых колес, от начала производства до конечного продукта."
ITEM.model = "models/lostsignalproject/items/misc/book2.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 3500

ITEM.flatweight = 0.410

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, -0.5, 200),
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