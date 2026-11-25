require "SC/PartRepair/SC_PartRepair"

-- Bench repair bridge (SCKCO_recipes_repair.txt). The recipe supplies UI, tools, materials
-- and the skill gate; OnCreate applies the same pass maths, ceiling decay and SCKCO_Repairs
-- counter as on-vehicle repair, so uninstall/repair/reinstall cannot dodge the decay.
-- OnCreate runs on the server in MP; syncItemFields carries the result to the owner.

-- flat global: OnCreate resolves one namespace level (SCKCORepairOnCreate.armor)
SCKCORepairOnCreate = SCKCORepairOnCreate or {}
SCKCO.RepairRecipe = SCKCORepairOnCreate
local RR = SCKCORepairOnCreate
local AR = SCKCO.PartRepair

-- The part is a mode:keep input and may not be listed as consumed, so fall back to the most
-- damaged carried item of the class, which is what made the recipe craftable.
function RR.resolveTarget(craftRecipeData, character, cls)
    for _, list in ipairs({ craftRecipeData:getAllConsumedItems(), craftRecipeData:getAllCreatedItems() }) do
        for i = 0, list:size() - 1 do
            local item = list:get(i)
            if AR.getItemClass(item) == cls then return item end
        end
    end
    local all = character:getInventory():getAllEvalRecurse(function(item)
        return AR.getItemClass(item) == cls
    end, ArrayList.new())
    local worst
    for i = 0, all:size() - 1 do
        local item = all:get(i)
        if worst == nil or item:getCondition() < worst:getCondition() then worst = item end
    end
    return worst
end

function RR.repair(craftRecipeData, character, cls)
    -- a craftRecipe cannot be hidden by a sandbox option, so it is enforced here
    if not AR.getOption("RepairLooseParts") then
        return AR.notify(character, "IGUI_SCKCO_LooseRepairDisabled", 255, 160, 60)
    end
    local item = RR.resolveTarget(craftRecipeData, character, cls)
    local part = item and AR.itemAsPart(item)
    if part == nil then
        print("[SCKCO RepairRecipe] no " .. cls .. " item resolved; nothing repaired")
        return
    end
    if part:getCondition() >= AR.getConditionCeiling(item) then
        return AR.notify(character, "IGUI_SCKCO_AlreadyFull", 255, 160, 60)
    end
    local sync = function() syncItemFields(character, item) end
    if AR.applyPass(character, part, item, sync, false) then
        AR.awardXp(character, part, AR.getOption("RepairXP"), true)
    end
end

function RR.armor(data, character) RR.repair(data, character, "armor") end
function RR.body(data, character) RR.repair(data, character, "body") end
function RR.tire(data, character) RR.repair(data, character, "tire") end
function RR.seat(data, character) RR.repair(data, character, "seat") end
