SCKCO = SCKCO or {}
SCKCO.Create = SCKCO.Create or {}

-- No-op create/init for parts with no backing item. Vehicles.Create.Default calls
-- createPartInventoryItem, which appends mechanicType to itemType ("nil" -> "nil2")
-- and resolves to a nil item.
SCKCO.Create.Blank = function(vehicle, part) end
