-- print("Crystal Vision Tracker - Config loading...")

-- Setup the CVT variables table with default values if it doesn't exist
CVT = CVT or {}
CVT.poison = CVT.poison or {}
CVT.poison.enabled = CVT.poison.enabled or true
CVT.poison.mouseover = CVT.poison.mouseover or false

-- Create the options panel frame
local optionsPanel = CreateFrame("Frame", "CrystalVisionTrackerConfig", UIParent)
optionsPanel.name = "CVT - Crystal Vision Tracker"

-- Register the options panel with the game's interface options
if InterfaceOptions_AddCategory then
    InterfaceOptions_AddCategory(optionsPanel)
else
    local category, layout = Settings.RegisterCanvasLayoutCategory(optionsPanel, optionsPanel.name);
    Settings.RegisterAddOnCategory(category);
end

-- Set up a description label
local description = optionsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
description:SetText("Crystal Vision Tracker Options")
description:SetPoint("TOPLEFT", 20, -20)

-- Add an option for enabling/disabling the poison checking feature
local enableCheckButton = CreateFrame("CheckButton", nil, optionsPanel, "InterfaceOptionsCheckButtonTemplate")
enableCheckButton:SetPoint("TOPLEFT", description, "BOTTOMLEFT", 0, -20)
enableCheckButton.Text:SetText("Enable poison checking")
enableCheckButton.tooltip = "Enable events for checking poison vial."
enableCheckButton:SetChecked(CVT.poison.enabled)

-- Add an option for enabling/disabling mouseover poison checking
local mouseoverCheckButton = CreateFrame("CheckButton", nil, optionsPanel, "InterfaceOptionsCheckButtonTemplate")
mouseoverCheckButton:SetPoint("TOPLEFT", enableCheckButton, "BOTTOMLEFT", 0, -10)
mouseoverCheckButton.Text:SetText("Enable mouseover poison checking")
mouseoverCheckButton.tooltip = "Enable poison checking when hovering over units. If disabled, poison checking will only occur when the player left clicks on a unit."
mouseoverCheckButton:SetChecked(CVT.poison.mouseover)


enableCheckButton:SetScript("OnClick", function(self)
    CVT.poison.enabled = self:GetChecked()
    if CVT.poison.enabled then
        print("Poison checking enabled.")
        mouseoverCheckButton:Enable()
    else
        print("Poison checking disabled.")
        mouseoverCheckButton:Disable()
        print("Mouseover poison checking disabled.")
    end
end)

mouseoverCheckButton:SetScript("OnClick", function(self)
    CVT.poison.mouseover = self:GetChecked()
end)

-- print("Crystal Vision Tracker - Config loaded successfully.")