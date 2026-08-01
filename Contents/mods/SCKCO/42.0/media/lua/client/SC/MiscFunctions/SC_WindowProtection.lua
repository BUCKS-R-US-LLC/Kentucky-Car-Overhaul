SCKCO = SCKCO or {}

-- Vehicle script names whose windows can never be hand-smashed, armor installed or not.
SCKCO.UnbreakableWindowVehicles = {
	["Base.SC_FordF700Armored_Brinks"] = true,
	["Base.SC_FordF700Armored_Dunbar"] = true,
	["Base.SC_FordF700Armored_Transport"] = true,
	["Base.SC_CadillacGageRanger"] = true,
	["Base.SC_CadillacGageRangerLights"] = true,
	["Base.SC_AMGeneralM151A2_3Tone"] = true,
	["Base.SC_AMGeneralM151A2_MERDC"] = true,
	["Base.SC_AMGeneralM151A2_Tan"] = true,
	["Base.SC_AMGeneralM151A2_Cleaners"] = true,
	["Base.SC_AMGeneralM998Soft_3Tone"] = true,
	["Base.SC_AMGeneralM998Soft_OD"] = true,
	["Base.SC_AMGeneralM998Soft_Tan"] = true,
	["Base.SC_AMGeneralM1097TroopCarrier_3Tone"] = true,
	["Base.SC_AMGeneralM1097TroopCarrier_OD"] = true,
	["Base.SC_AMGeneralM1097TroopCarrier_Tan"] = true,
}

-- Windshields break the Window<Pos> id pattern, so they map explicitly.
local WINDSHIELD_ARMOR = {
	Windshield = "SCArmorWindshield",
	WindshieldRear = "SCArmorWindshieldRear",
}

-- WindowFrontLeft -> SCArmorFrontLeftWindow, mirroring the armorUpgrades template part ids.
local function getArmorId(windowId)
	local special = WINDSHIELD_ARMOR[windowId]
	if special then return special end

	local pos = string.match(windowId, "^Window(%a+)$")
	if not pos then return nil end
	return "SCArmor" .. pos .. "Window"
end

function SCKCO.isWindowProtected(part)
	if not part then return false end

	local vehicle = part:getVehicle()
	if not vehicle then return false end

	if SCKCO.UnbreakableWindowVehicles[vehicle:getScriptName()] then return true end

	local armorId = getArmorId(part:getId())
	if not armorId then return false end

	-- The part exists on every vehicle using the template; only an installed item counts as armored.
	local armor = vehicle:getPartById(armorId)
	return armor ~= nil and armor:getInventoryItem() ~= nil
end

-- Hides the slice. ISVehicleMenu gates it on window:isHittable(), a Java method that cannot be
-- overridden, so the slice is suppressed at insertion instead. Callback is read live rather than
-- cached so a later override by another mod still matches.
local ISRadialMenu_addSlice = ISRadialMenu.addSlice
function ISRadialMenu:addSlice(text, texture, callback, arg1, arg2, ...)
	if callback == ISVehiclePartMenu.onSmashWindow and SCKCO.isWindowProtected(arg2) then
		return
	end
	return ISRadialMenu_addSlice(self, text, texture, callback, arg1, arg2, ...)
end

-- Backstop. Covers any caller that reaches the smash directly, including the context-menu path
-- vanilla currently has commented out and any mod that re-enables or reimplements it.
local onSmashWindow = ISVehiclePartMenu.onSmashWindow
function ISVehiclePartMenu.onSmashWindow(playerObj, part, open)
	if SCKCO.isWindowProtected(part) then return end
	return onSmashWindow(playerObj, part, open)
end