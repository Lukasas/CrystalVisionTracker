
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
CVT_vialCheckButtonFrame = CreateFrame("CheckButton", nil, optionsPanel, "InterfaceOptionsCheckButtonTemplate")
CVT_vialCheckButtonFrame:SetPoint("TOPLEFT", description, "BOTTOMLEFT", 0, -16)
CVT_vialCheckButtonFrame.Text:SetText("Enable poison checking")
CVT_vialCheckButtonFrame.tooltip = "Enable events for checking poison vial."
CVT_vialCheckButtonFrame:SetChecked(true) -- Default to enabled

-- Add an option for enabling/disabling mouseover poison checking
CVT_vialMouseoverCheckButtonFrame = CreateFrame("CheckButton", nil, optionsPanel, "InterfaceOptionsCheckButtonTemplate")
CVT_vialMouseoverCheckButtonFrame:SetPoint("TOPLEFT", CVT_vialCheckButtonFrame, "BOTTOMLEFT", 10, -16)
CVT_vialMouseoverCheckButtonFrame.Text:SetText("Enable mouseover poison checking")
CVT_vialMouseoverCheckButtonFrame.tooltip = "Enable poison checking when hovering over units. If disabled, poison checking will only occur when the player left clicks on a unit."
CVT_vialMouseoverCheckButtonFrame:SetChecked(false) -- Default to disabled


CVT_vialCheckButtonFrame:SetScript("OnClick", function(self)
    CVT.poison.enabled = self:GetChecked()
    if CVT.poison.enabled then
        -- print("Poison checking enabled.")
        CVT_vialMouseoverCheckButtonFrame:Enable()
    else
        -- print("Poison checking disabled.")
        CVT_vialMouseoverCheckButtonFrame:Disable()
        -- print("Mouseover poison checking disabled.")
    end
end)

CVT_vialMouseoverCheckButtonFrame:SetScript("OnClick", function(self)
    CVT.poison.mouseover = self:GetChecked()
end)

print("Crystal Vision Tracker - Config loaded successfully.")