ITEM.name = "Инструкция по пошиву кевлара"
ITEM.description = "Руководство для опытных изготовителей бронежилетов о том, как правильно ремонтировать и шить из кевлара."
ITEM.longdesc = "Это руководство охватывает основы ремонта бронежилетов, пришивания к ним приспособлений и в целом просто изготовления бронежилетов снизу вверх."
ITEM.model = "models/lostsignalproject/items/misc/book3.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 2750

ITEM.flatweight = 0.395

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