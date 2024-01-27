include("shared.lua")

surface.CreateFont("ix_ATM_Font_18", {
	font = "Roboto",
	extended = true,
	size = 18,
	weight = 64,
	antialias = true
})

surface.CreateFont("ix_ATM_Font_20", {
	font = "Roboto Bold",
	extended = true,
	size = 20,
	weight = 64,
	antialias = true,
	bold = true
})

function ENT:Draw()
	self:DrawModel()
	local position, angles = self:GetPos(), self:GetAngles()
	local Glow = Material("sprites/glow04_noz")

	angles:RotateAroundAxis(angles:Forward(), 90)
	angles:RotateAroundAxis(angles:Right(), 270)

	cam.Start3D( EyePos(), EyeAngles() )
		render.SetMaterial( Glow )
		render.DrawSprite( self:GetPos() + self:GetForward() * 4 + self:GetRight() * 8.2 + self:GetUp() * 11, 10, 10, Color(0, 150, 255, math.abs(math.cos(RealTime() * 1.8) * 255) ) )
		render.DrawSprite( self:GetPos() + self:GetForward() * 4 + self:GetRight() * 8.2 + self:GetUp() * 5.6, 10, 10, Color(0, 150, 255, math.abs(math.cos(RealTime() * 1.9) * 255) ) )
		render.DrawSprite( self:GetPos() + self:GetForward() * 4 + self:GetRight() * 8.2 + self:GetUp() * -0.7, 10, 10, Color(0, 150, 255, math.abs(math.cos(RealTime() * 2) * 255) ) )
		render.DrawSprite( self:GetPos() + self:GetForward() * 4 + self:GetRight() * 8.2 + self:GetUp() * -6.4, 10, 10, Color(0, 150, 255, math.abs(math.cos(RealTime() * 2.1) * 255) ) )
	cam.End3D()
end

-- Colors
local white = Color(255, 255, 255, 255)

net.Receive("ixATM_OpenMenu", function(_)
	if !IsValid(ATM_MENU) then
		local ATM_MENU = vgui.Create("DFrame")
		ATM_MENU:SetTitle("Банкомат")
		ATM_MENU:SetSize(200, 150)
		ATM_MENU:Center()
		ATM_MENU:MakePopup()
		ATM_MENU:SetSizable(false)
		ATM_MENU:SetDraggable(false)
		ATM_MENU:ShowCloseButton(true)

		local ATM_INFO = vgui.Create( "DLabel", ATM_MENU )
		ATM_INFO:SetPos( 10, 30 )
		ATM_INFO:SetColor( white )
		ATM_INFO:SetFont( "ix_ATM_Font_18" )
		ATM_INFO:SetText( "Баланс: "..net.ReadString()..ix.currency.symbol)
		ATM_INFO:SizeToContents()

		local ATM_WITHDRAW_ENTRY = vgui.Create( "DTextEntry", ATM_MENU )
		ATM_WITHDRAW_ENTRY:SetPos( 10, 50 )
		ATM_WITHDRAW_ENTRY:SetSize( 180, 20 )
		ATM_WITHDRAW_ENTRY:SetFont( "ix_ATM_Font_20" )
		ATM_WITHDRAW_ENTRY:SetNumeric( true )

		local ATM_WITHDRAW = vgui.Create( "DButton", ATM_MENU )
		ATM_WITHDRAW:SetPos( 10, 70 )
		ATM_WITHDRAW:SetSize( 180, 20 )
		ATM_WITHDRAW:SetColor( white )
		ATM_WITHDRAW:SetFont( "ix_ATM_Font_18" )
		ATM_WITHDRAW:SetText( "Снять" )
		ATM_WITHDRAW.DoClick = function()
			local _number = ATM_WITHDRAW_ENTRY:GetValue()
			if _number == "" then return end

			if not _number then return end

			if _number:find("+") or _number:find("-") then return end
			if !isnumber(tonumber(_number)) then return end

			net.Start("ixATM_Withdraw")
				net.WriteUInt(math.floor(_number), 32)
			net.SendToServer()

			ATM_MENU:Remove()

			net.Start("ixATM_UpdatePage")
			net.SendToServer()
		end

		local ATM_DEPOSIT_ENTRY = vgui.Create( "DTextEntry", ATM_MENU )
		ATM_DEPOSIT_ENTRY:SetPos( 10, 100 )
		ATM_DEPOSIT_ENTRY:SetSize( 180, 20 )
		ATM_DEPOSIT_ENTRY:SetFont( "ix_ATM_Font_20" )
		ATM_DEPOSIT_ENTRY:SetNumeric( true )

		local ATM_DEPOSIT = vgui.Create( "DButton", ATM_MENU )
		ATM_DEPOSIT:SetPos( 10, 120 )
		ATM_DEPOSIT:SetSize( 180, 20 )
		ATM_DEPOSIT:SetColor( white )
		ATM_DEPOSIT:SetFont( "ix_ATM_Font_18" )
		ATM_DEPOSIT:SetText( "Внести" )
		ATM_DEPOSIT.DoClick = function()
			local _number = ATM_DEPOSIT_ENTRY:GetValue()
			if _number == "" then return end

			if not _number then return end

			if _number:find("+") or _number:find("-") then return end
			if !isnumber(tonumber(_number)) then return end

			net.Start("ixATM_Deposit")
				net.WriteUInt(math.floor(_number), 32)
			net.SendToServer()

			ATM_MENU:Remove()

			net.Start("ixATM_UpdatePage")
			net.SendToServer()
		end
	end
end)