local PANEL = {}

function PANEL:Init()
    self:SetSize( ScrW()*.5, ScrH()*.7 )
    self:Center()
    self:MakePopup()
    self:SetTitle( "" )

    self:SetSizable( false )
    self:SetDraggable( false )
    self:ShowCloseButton( false )

    self:SetAlpha( 0 )
    self:AlphaTo( 255, 0.5, 0, function()
        if ( self.CloseButton or false ) then
            self.CloseButton:AlphaTo( 255, 1 )
        end
    end )

    self.Paint = function(self, w, h)
        ix.util.DrawBlur( self )

        surface.SetDrawColor( 0, 0, 0, 200 )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( 155, 155, 155, 255 )
        surface.DrawOutlinedRect( 0, 0, w, h )
    end

    local WSize, HSize = self:GetSize()
    self.CloseButton = self:Add( "DButton" )
    self.CloseButton:SetSize( WSize*.3, HSize*.05 )
    self.CloseButton:SetPos( WSize*.36, HSize*.92 )
    self.CloseButton:SetFont( "ixComputer.ButtonsFont" )
    self.CloseButton:SetTextColor( Color( 200, 200, 200, 255 ) )
    self.CloseButton:SetText( "Выключить" )
    self.CloseButton:SetAlpha( 0 )

    self.CloseButton.DoClick = function()
        surface.PlaySound( "buttons/button1.wav" )
        self:AlphaTo( 0, 0.5, 0, function()
            self:Remove()
        end )
    end

    self.CloseButton.Paint = function(self, w, h)
        if self:IsHovered() then
            self:SetTextColor( Color( 255, 255, 255, 255 ) )
            surface.SetDrawColor( 255, 155, 155, 255 )
        else
            self:SetTextColor( Color( 200, 200, 200, 255 ) )
            surface.SetDrawColor( 155, 155, 155, 255 )
        end

        surface.DrawOutlinedRect( 0, 0, w, h )
    end

    self.NotesPanel = self:Add( "DPanel" )
    self.NotesPanel:DockMargin( 10, 20, 35, 60 )
    self.NotesPanel:SetSize( WSize*.49, HSize*.04 )
    self.NotesPanel:Dock( LEFT )

    self.ScrollNotes = self.NotesPanel:Add( "DScrollPanel" )
    self.ScrollNotes:Dock( FILL )

    self.CreateNote = self.ScrollNotes:Add( "DButton" )
    self.CreateNote:SetFont( "ixComputer.ButtonsFont" )
    self.CreateNote:SetText( "Гражданский Кодекс" )
    self.CreateNote:SetSize( WSize*.3, HSize*.05 )
    self.CreateNote:Dock( TOP )
    self.CreateNote:DockMargin( 0, 0, 0, 3 )

    self.CreateNote.DoClick = function()
        Derma_Message(ix.Computer.Notes["Гражданский Кодекс"], "Памятка", "OK")
    end

    -- Commands
    self.CommandsPanel = self:Add( "DPanel" )
    self.CommandsPanel:DockMargin( 10, 20, 15, 60 )
    self.CommandsPanel:SetSize( WSize*.46, HSize*.04 )
    self.CommandsPanel:Dock( RIGHT )

    self.ToggleJW = self.CommandsPanel:Add( "DButton" )
    self.ToggleJW:SetFont( "ixComputer.ButtonsFont" )
    self.ToggleJW:SetText( "Активировать JW" )
    self.ToggleJW:SetSize( WSize*.3, HSize*.05 )
    self.ToggleJW:Dock( TOP )
    self.ToggleJW:DockMargin( 0, 0, 0, 3 )
    self.ToggleJW.DoClick = function()
        surface.PlaySound( "buttons/button1.wav" )
    end

    self.ToggleAJ = self.CommandsPanel:Add( "DButton" )
    self.ToggleAJ:SetFont( "ixComputer.ButtonsFont" )
    self.ToggleAJ:SetText( "Активировать AJ" )
    self.ToggleAJ:SetSize( WSize*.3, HSize*.05 )
    self.ToggleAJ:Dock( TOP )
    self.ToggleAJ:DockMargin( 0, 0, 0, 3 )
    self.ToggleAJ.DoClick = function()
        surface.PlaySound( "buttons/button1.wav" )
    end
end

vgui.Register( "ixComputerPanel", PANEL, "DFrame" )