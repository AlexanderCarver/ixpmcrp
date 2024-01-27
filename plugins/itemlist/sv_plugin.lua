util.AddNetworkString('MenuItemSpawn')
util.AddNetworkString('MenuItemGive')

local function check(client)
	return client:IsSuperAdmin() or client:GetCharacter():HasFlags("c")
end

net.Receive('MenuItemSpawn', function(len, client)
	local uniqueID = net.ReadString()
	
	if not isstring(uniqueID) then return end
	if not check(client) then return end
	
	if (ix.item.list[uniqueID]) then
		local vStart = client:GetShootPos()
		local trace = {}

		trace.start = vStart
		trace.endpos = vStart + (client:GetAimVector() * 2048)
		trace.filter = client

		local tr = util.TraceLine(trace)
		local ang = client:EyeAngles()
		ang.yaw = ang.yaw + 180
		ang.roll = 0
		ang.pitch = 0
		
		ix.item.Spawn(uniqueID, tr.HitPos, function(item)
			client:Notify("Вы создали " .. item.name .. ".")
		end, ang)
	end
end)

net.Receive('MenuItemGive', function(len, client)
	local uniqueID = net.ReadString()
	
	if not isstring(uniqueID) then return end
	if not check(client) then return end
	
	local item_object = ix.item.list[uniqueID]
	if (item_object) then
		local result, message = client:GetCharacter():GetInventory():Add(uniqueID)
		if (!result) then
			client:NotifyLocalized(message)
		else
			client:Notify("Вы выдали "..client:Name().." следующий предмет: " .. item_object.name .. ".")
		end
	end
	
	item_object = nil
end)