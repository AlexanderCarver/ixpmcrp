ITEM.name = "Нацарапанные Научные Заметки"
ITEM.description = "Небольшой документ, содержащий несколько научных каракулей."
ITEM.longdesc = "В документе плохим почерком описано какое-то аномальное событие, связанное с зоной, но вы сами не можете его понять, отчасти из-за почерка."
ITEM.model = "models/lostsignalproject/items/quest/notes_paper_2.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 2100

ITEM.flatweight = 0.120

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