--- TODO MASKS
--- iii = C_UnitAuras.GetDebuffDataByIndex("player", 1)
--- aid = iii['auraInstanceID']
--- print(aid)
--- print(C_TooltipInfo.GetUnitDebuffByAuraInstanceID("player", aid)['lines'][2]['leftText']) -- once in, not needed to refresh
---------------- Constants ----------------
local MAX_PICKING_DISTANCE = 0.8

-- local SW_FULL_LOC = {'Cathedral Square', 'Dwarven District', 'Old Town', 'Trade District', 'Mage Quarter'}
-- local STORMWIND_LOCATIONS = { 'CATHEDRAL', 'DWARVEN', 'OLD TOWN', 'TRADE', 'MAGE'}
local STORMWIND_POS = {
	{1, {54.6, 59.4}},
	{1, {53.0, 51.9}},
	{1, {58.4, 55.1}},
	{2, {64.6, 30.9}},
	{2, {62.7, 37.0}},
	{2, {63.4, 41.7}},
	{2, {67.3, 44.7}},
	{3, {75.6, 53.4}},
	{3, {75.6, 64.6}},
	{3, {74.6, 59.2}},
	{3, {76.5, 68.5}},
	{4, {69.0, 73.1}},
	{4, {62.0, 76.9}},
	{4, {66.1, 75.7}},
	{4, {60.4, 68.8}},
	{5, {47.4, 81.6}},
	{5, {44.2, 87.9}},
	{5, {47.7, 89.4}},
	{5, {52.4, 83.4}}
}

local STORMWIND_BOUNDRIES = {
	{ {42.4, 50.1}, {48, 63}, {50.7, 62.6}, {53.2, 61.2}, {55.0, 62.7}, {61.1, 55.1}, {59.6, 50.9}, {53.0, 38.1} },
	{ {57.5, 35.1}, {65.5, 50.7}, {72.4, 43.2}, {64.0, 25.0} },
	{ {74.6, 49.7}, {67.1, 58.3}, {75.7, 73.9}, {81.6, 67.0}, {81.6, 58.8} },
	{ {71.4, 73.3}, {63.5, 61.4}, {56.4, 68.2}, {62.8, 84.2} },
	{ {58.1, 83.3}, {53.0, 71.8}, {50.8, 74.1}, {47.5, 72.9}, {38.8, 79.2}, {47.1, 98.8} }
}

local STORMWIND_POISON_POS = {
	{ 51.75, 58.52 }
}

-- local OG_FULL_LOC = {'Valley of Strength', 'Valley of Spirits', 'Valley of Wisdom', 'The Drag', 'Valley of Honor'}
-- local ORGRIMMAR_LOCATIONS = { 'VSTRENGTH', 'SPIRITS', 'WISDOM', 'DRAG', 'HONOR'}
local ORGRIMMAR_POS = {
	{1, {53.5, 82.0}},
	{1, {49.4, 68.7}},
	{1, {48.7, 83.8}},
	{2, {33.4, 65.7}},
	{2, {35.4, 69.4}},
	{2, {37.9, 84.5}},
	{2, {38.5, 80.7}},
	{3, {38.9, 49.9}},
	{3, {41.7, 44.8}},
	{3, {48.4, 44.1}},
	{3, {51.0, 45.2}},
	{4, {57.7, 65.1}},
	{4, {57.6, 58.6}},
	{4, {60.4, 55.1}},
	{4, {57.9, 48.6}},
	{5, {65.8, 50.6}},
	{5, {68.2, 42.9}},
	{5, {67.0, 37.4}},
	{5, {63.9, 30.4}}
}

local ORGRIMMAR_BOUNDRIES = {
	{ {43.2, 66.6}, {44.4, 87.2}, {57.0, 84.6}, {52.8, 67.4}, {50.2, 62.2} },
	{ {21.8, 63.2}, {37.4, 89.0}, {42.4, 78.8}, {33.8, 54.2} },
	{ {36.0, 40.0}, {36.4, 58.6}, {49.8, 57.0}, {51.5, 50.7}, {57.5, 42.1} },
	{ {51.2, 61.6}, {53.8, 67.0}, {58.1, 72.0}, {66.0, 58.4}, {58.8, 42.0}, {52.5, 50.7} },
	{ {59.2, 26.0}, {60.4, 43.4}, {67.4, 57.4}, {84.4, 40.0}, {72.6, 24.0} },
}

local VIAL_VAL_STRINGS = {
	"Click the Poison",
	"Poison",
	"Sanity",
	"Defensive",
	"Healing",
	"Fire Breath"
}

local TEXT_COLORS = {
	{255, 0, 0}, -- 0
	{200, 78, 8}, -- 1
	{0, 255, 0} -- 2
}

local VIAL_COLORS = {
	{0.8, 0.8, 0.8}, -- black
	{0.2, 0.9, 0.2}, -- green
	{0.9, 0.2, 0.2}, -- red
	{0.2, 0.2, 0.9}, -- blue
	{0.7, 0.2, 0.9} -- purple
}

local SIZES = {
	0.9, -- In different
	1, -- In none
	1.1 -- In
}
local CVT_TXT_FRAMES = nil
local CVT_TXT_VALS_FRAMES = nil
local CVT_VIAL_TXT_FRAMES = nil
local CVT_VIAL_TXT_VALS_FRAMES = nil
local CVT_VIAL_TXT_VALS_BTNS = nil

---------------- Globals  ----------------

local CRYSTALS = {0, 0, 0, 0, 0}
local CHESTS = {0, 0, 0, 0, 0}
local CHESTS_IN_ZONE = {3, 2, 2, 2, 2}
local ZONE = 'SW'

local VIAL_SET = false
local CAN_CHECK_VIAL = false

local movable = false
SLASH_CSW1 = "/csw"
SLASH_COG1 = "/cog"
SLASH_CHIDE1 = "/chide"
SLASH_CTFIRE1 = "/ctfire"
SLASH_CMOVE1 = "/cmove"
SLASH_CHELP1 = "/chelp"
SLASH_CTINTER1 = "/ctint"
SLASH_CTLOC1 = "/ctloc"
SLASH_CVRST1 = "/cvrst"

---------------- Timers ----------------


---------------- Localisation helpers ----------------

-- Returns a localised string for the given key, or the key itself if not found
local function LocaliseString(key)
    return CVT['transl'][key] or key
end

local function GetStormwindLocations()
    return {
        LocaliseString("Cathedral Square"),
        LocaliseString("Dwarven District"),
        LocaliseString("Old Town"),
        LocaliseString("Trade District"),
        LocaliseString("Mage Quarter"),
    }
end

local function GetOrgrimmarLocations()
    return {
        LocaliseString("Valley of Strength"),
        LocaliseString("Valley of Spirits"),
        LocaliseString("Valley of Wisdom"),
        LocaliseString("The Drag"),
        LocaliseString("Valley of Honor"),
    }
end

local function GetVials()
	return {
		LocaliseString("Vial of Mysterious Black Liquid"),
		LocaliseString("Vial of Mysterious Green Liquid"),
		LocaliseString("Vial of Mysterious Red Liquid"),
		LocaliseString("Vial of Mysterious Blue Liquid"),
		LocaliseString("Vial of Mysterious Purple Liquid")
	}
end

---------------- Addon Functions ----------------

local function IsPointInPolygon(poly, pointX, pointY)
	local x, y = pointX, pointY
	local j = table.getn(poly)
	local oddNodes = false
	for i=1,table.getn(poly) do
		if (poly[i][2] < y and poly[j][2] >= y or poly[j][2] < y and poly[i][2] >= y) then
			if (poly[i][1] + (y - poly[i][2]) / (poly[j][2]-poly[i][2])*(poly[j][1]-poly[i][1]) < x) then
				oddNodes = oddNodes == false
			end
		end
		j=i;
	end
	return oddNodes
end


local function IsRunning()
	return CVT_Frame:GetAlpha() == 1
end

local function GetPlayerPosition()
	local map = C_Map.GetBestMapForUnit("player")
	if not map then
		return 0, 0
	end

	local position = C_Map.GetPlayerMapPosition(map, "player")

	if not position then
		return 0, 0
	end

	local x, y = position:GetXY()
	x = x * 100
	y = y * 100
	return x, y
end

local function transformCoordsSW(pX, pY)
	local x, y = pX, pY
	local dist = sqrt((x*x) + (y*y))
	local alpha = (y / dist * 180) / 3.14
	alpha = alpha + 33.7

	local xx = cos(alpha) * dist
	local yy = sin(alpha) * dist

	return xx, yy
 end


local function distanceFromCrystal(crystal)
	local pX, pY = GetPlayerPosition()
	local cX, cY = crystal[1], crystal[2]
	local dX, dY = pX - cX, pY - cY

	local dist = sqrt((dX*dX) + (dY*dY))
	return dist
end

local function CountPickedCrystal()
	local bounds = nil
	if ZONE == 'SW' then
		bounds = STORMWIND_BOUNDRIES
	else
		bounds = ORGRIMMAR_BOUNDRIES
	end

	for i=1,5 do
		if IsPointInPolygon(bounds[i], GetPlayerPosition()) then
			CRYSTALS[i] = CRYSTALS[i] + 1
			C_ChatInfo.SendAddonMessage("CVTPrivChat", "CRYSTAL:" .. i, "INSTANCE_CHAT")
		end
	end
end

local function CountPickedChest()
	local bounds = nil
	if ZONE == 'SW' then
		bounds = STORMWIND_BOUNDRIES
	else
		bounds = ORGRIMMAR_BOUNDRIES
	end

	for i=1,5 do
		if IsPointInPolygon(bounds[i], GetPlayerPosition()) then
			CHESTS[i] = CHESTS[i] + 1
			C_ChatInfo.SendAddonMessage("CVTPrivChat", "CHESTS:" .. i, "INSTANCE_CHAT")
		end
	end
end

local function PrintOutputTexts()
	local ARR = nil
	local bounds = nil
	local zoneID = 0
	local lastZoneId = 0
	if ZONE == 'SW' then
		ARR = GetStormwindLocations() -- STORMWIND_LOCATIONS
		bounds = STORMWIND_BOUNDRIES
		zoneID = 84
	else
		ARR = GetOrgrimmarLocations() -- ORGRIMMAR_LOCATIONS
		bounds = ORGRIMMAR_BOUNDRIES
		zoneID = 85
	end

	local tasks = GetTasksTable()
	local taskName = ''
	if table.getn(tasks) == 1 then
		local isInArea, isOnMap, numObjectives, taskName, displayAsObjective = GetTaskInfo(tasks[1])
	end

	for i=1,5 do
		if IsPointInPolygon(bounds[i], GetPlayerPosition()) then
			lastZoneId = i
		end
	end


	for i=1,5 do
		CVT_TXT_FRAMES[i]:SetText(ARR[i] .. ': ')
		local size = nil
		if lastZoneId == 0 then
			size = SIZES[2]
		elseif lastZoneId == i then
			size = SIZES[3]
		else
			size = SIZES[1]
		end
		CVT_TXT_FRAMES[i]:SetTextScale(size)
		CVT_TXT_VALS_FRAMES[i]:SetTextScale(size)
		CVT_TXT_VALS_FRAMES[i]:SetText(CRYSTALS[i] .. '/2 |TInterface\\ICONS\\inv_misc_gem_flamespessarite_02:0:0:0:0:16:16:0:16:0:16|t | |TInterface\\ICONS\\inv_misc_chest_azerite:0:0:0:0:16:16:0:16:0:16|t ' .. CHESTS[i] .. '/' .. CHESTS_IN_ZONE[i])

		local CLidx = CRYSTALS[i]
		if CLidx == nil then
			CLidx = 1
		elseif CLidx > 2 then
			CLidx = 2
		end

		CLidx = CLidx + 1

		local CL = TEXT_COLORS[CLidx]
		CVT_TXT_FRAMES[i]:SetTextColor(CL[1], CL[2], CL[3])
		CVT_TXT_VALS_FRAMES[i]:SetTextColor(CL[1], CL[2], CL[3])
	end
end

local function LoadTextFrames()
	CVT_TXT_FRAMES = { CVT_TXT1, CVT_TXT2, CVT_TXT3, CVT_TXT4, CVT_TXT5 }
	CVT_TXT_VALS_FRAMES = { CVT_TXT1_VALS, CVT_TXT2_VALS, CVT_TXT3_VALS, CVT_TXT4_VALS, CVT_TXT5_VALS }
	CVT_VIAL_TXT_FRAMES = { CVT_VIAL_BLACK_TXT, CVT_VIAL_GREEN_TXT, CVT_VIAL_RED_TXT, CVT_VIAL_BLUE_TXT, CVT_VIAL_PURPLE_TXT }
	CVT_VIAL_TXT_VALS_FRAMES = { CVT_VIAL_BLACK_TXT_VAL, CVT_VIAL_GREEN_TXT_VAL, CVT_VIAL_RED_TXT_VAL, CVT_VIAL_BLUE_TXT_VAL, CVT_VIAL_PURPLE_TXT_VAL }
	CVT_VIAL_TXT_VALS_BTNS = { CVT_VIAL_BLACK_BTN, CVT_VIAL_GREEN_BTN, CVT_VIAL_RED_BTN, CVT_VIAL_BLUE_BTN, CVT_VIAL_PURPLE_BTN }
end

local function CVT_HideF()
	CAN_CHECK_VIAL = false
	VIAL_SET = false
	CVT_Frame:SetAlpha(0)
	CVT_Frame:Hide()
	movable = false
	CVT_Frame:SetMovable(movable)
	CVT_Frame:EnableMouse()
end

local function CVT_ShowF()
	CVT_Frame:SetAlpha(1)
	CVT_Frame:Show()

	-- for key, value in pairs(CVT_Config.positionOffset) do
	-- 	print(key .. ":" .. value)
	-- end

	if CVT_Config.positionOffset and #CVT_Config.positionOffset == 5 then
		CVT_Frame:ClearAllPoints()
		CVT_Frame:SetPoint(unpack(CVT_Config.positionOffset))
	end

	CVT.poison.enabled = CVT.poison.enabled or true
	CVT.poison.mouseover = CVT.poison.mouseover or false
end

function CVT_SavePosition()
	local point, relativeTo, relativePoint, xOfs, yOfs = CVT_Frame:GetPoint(1)
	CVT_Config.positionOffset = {point, relativeTo, relativePoint, xOfs, yOfs}
	-- print("saved")
end

local function GetMouseoverTooltipText()
	local data = C_TooltipInfo.GetWorldCursor()
	local text = ""
	if data then
		for i = 1, #data.lines do
			text = data.lines[i].leftText or ""
			if data.lines[i].rightText then
				text = text .. " " .. data.lines[i].rightText
			end
		end
	end
	return text
end

local function SendPoisonStatus(poisonIdx)
	if not VIAL_SET then
		return
	end

	C_ChatInfo.SendAddonMessage("CVTPrivChat", "POISON:" .. poisonIdx, "INSTANCE_CHAT")
end

local function SetVials(poisonVialIdx)
	local i = 0
	for indexer=0,4 do
		local fID = indexer + 1
		if poisonVialIdx == nil then
			i = 1
			CVT_VIAL_TXT_VALS_FRAMES[fID]:SetTextColor(TEXT_COLORS[1][1], TEXT_COLORS[1][2], TEXT_COLORS[1][3])
		else
			i = math.fmod(6 - poisonVialIdx + indexer, 5) + 2
			CVT_VIAL_TXT_VALS_FRAMES[fID]:SetTextColor(TEXT_COLORS[3][1], TEXT_COLORS[3][2], TEXT_COLORS[3][3])
		end
		CVT_VIAL_TXT_FRAMES[fID]:SetTextColor(VIAL_COLORS[fID][1], VIAL_COLORS[fID][2], VIAL_COLORS[fID][3])
		CVT_VIAL_TXT_VALS_FRAMES[fID]:SetText(VIAL_VAL_STRINGS[i])
		-- CVT_VIAL_TXT_FRAMES[i]:SetTextHeight(size)
		-- CVT_VIAL_TXT_VALS_FRAMES[i]:SetTextHeight(size)
	end
end

local function CheckIfVial()
	if not CAN_CHECK_VIAL then
		-- print("You are not mousing over vial.")
		return
	end
	if VIAL_SET then
		-- print("Vial already set, skipping check.")
		return
	end

	-- Vial doesn't exist, so this is some other object
	if UnitExists("mouseover") then
		-- print("You are mousing over ",UnitName("mouseover")," not a 'vial' object.")
		return
	end

	local text = GetMouseoverTooltipText()

	local poisonVial = 0
	if text == CVT['transl']['Vial of Mysterious Black Liquid'] then
		poisonVial = 1
	elseif text == CVT['transl']['Vial of Mysterious Green Liquid'] then
		poisonVial = 2
	elseif text == CVT['transl']['Vial of Mysterious Red Liquid'] then
		poisonVial = 3
	elseif text == CVT['transl']['Vial of Mysterious Blue Liquid'] then
		poisonVial = 4
	elseif text == CVT['transl']['Vial of Mysterious Purple Liquid'] then
		poisonVial = 5
	else
		CAN_CHECK_VIAL = false
		return
	end
	VIAL_SET = true
	CAN_CHECK_VIAL = false
	SetVials(poisonVial)
	SendPoisonStatus(poisonVial)

end


local function IsMouseOverPoisonUnit(unitName)
	local unitTarget = "mouseover"
	if UnitExists(unitTarget) then
		local name = UnitName(unitTarget)
		if name then
			if name == unitName then
				CAN_CHECK_VIAL = true
				-- if CVT.poison.mouseover then
				-- 	-- print(unitName, " found! You can check the vial now.")
				-- else
				-- 	-- print("You clicked on the ", unitName)
				-- end
			else
				CAN_CHECK_VIAL = false
				-- if CVT.poison.mouseover then
				-- 	-- print("You are not mousing over ", unitName, ", to check the vial.")
				-- else
				-- 	-- print("You have not clicked on the ", unitName)
				-- end
			end
		else
			CAN_CHECK_VIAL = false
		end
	end
end

---------------- Buttons Click ----------------



---------------- Events functions ----------------
local events = {}

local targetSpellCast = {}

function events:ADDON_LOADED(addonName)
	if addonName == "CrystalVisionTracker" then
        -- Load the saved variables table
        if CVT_Config == nil then
            CVT_Config = {
                positionOffset = {},
                poison = {
                    enabled = true,  -- Default to enabled
                    mouseover = false -- Default to disabled
                }
            }
        end
        -- Setup the CVT variables table with default values if it doesn't exist
        CVT = CVT or {}
        CVT.poison = CVT_Config.poison
        -- CVT.poison.enabled = CVT.poison.enabled or true
        -- CVT.poison.mouseover = CVT.poison.mouseover or false
		CVT_vialCheckButtonFrame:SetChecked(CVT.poison.enabled)
		CVT_vialMouseoverCheckButtonFrame:SetChecked(CVT.poison.mouseover)
	end
end

function events:PLAYER_LOGOUT()
	CVT_Config.positionOffset = CVT.positionOffset or CVT_Config.positionOffset or {}
	CVT_Config.poison = CVT.poison or CVT_Config.poison or {}
end

function events:UNIT_AURA(unitTarget, updateInfo)
	print(updateInfo.addedAuras)
	print(updateInfo.updatedAuraInstanceIDs)
	print(updateInfo.removedAuraInstanceIDs)
	for k, v in pairs(updateInfo.updatedAuraInstanceIDs) do
		print("Added aura: " .. v)
		-- print("Added aura: " .. v.name .. " (" .. v.spellID .. ")")
	end
	print("----")
end

function events:UNIT_SPELLCAST_SENT(unit, target, castGUID, spellID)
	if unit == "player" then
		if spellID == 143394 and target == CVT['transl']['Odd Crystal'] then
				targetSpellCast[castGUID] = CountPickedCrystal
		elseif spellID == 306608 and target == CVT['transl']['Black Empire Cache'] then
				targetSpellCast[castGUID] = CountPickedChest
		end
	end
end

function events:UNIT_SPELLCAST_FAILED_QUIET(unitTarget, castGUID, spellID)
	if unitTarget == "player" then
		targetSpellCast[castGUID] = nil
	end
end

function events:UNIT_SPELLCAST_SUCCEEDED(unitTarget, castGUID, spellID)
	if unitTarget == "player" then
		if targetSpellCast[castGUID] ~= nil then
			targetSpellCast[castGUID]()
			targetSpellCast = {}
		end
	end
end

function events:GLOBAL_MOUSE_DOWN(mouseButton)
	if CVT.poison.enabled then
		if mouseButton == "LeftButton" then
			local objectName = GetMouseoverTooltipText()
			for _, value in pairs(GetVials()) do
				if objectName == value then
					-- print("You clicked on the " .. objectName .. ".")
					CAN_CHECK_VIAL = true
					return
				end
			end
		end
	end
end

function events:GLOBAL_MOUSE_UP(mouseButton)
	if CVT.poison.enabled then
		if mouseButton == "LeftButton" then
			CheckIfVial()
		end
	end
end

function events:WORLD_CURSOR_TOOLTIP_UPDATE(itemType)
	if CVT.poison.enabled and CVT.poison.mouseover then
		if itemType == Enum.WorldCursorAnchorType.Cursor then
			CheckIfVial()
		end
	end
end

function events:UPDATE_MOUSEOVER_UNIT()
	if CVT.poison.enabled and CVT.poison.mouseover then
		if ZONE == 'SW' then
			IsMouseOverPoisonUnit(CVT['transl']['Morgan Pestle'])
		elseif ZONE == 'OG' then
			IsMouseOverPoisonUnit(CVT['transl']['Voidbound Ravager'])
		end
	end
end

function events:ZONE_CHANGED_NEW_AREA()
	local zone = GetMinimapZoneText()

	if IsRunning() == false then
		SetVials(nil)
		VIAL_SET = false
		CAN_CHECK_VIAL = true
		if zone == CVT['transl']['Vision of Orgrimmar'] then
			CVT_ShowF()
			ZONE = 'OG'
			CRYSTALS = {0, 0, 0, 0, 0}
			CHESTS = {0, 0, 0, 0, 0}
		elseif zone == CVT['transl']['Vision of Stormwind'] then
			CVT_ShowF()
			ZONE = 'SW'
			CRYSTALS = {0, 0, 0, 0, 0}
			CHESTS = {0, 0, 0, 0, 0}
		end
	else
		if zone == CVT['transl']['Chamber of Heart'] or zone == CVT['transl']['The Coreway'] then
			CVT_HideF()
		end
	end
end

function events:CHAT_MSG_ADDON(prefix, message, channel, sender, target, zoneChannelID, localID, name, instanceID)
	if prefix == "CVTPrivChat" then
		local unitName, unitRealm = UnitFullName("player")
		if sender == unitName .. "-" .. unitRealm then
			return
		end
		local msgType, data = strsplit(":", message, 2)
		if msgType == "CRYSTAL" then
			local index = tonumber(data)
			if index and index >= 1 and index <= 5 then
				CRYSTALS[index] = CRYSTALS[index] + 1
			end
		elseif msgType == "CHESTS" then
			local index = tonumber(data)
			if index and index >= 1 and index <= 5 then
				CHESTS[index] = CHESTS[index] + 1
			end
		elseif msgType == "POISON" then
			local index = tonumber(data)
			SetVials(index)
		end
	end
end
---------------- Events handler ----------------

function CVT_OnUpdateFunction(self, deltaTime)
	local zone = GetMinimapZoneText()

	if IsRunning() == true then
		PrintOutputTexts()
		if zone == CVT['transl']['Chamber of Heart'] or zone == CVT['transl']['The Coreway'] then
			CVT_HideF()
		end
	else
		SetVials(nil)
		VIAL_SET = false
		CAN_CHECK_VIAL = true
		if zone == CVT['transl']['Vision of Stormwind'] then
			CVT_ShowF()
			ZONE = 'SW'
			CRYSTALS = {0, 0, 0, 0, 0}
			CHESTS = {0, 0, 0, 0, 0}
		elseif zone == CVT['transl']['Vision of Orgrimmar'] then
			CVT_ShowF()
			ZONE = 'OG'
			CRYSTALS = {0, 0, 0, 0, 0}
			CHESTS = {0, 0, 0, 0, 0}
		end
	end
end

function CVT_OnEventFunction(self, event, ...)
	events[event](self, ...)
end

---------------- Slash Commands ----------------

local function setStormwind(msg, editBox)
	ZONE = 'SW'
	CVT_ShowF()
	CRYSTALS = {0, 0, 0, 0, 0}
	CHESTS = {0, 0, 0, 0, 0}
end
SlashCmdList["CSW"] = setStormwind

local function setOrgrimmar(msg, editBox)
	ZONE = 'OG'
	CVT_ShowF()
	CRYSTALS = {0, 0, 0, 0, 0}
	CHESTS = {0, 0, 0, 0, 0}
end
SlashCmdList["COG"] = setOrgrimmar

local function hideCrystalCounter(msg, editBox)
	CVT_HideF()
end
SlashCmdList["CHIDE"] = hideCrystalCounter

local function testFire(msg, editBox)
	CountPickedCrystal()
end
SlashCmdList["CTFIRE"] = testFire

local function movability(msg, editBox)
	movable = movable == false
	CVT_Frame:SetMovable(movable)
	CVT_Frame:EnableMouse(movable)
	print("Movable: " .. tostring(movable))
end
SlashCmdList["CMOVE"] = movability

local function resetVial(msg, editBox)
	SetVials(nil)
	VIAL_SET = false
	CAN_CHECK_VIAL = true
	print("Vials reset.")
end
SlashCmdList["CVRST"] = resetVial

local function helper(msg, editBox)
	print("/csw - Stormwind (resets counting)\n/cog - Orgrimmar (resets counting)\n/cmove - Toggle moving the frame\n/chide - Hide stats\n/cvrst - Reset vials\n/ctloc - Test print current localised texts")
end
SlashCmdList["CHELP"] = helper

local function testLocalisation(msg, editBox)
	print("Testing localisation:")
	if not CVT['transl'] then
		print("No localisation data found.")
		return
	end

	for key, value in pairs(CVT['transl']) do
		print(key .. ": " .. value)
	end
end
SlashCmdList["CTLOC"] = testLocalisation


local function onVialTextClick(self, button, down)
	print("OnClick", button, down, self:GetText())
end

local function RegisterVialsClicks()
	for i=1,5 do
		CVT_VIAL_TXT_VALS_BTNS[i]:RegisterForClicks("LeftButtonUp")
		CVT_VIAL_TXT_VALS_BTNS[i]:SetScript("OnClick", function(self, button, down)
			if button == "LeftButton" then
				SetVials(i)
			end
		end)
	end
end

function CVT_OnLoad()
	LoadTextFrames()
	RegisterVialsClicks()
	CVT_HideF()
	SetVials(nil)

	C_ChatInfo.RegisterAddonMessagePrefix("CVTPrivChat")
end