local miscVehicleLua = require("SC/SC_miscVehicleLua.lua")

--- Events.OnPlayerUpdate.Add(miscVehicleLua.M35A2CargoWeightFix)
Events.OnWeaponSwingHitPoint.Add(miscVehicleLua.processOnWeaponSwingHitPoint)
Events.OnPlayerUpdate.Add(miscVehicleLua.processOnPlayerUpdate)
Events.OnPlayerAttackFinished.Add(miscVehicleLua.applyDamageToArmor)
Events.OnPlayerUpdate.Add(miscVehicleLua.applyDamageToArmorOnUpdate)