require "Items/Distributions.lua"
require "Items/ProceduralDistributions.lua"
require "Items/SuburbsDistributions.lua"
require "Vehicles/VehicleDistributions.lua"

Distributions = Distributions or {};

local distributionTable = {

    RedBiohazardBag = {
        rolls = 500,
        items = {
            "BandageDirty", 200,
        },
    },

    YellowBiohazardBag = {
        rolls = 500,
        items = {
            "BandageDirty", 200,
        },
    },

    BodyBag = {
        rolls = 500,
        items = {
            "CorpseMale", 200,
            "CorpseFemale", 200,
        },
    },

}

table.insert(Distributions, 1, distributionTable);