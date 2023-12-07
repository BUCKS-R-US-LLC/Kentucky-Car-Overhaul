---CHUCKLEBERRY FINN

local characterVisualHandler = {}

---PATCH INSTRUCTIONS: copy paste this and modify as needed
--[[
--utilizes the file as a module
local charVis = require "SC_CharacterVisuals"

--adds 'MohawkSpike' as an exception, to be replaced with 'MohawkFlat'.
charVis.addToHairTypes("MohawkSpike","MohawkFlat")

--adds 'MohawkSpike' as an exception, to be replaced with ''.
charVis.addToHairTypes("MohawkFan")

--adds 'Bag_Schoolbag' as an exception, to be replaced with 'Bag_ALICEpack_Army'.
charVis.addToItemTypes("Base.Bag_Schoolbag", "Base.Bag_ALICEpack_Army")

--adds 'Bag_ALICEpack_Army' as an exception, to be replaced with nothing.
charVis.addToItemTypes("Base.Bag_ALICEpack_Army")

charVis.addBodyLocations("Back")
--]]

---Instead use the following three functions:
--For removal of items you can just call on the module and utilize ["key"]=nil. I don't see a point in adding that function here to be honest.
function characterVisualHandler.addToHairTypes(hairStyle, alternativeStyle)
    alternativeStyle = alternativeStyle or ""
    characterVisualHandler.addToExceptions(characterVisualHandler.hairTypes, hairStyle, alternativeStyle)
end

function characterVisualHandler.addToItemTypes(itemType, alternativeType)
    alternativeType = alternativeType or true
    characterVisualHandler.addToExceptions(characterVisualHandler.itemTypes, itemType, alternativeType)
end

function characterVisualHandler.addBodyLocations(bodyLocation)
    characterVisualHandler.addToExceptions(characterVisualHandler.bodyLocations, bodyLocation)
end


---


characterVisualHandler.hairTypes = {["MohawkSpike"]="MohawkFlat",["MohawkFan"]="MohawkFlat"}
characterVisualHandler.itemTypes = {}
characterVisualHandler.bodyLocations = {["Back"]=true}

--- This is a backend function - ignore this for patches
function characterVisualHandler.addToExceptions(exceptionsList, original, alternative)
    if not original or not exceptionsList then return end
    exceptionsList[original] = (alternative or true)
end


---@param character IsoPlayer|IsoGameCharacter
function characterVisualHandler.process(character)

    local inVehicle = character:getVehicle()

    ---@type WornItems|ArrayList
    local wornItems = character:getWornItems()
    ---@type ItemVisuals|ArrayList
    local itemVisuals = ItemVisuals.new()
    ---@type WornItems|ArrayList
    local _wornItems = WornItems.new(wornItems)

    for i=0, wornItems:size()-1 do
        ---@type WornItem
        local wornItem = wornItems:get(i)
        if wornItem then
            local wornItemItem = wornItem:getItem()
            local wornItemFullType = wornItemItem:getFullType()
            local wornItemLocation = wornItem:getLocation()

            local hideWornItem = characterVisualHandler.itemTypes[wornItemFullType]
            local hideBodyLocation = characterVisualHandler.bodyLocations[wornItemLocation]

            local prevent = hideWornItem or hideBodyLocation

            if not prevent or (hideWornItem and hideWornItem~=true) then
                local wornItemItemVisual = wornItemItem:getVisual()
                wornItemItemVisual:setInventoryItem(wornItemItem)

                if hideWornItem then
                    wornItemItemVisual:setItemType((inVehicle and hideWornItem) or wornItemFullType)
                end

                itemVisuals:add(wornItemItemVisual)
            end
        end
    end

    local charHairModel = character:getHumanVisual():getHairModel()
    local charModData = character:getModData()

    wornItems:setFromItemVisuals(itemVisuals)

    if inVehicle then
        local hideHair = characterVisualHandler.hairTypes[charHairModel]
        if hideHair then
            character:getHumanVisual():setHairModel(hideHair)
            charModData.sc_storedHairModel = charModData.sc_storedHairModel or charHairModel
        end
        character:resetModel()
        sendVisual(character)
        sendClothing(character)
    end

    wornItems:copyFrom(_wornItems)

    if not inVehicle then
        if charModData.sc_storedHairModel then
            character:getHumanVisual():setHairModel(charModData.sc_storedHairModel)
            charModData.sc_storedHairModel = nil
        end
        character:resetModel()
        sendVisual(character)
        sendClothing(character)
    end

end

function characterVisualHandler._process(index, character) characterVisualHandler.process(character) end

Events.OnClothingUpdated.Add(characterVisualHandler.process)
Events.OnCreatePlayer.Add(characterVisualHandler._process)

return characterVisualHandler
