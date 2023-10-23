ITEM.name = "Карта доступа"
ITEM.description = "Небольшая пластиковая карта с потёртой надписью 'ЖЕЛЕЗНАЯ ДОРОГА'."
ITEM.longdesc = "Эта маленькая, тонкая карта предназначена для открытия множества дверей. Значок в левом верхнем углу стёрт и его невозможно разобрать."
ITEM.model = "models/lostsignalproject/items/quest/keycard.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0
ITEM.weight = 0.01

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 8),
	ang = Angle(90, 90, 0),
	fov = 45,
}

function ITEM:GetDescription()
    local quant = self:GetData("quantity", self.ammoAmount or self.quantity or 0)
    local quantdesc = ""
    local invdesc = ""

    if self.longdesc then
        invdesc = "\n\n" .. (self.longdesc)
    end

    if self.quantdesc then
        quantdesc = "\n\n" .. Format(self.quantdesc, quant)
    end

    if (self.entity) then
        return (self.description)
    else
        return (self.description .. quantdesc .. invdesc)
    end
end

ITEM.functions.usetarget = {
	name = "Использовать",
	icon = "icon16/stalker/unlock.png",
	OnRun = function(item)
		local data = {}
			data.start = item.player:GetShootPos()
			data.endpos = data.start + item.player:GetAimVector()*96
			data.filter = item.player
		local target = util.TraceLine(data).Entity
        
		if (IsValid(target) and target:GetClass() == "func_door_rotating") and target:GetName() == "gate_a_button" then
			ix.chat.Send(item.player, "iteminternal", "достает карту доступа и проводит через старенькую, еще заставшую советские времена, систему своеобразного СКУД'а. Дверь со скрипом и грохотом открывается. Кажется, комплекс не был обесточен.", false)

            target:Input("Unlock")
            target:Input("Open")
            timer.Simple(15, function()
                target:Input("Close")
                target:Input("Lock")
            end)
		else
			item.player:Notify("Ваша попытка не возымела какого-либо эффекта.")
		end

		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}
