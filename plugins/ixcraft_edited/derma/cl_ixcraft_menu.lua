
local PLUGIN = PLUGIN

local animationTime = 1
DEFINE_BASECLASS("DFrame")
local PANEL = {}

function PANEL:Init()
-- frame:SetSize(800,550)

	self:SetSize(250,400)
	self:Center()
	self:MakePopup()

	self:SetTitle("")


	local ScrollBG = vgui.Create( "DScrollPanel", self )
	ScrollBG:Dock( FILL )
	ScrollBG:DockMargin(5,5,5,5)
	-- ScrollBG.Paint = function(s,w,h)


	-- 	surface.SetDrawColor( 40,40,40,200 )
 --  		surface.DrawRect(0,0,w,h)

 --  	end

  	self.ScrollBG = ScrollBG

end


function PANEL:Populate(stationID, ent)

	self.ent = ent or nil

	local recipes = PLUGIN.craft.recipes
	for uniqueID, recipeTable in SortedPairsByMemberValue(recipes, "name") do
		if (recipeTable:OnCanSee(LocalPlayer()) == false) then
			continue
		end

		if (recipeTable.workbench != stationID) then
			continue
		end	

		local ItemBG = self.ScrollBG:Add( "DButton" )
		ItemBG:Dock( TOP )
		ItemBG:DockMargin( 0, 0, 0, 5 )
		ItemBG:SetSize(100,90)
		ItemBG:SetText("")
		ItemBG.recipeTable = recipeTable
		ItemBG.Paint = function(s,w,h)

		if (s:IsHovered()) then
		surface.SetDrawColor( 0,0,0,150 )
		else
			surface.SetDrawColor( 0,0,0,100 )
		end	
  		surface.DrawRect(0,0,w,h)

  		draw.SimpleTextOutlined(recipeTable.GetName and recipeTable:GetName() or L(recipeTable.name), "Trebuchet24", w/2 + 40, h/2, Color( 250, 250, 250 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 20,20,20 ))

  		end
  		ItemBG.DoClick = function(s)
			surface.PlaySound( "ui/buttonclickrelease.wav")
			if (s.recipeTable) then
				net.Start("ixCraftRecipe")
					net.WriteString(s.recipeTable.uniqueID)
				net.SendToServer()
			end
		end
  		ItemBG:SetHelixTooltip(function(tooltip)
			PLUGIN:PopulateRecipeTooltip(tooltip, recipeTable)
		end)



  		self.icon = ItemBG:Add("SpawnIcon")
		self.icon:InvalidateLayout(true)
		self.icon:Dock(LEFT)
		self.icon:DockMargin(0, 0, 8, 0)
		self.icon:SetSize(100,100)
		self.icon:SetMouseInputEnabled(false)
		self.icon:SetModel(recipeTable:GetModel(), recipeTable:GetSkin())
		self.icon.PaintOver = function(this) end
	end

	if (table.Count(recipes) > 5) then
		self.ScrollBG:DockMargin(5,5,0,5)
	end	

end

function PANEL:Close()
	if (self.bClosing) then
		return
	end

	self.bClosing = true

	if (self.ent) then
		netstream.Start("ix_craft_ReleaseWorkBench", self.ent)
	end

	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
	BaseClass.Close(self)

end


vgui.Register("ix_crafting_entMenu", PANEL, "DFrame")

