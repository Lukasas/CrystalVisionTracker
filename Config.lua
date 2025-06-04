print("Crystal Vision Tracker - Config loadindg...")
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
description:SetText("TODO Config Options")
description:SetPoint("TOPLEFT", 16, -16)

-- Add an option for enabling/disabling the poison checking feature
local enableCheckButton = CreateFrame("CheckButton", nil, optionsPanel, "InterfaceOptionsCheckButtonTemplate")
enableCheckButton:SetPoint("TOPLEFT", description, "BOTTOMLEFT", 0, -16)
enableCheckButton.Text:SetText("Enable poison checking")
enableCheckButton.tooltip = "Enable events for checking poison vial."
enableCheckButton:SetChecked(EnablePoisonVialCheck or true)

-- Add an option for enabling/disabling mouseover poison checking
local mouseoverCheckButton = CreateFrame("CheckButton", nil, optionsPanel, "InterfaceOptionsCheckButtonTemplate")
mouseoverCheckButton:SetPoint("TOPLEFT", enableCheckButton, "BOTTOMLEFT", 0, -8)
mouseoverCheckButton.Text:SetText("Enable mouseover poison checking")
mouseoverCheckButton.tooltip = "Enable poison checking when hovering over units. If disabled, poison checking will only occur when the player left clicks on a unit."
mouseoverCheckButton:SetChecked(PoisonVialCheckMouseover or false)


enableCheckButton:SetScript("OnClick", function(self)
    EnablePoisonVialCheck = self:GetChecked()
    if EnablePoisonVialCheck then
        print("Poison checking enabled.")
        mouseoverCheckButton:Enable()
        print("Mouseover poison config reenabled.")
    else
        print("Poison checking disabled.")
        mouseoverCheckButton:Disable()
        print("Mouseover poison checking disabled.")
    end
end)

mouseoverCheckButton:SetScript("OnClick", function(self)
    PoisonVialCheckMouseover = self:GetChecked()
end)

print("Crystal Vision Tracker - Config loaded successfully.")