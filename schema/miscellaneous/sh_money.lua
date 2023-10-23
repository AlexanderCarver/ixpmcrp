ITEM.name = "Деньги"
ITEM.description = "Пачка долларов. Вечно зеленые, вечно ценные."
ITEM.longdesc = "Чёрная экономика внутри Территории существует на основе американской валюты - на основе доллара США, что обсусловлено контактами с чёрным рынком СНГ, сеть которого здесь нашла настоящую золотую жилу."
ITEM.quantdesc = "Здесь %d долларов."
ITEM.model = "models/illusion/eftcontainers/dollar.mdl"

ITEM.width = 1
ITEM.height = 1

ITEM.quantity = 100000
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 2.5,
}

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(item:GetData("quantity", 1), "DermaDefault", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

ITEM.functions.use = {
	name = "Положить в кошелёк",
	icon = "icon16/stalker/sell.png",
	sound = "stalkersound/money_1.mp3",
	OnRun = function(item)
		local position = item.player:GetItemDropPos()
		local client = item.player
		local quant = item:GetData("quantity", 0)
		client:GetCharacter():GiveMoney(quant)
		ix.chat.Send(item.player, "iteminternal", "крайне педантично пересчитывает деньги и, достав свой кошелек, убирает их в него.", false)
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

function ITEM:GetDescription()
	local quant = self:GetData("quantity", self.quantity or self.quantity or 0)
	local quantdesc = ""
	local invdesc = ""
	if self.longdesc then
		invdesc = "\n\n"..(self.longdesc)
	end

	if self.quantdesc then
		quantdesc = "\n\n"..Format(self.quantdesc, quant)
	end

	if (self.entity) then
		return (self.description..quantdesc)
	else
        return (self.description..quantdesc..invdesc)
	end
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if !data then
			return false
		end

		local targetItem = ix.item.instances[data[1]]

		if targetItem.ammo == item.ammo then
			return true
		else
			return false
		end
	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		local targetAmmoDiff = targetItem.quantity - targetItem:GetData("quantity", targetItem.quantity)
		local localQuant = item:GetData("quantity", item.quantity)
		local targetQuant = targetItem:GetData("quantity", targetItem.quantity)
		item.player:EmitSound("stalkersound/inv_properties.mp3", 110)
		if targetAmmoDiff >= localQuant then
			targetItem:SetData("quantity", targetQuant + localQuant)
			return true
		else
			item:SetData("quantity", localQuant - targetAmmoDiff)
			targetItem:SetData("quantity", targetItem.quantity)
			return false
		end
	end,
}