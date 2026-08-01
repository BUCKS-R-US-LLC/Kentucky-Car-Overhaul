--[[
    Repair-by-recipe bridge.

    The crafting recipe supplies the UI, the tool and material requirements, and the skill
    gate. This handler supplies the balance model, so a part repaired at the bench behaves
    like one repaired on the vehicle: same condition maths, same ceiling decay, same
    SCKCO_Repairs ModData counter, same failure roll.

    Without this, a stock fixing recipe would repair the item while incrementing vanilla's
    repair counter instead of ours. The part would never accrue ceiling decay, so
    uninstall - repair - reinstall would be an unlimited repair loop.

    OnCreate receives (craftRecipeData, character). Confirmed accessors:
    getAllConsumedItems(), getAllCreatedItems(). Whether a mode:keep input appears in
    getAllConsumedItems() is NOT confirmed, so resolveTarget falls back to scanning the
    character's inventory for the most damaged item of the expected class.
]]

require "SCKCO_PartRepair"

-- Flat global, matching vanilla's RecipeCodeOnCreate.<fn> shape. OnCreate resolves a
-- single-level namespace; SCKCO.RepairRecipe.armor would be two levels deep.
SCKCORepairOnCreate = SCKCORepairOnCreate or {}
SCKCO = SCKCO or {}
SCKCO.RepairRecipe = SCKCORepairOnCreate

local RR = SCKCORepairOnCreate
local AR = SCKCO.PartRepair
local TAG = "[SCKCO RepairRecipe] "

RR.debug = false

-- The item under repair is a kept input, so it may or may not be reported as consumed.
-- Try the recipe data first; otherwise take the most damaged item of that class the
-- character is carrying, which is what the recipe matched to become craftable.
function RR.resolveTarget(craftRecipeData, character, cls)
    if craftRecipeData ~= nil then
        local lists = {}
        if craftRecipeData.getAllConsumedItems then
            lists[#lists + 1] = craftRecipeData:getAllConsumedItems()
        end
        if craftRecipeData.getAllCreatedItems then
            lists[#lists + 1] = craftRecipeData:getAllCreatedItems()
        end
        for _, list in ipairs(lists) do
            if list then
                for i = 0, list:size() - 1 do
                    local item = list:get(i)
                    if item and AR.getItemClass(item) == cls then return item, "recipeData" end
                end
            end
        end
    end

    local inv = character:getInventory()
    if inv == nil or ArrayList == nil then return nil, "none" end
    local all = inv:getAllEvalRecurse(function(item)
        return AR.getItemClass(item) == cls
    end, ArrayList.new())
    local worst, worstCond = nil, nil
    for i = 0, (all and all:size() or 0) - 1 do
        local item = all:get(i)
        local cond = item:getCondition()
        if worstCond == nil or cond < worstCond then worst, worstCond = item, cond end
    end
    if worst then return worst, "inventory" end
    return nil, "none"
end

-- One pass, using the same maths the installed-part path uses.
function RR.repair(craftRecipeData, character, cls)
    local item, how = RR.resolveTarget(craftRecipeData, character, cls)
    if item == nil then
        print(TAG .. "no " .. tostring(cls) .. " item resolved; nothing repaired")
        return
    end
    if RR.debug then
        print(TAG .. "target " .. item:getFullType() .. " via " .. how
            .. " cond=" .. tostring(item:getCondition()))
    end

    -- the shim gives the shared maths the VehiclePart surface it expects
    local part = AR.itemAsPart(item)
    if part == nil then return end

    local ceiling = AR.getConditionCeiling(item)
    if part:getCondition() >= ceiling then
        character:setHaloNote(getText("IGUI_SCKCO_AlreadyFull"), 255, 160, 60, 300)
        return
    end

    if ZombRand(100) < AR.getFailChance(character, part, item) then
        character:setHaloNote(AR.text(part, "Failed"), 255, 160, 60, 300)
        return
    end

    local repaired = math.min(part:getCondition()
        + AR.getPassAmount(character, part, item), ceiling)
    part:setCondition(repaired)

    -- the counter is the whole point: without it the bench path never decays the ceiling
    AR.addRepair(item)

    local xp = SCKCO.PartRepair.getOption("RepairXP")
    local profile = AR.getProfile(part)
    if profile and profile.skill then
        character:getXp():AddXP(Perks[profile.skill], xp)
    end
end

function RR.armor(craftRecipeData, character) RR.repair(craftRecipeData, character, "armor") end
function RR.body(craftRecipeData, character)  RR.repair(craftRecipeData, character, "body")  end
function RR.tire(craftRecipeData, character)  RR.repair(craftRecipeData, character, "tire")  end
function RR.seat(craftRecipeData, character)  RR.repair(craftRecipeData, character, "seat")  end

-- Console diagnostic: prints what craftRecipeData actually exposes, so the resolver can be
-- narrowed once. Set SCKCORepairOnCreate.debug = true to log every repair.
function RR.probe(craftRecipeData)
    if craftRecipeData == nil then print(TAG .. "probe: nil craftRecipeData") return end
    for _, name in ipairs({ "getAllConsumedItems", "getAllCreatedItems", "getRecipe",
                            "getContainers", "getCharacter", "getAllInputItems" }) do
        print(TAG .. "  " .. name .. ": " .. tostring(craftRecipeData[name] ~= nil))
    end
    if craftRecipeData.getAllConsumedItems then
        local c = craftRecipeData:getAllConsumedItems()
        print(TAG .. "  consumed size: " .. tostring(c and c:size()))
        for i = 0, (c and c:size() or 0) - 1 do
            print(TAG .. "    " .. tostring(c:get(i):getFullType()))
        end
    end
end
