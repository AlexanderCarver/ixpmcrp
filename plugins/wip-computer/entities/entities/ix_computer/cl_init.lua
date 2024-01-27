
include( "shared.lua" )

function ENT:Draw()
	self:DrawModel()
end

net.Receive( "ixComputer::SendNet", function(_)
	vgui.Create( "ixComputerPanel" )
end )