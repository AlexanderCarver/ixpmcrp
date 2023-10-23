ITEM.name = "Советский Справочник по оружию"
ITEM.description = "Классическое руководство по стрельбе из огнестрельного оружия. Довольно изношенный."
ITEM.longdesc = "Это руководство по оружию содержит руководство для советских призывников о том, как правильно стрелять из своего оружия. Необходимо прочитать, прежде чем проходить какую-либо реальную подготовку по огнестрельному оружию."
ITEM.model = "models/lostsignalproject/items/misc/book1.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 2010

ITEM.flatweight = 0.400

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