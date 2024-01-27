AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_combine/combine_intwallunit.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS ) 
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(false)
	end
end

util.AddNetworkString("ixATM_OpenMenu")
function ENT:Use(activator, caller)
	if IsValid(activator) and activator:IsPlayer() then
		if (activator.ATMInteractCooldown or 0) > CurTime() then return end
		self:EmitSound("ambient/levels/citadel/pod_open1.wav", 75)

		net.Start("ixATM_OpenMenu")
			net.WriteString(tostring(activator:GetCharacter():GetData("bATM_Money", "0")))
		net.Send(activator)

		activator.ATMInteractCooldown = CurTime() + 5
	end
end

util.AddNetworkString("ixATM_Deposit")
net.Receive("ixATM_Deposit", function(_, pl)
	if IsValid(pl) and pl:IsPlayer() then
		if pl:GetCharacter() then
			local _number = net.ReadUInt(32)
			if tostring(_number):find("+") or tostring(_number):find("-") then return end
			for k, v in pairs(ents.FindInSphere(pl:GetPos(), 250)) do
				if v:GetClass() == "ix_atm" then
					if tonumber(_number) > tonumber(pl:GetCharacter():GetMoney()) then return end
					ix.ATM:DepositMoney(pl, _number)
					ix.util.Notify("Вы внесли ".._number.." злотых в свой банковский счёт", pl)
				end
			end
		end
	end
end)

util.AddNetworkString("ixATM_Withdraw")
net.Receive("ixATM_Withdraw", function(_, pl)
	if IsValid(pl) and pl:IsPlayer() then
		if pl:GetCharacter() then
			local _number = net.ReadUInt(32)
			if tostring(_number):find("+") or tostring(_number):find("-") then return end
			for k, v in pairs(ents.FindInSphere(pl:GetPos(), 250)) do
				if v:GetClass() == "ix_atm" then
					if tonumber(_number) > tonumber(ix.ATM:GetMoney(pl)) then return end
					ix.ATM:WithdrawMoney(pl, _number)
					ix.util.Notify("Вы сняли ".._number.." злотых со своего банковского счёта", pl)
				end
			end
		end
	end
end)

util.AddNetworkString("ixATM_UpdatePage")
net.Receive("ixATM_UpdatePage", function(_, pl)
	net.Start("ixATM_OpenMenu")
		net.WriteString(tostring( pl:GetCharacter():GetData("bATM_Money", "0") ))
	net.Send(pl)
end)