ITEM.name = "Документы по исследованию болот"
ITEM.description = "Файл, содержащий исследовательские документы об аномальных частях болот."
ITEM.longdesc = "Этот файл содержит несколько довольно обширных исследовательских документов, касающихся некоторых частей болот. Наверняка найдется кто-нибудь, готовый заплатить за них совсем немного."
ITEM.model = "models/lostsignalproject/items/quest/document_03.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 3560

ITEM.flatweight = 0.650

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