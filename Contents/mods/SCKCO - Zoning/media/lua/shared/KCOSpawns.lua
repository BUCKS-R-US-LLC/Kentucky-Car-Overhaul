if VehicleZoneDistribution then

	---Collectors: Rare spawn zones with a high chance for rare cars. Cars here should be exotics, and especially rare vintage cars. High end cars can also be included, but at a lower spawn rate than exotics---

	VehicleZoneDistribution.collectors = VehicleZoneDistribution.collectors or {};
	VehicleZoneDistribution.collectors.vehicles = VehicleZoneDistribution.collectors.vehicles or {};

	VehicleZoneDistribution.collectors.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.collectors.spawnRate = 25;

	---Exotic: Similar to sport, but for modern exotic cars---

	VehicleZoneDistribution.exotic = VehicleZoneDistribution.exotic or {};
	VehicleZoneDistribution.exotic.vehicles = VehicleZoneDistribution.exotic.vehicles or {};

	VehicleZoneDistribution.exotic.spawnRate = 30;
	VehicleZoneDistribution.exotic.chanceToSpawnSpecial = 0;

	---Barn Find: Rare spawn zone usually near barns. Prioritize classics, especially rare ones, here. Cars in this list will almost be wrecked and may be undrivable, requiring towing. High key chance ---

	VehicleZoneDistribution.barnfind = VehicleZoneDistribution.barnfind or {};
	VehicleZoneDistribution.barnfind.vehicles = VehicleZoneDistribution.barnfind.vehicles or {};

	VehicleZoneDistribution.barnfind.chanceToSpawnKey = 90;
	VehicleZoneDistribution.barnfind.chanceToPartDamage = 90;
	VehicleZoneDistribution.barnfind.baseVehicleQuality = 0.1;
	VehicleZoneDistribution.barnfind.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.barnfind.spawnRate = 30;

	---Expo Car Show: These zones will be near expo centers, or other places where there may be large car shows. Here you will find exotics, race cars, and vintage classics---

	VehicleZoneDistribution.expocarshow = VehicleZoneDistribution.expocarshow or {};
	VehicleZoneDistribution.expocarshow.vehicles = VehicleZoneDistribution.expocarshow.vehicles or {};

	VehicleZoneDistribution.expocarshow.baseVehicleQuality = 1.3;
	VehicleZoneDistribution.expocarshow.chanceToSpawnKey = 75;
	VehicleZoneDistribution.expocarshow.spawnRate = 40;
	VehicleZoneDistribution.expocarshow.chanceToSpawnSpecial = 0;


	---Special Dealer: Specialty car dealer zone. This should contain exotics and imports mostly, as well as restored classics. Possibility for a race/concept car as a display car. HIgher condition and key chance ---

	VehicleZoneDistribution.specialdealer = VehicleZoneDistribution.specialdealer or {};
	VehicleZoneDistribution.specialdealer.vehicles = VehicleZoneDistribution.specialdealer.vehicles or {};

	VehicleZoneDistribution.specialdealer.vehicles["Base.CarLuxury"] = {index = -1, spawnChance = 20};

	VehicleZoneDistribution.specialdealer.baseVehicleQuality = 1.2;
	VehicleZoneDistribution.specialdealer.chanceToSpawnKey = 80;
	VehicleZoneDistribution.specialdealer.spawnRate = 35;
	VehicleZoneDistribution.specialdealer.chanceToSpawnSpecial = 0;


	---New Dealer: Zone for new car dealerships. Should lean towards modern cars, with a rare chance for a display car. Higher condition and key chance.

	VehicleZoneDistribution.newdealer = VehicleZoneDistribution.newdealer or {};
	VehicleZoneDistribution.newdealer.vehicles = VehicleZoneDistribution.newdealer.vehicles or {};

	VehicleZoneDistribution.newdealer.vehicles["Base.ModernCar"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.newdealer.vehicles["Base.ModernCar02"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.newdealer.vehicles["Base.SUV"] = {index = -1, spawnChance = 25};
	VehicleZoneDistribution.newdealer.vehicles["Base.OffRoad"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.newdealer.vehicles["Base.CarLuxury"] = {index = -1, spawnChance = 15};
	VehicleZoneDistribution.newdealer.vehicles["Base.SportsCar"] = {index = -1, spawnChance = 17};
	VehicleZoneDistribution.newdealer.vehicles["Base.PickUpTruck"] = {index = -1, spawnChance = 15};
	VehicleZoneDistribution.newdealer.vehicles["Base.PickUpVan"] = {index = -1, spawnChance = 15};
	VehicleZoneDistribution.newdealer.vehicles["Base.VanSeats"] = {index = -1, spawnChance = 15};

	VehicleZoneDistribution.newdealer.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.newdealer.chanceToSpawnKey = 80;
	VehicleZoneDistribution.newdealer.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.newdealer.spawnRate = 30;

	---Commercial: Medium and small commercial vehicles, such as vans and small box trucks. May include small/medium trailers as well.---
	VehicleZoneDistribution.commercial = VehicleZoneDistribution.commercial or {};
	VehicleZoneDistribution.commercial.vehicles = VehicleZoneDistribution.commercial.vehicles or {};

	VehicleZoneDistribution.commercial.vehicles["Base.Van"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.commercial.vehicles["Base.StepVan"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.commercial.vehicles["Base.PickUpTruck"] = {index = -1, spawnChance = 10};
	VehicleZoneDistribution.commercial.vehicles["Base.PickUpVan"] = {index = -1, spawnChance = 15};

	VehicleZoneDistribution.commercial.spawnRate = 25;
	VehicleZoneDistribution.commercial.chanceToPartDamage = 15;
	VehicleZoneDistribution.commercial.baseVehicleQuality = 0.8;

	---utility: Utility vehicles, such as vans, trucks, and small trailers.---

	VehicleZoneDistribution.military = VehicleZoneDistribution.utility or {};
	VehicleZoneDistribution.military.vehicles = VehicleZoneDistribution.utility.vehicles or {};

	VehicleZoneDistribution.military.vehicles["Base.Van"] = {index = -1, spawnChance = 15};
	VehicleZoneDistribution.military.vehicles["Base.StepVan"] = {index = -1, spawnChance = 15};
	VehicleZoneDistribution.military.vehicles["Base.PickUpTruck"] = {index = -1, spawnChance = 25};
	VehicleZoneDistribution.military.vehicles["Base.PickUpVan"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.military.vehicles["Base.Trailer"] = {index = -1, spawnChance = 10};
	VehicleZoneDistribution.military.vehicles["Base.TrailerCover"] = {index = -1, spawnChance = 10};

	VehicleZoneDistribution.military.spawnRate = 20;
	VehicleZoneDistribution.military.chanceToPartDamage = 15;
	VehicleZoneDistribution.military.baseVehicleQuality = 0.7;


	---Large Commercial: Large commercial vehicles, such as large box trucks or semi trucks/trailers---

	VehicleZoneDistribution.commerciallarge = VehicleZoneDistribution.commerciallarge or {};
	VehicleZoneDistribution.commerciallarge.vehicles = VehicleZoneDistribution.commerciallarge.vehicles or {};

	VehicleZoneDistribution.commerciallarge.vehicles["Base.StepVan"] = {index = -1, spawnChance = 15};

	VehicleZoneDistribution.commerciallarge.spawnRate = 30;
	VehicleZoneDistribution.commerciallarge.chanceToPartDamage = 20;
	VehicleZoneDistribution.commerciallarge.baseVehicleQuality = 0.7;

	---Huge Trailer: Large semi-truck trailers---

	VehicleZoneDistribution.trailerhuge = VehicleZoneDistribution.trailerhuge or {};
	VehicleZoneDistribution.trailerhuge.vehicles = VehicleZoneDistribution.trailerhuge.vehicles or {};

	VehicleZoneDistribution.trailerhuge.spawnRate = 30;
	VehicleZoneDistribution.trailerhuge.chanceToSpawnSpecial = 0;

	---Amateur Mechanic: Amateur mechanic style house. Should contain special custom variants of vehicles, as well as a lower chance for their stock counterparts. Could also contain restored classics---

	VehicleZoneDistribution.amateurmechanic = VehicleZoneDistribution.amateurmechanic or {};
	VehicleZoneDistribution.amateurmechanic.vehicles = VehicleZoneDistribution.amateurmechanic.vehicles or {};

	VehicleZoneDistribution.amateurmechanic.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.amateurmechanic.spawnRate = 25;

	---Import: Cars unavailable in the US, but available elsewhere. Near shipping areas, such as docks, railyards, and airports.---

	VehicleZoneDistribution.import = VehicleZoneDistribution.import or {};
	VehicleZoneDistribution.import.vehicles = VehicleZoneDistribution.import.vehicles or {};

	VehicleZoneDistribution.import.chanceToSpawnKey = 90;
	VehicleZoneDistribution.import.baseVehicleQuality = 0.9;
	VehicleZoneDistribution.import.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.import.spawnRate = 20;

	---Used Dealer: Zone for used car dealers. Should contain older cars, but newer cars can also be included as well. Higher key chance, lower condition.---

	VehicleZoneDistribution.useddealer = VehicleZoneDistribution.useddealer or {};
	VehicleZoneDistribution.useddealer.vehicles = VehicleZoneDistribution.useddealer.vehicles or {};

	VehicleZoneDistribution.useddealer.vehicles["Base.CarNormal"] = {index = -1, spawnChance = 30};
	VehicleZoneDistribution.useddealer.vehicles["Base.SmallCar"] = {index = -1, spawnChance = 25};
	VehicleZoneDistribution.useddealer.vehicles["Base.SmallCar02"] = {index = -1, spawnChance = 25};
	VehicleZoneDistribution.useddealer.vehicles["Base.PickUpTruck"] = {index = -1, spawnChance = 25};
	VehicleZoneDistribution.useddealer.vehicles["Base.PickUpVan"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.useddealer.vehicles["Base.CarStationWagon"] = {index = -1, spawnChance = 30};
	VehicleZoneDistribution.useddealer.vehicles["Base.CarStationWagon2"] = {index = -1, spawnChance = 30};
	VehicleZoneDistribution.useddealer.vehicles["Base.VanSeats"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.useddealer.vehicles["Base.Van"] = {index = -1, spawnChance = 15};

	VehicleZoneDistribution.useddealer.baseVehicleQuality = 0.6;
	VehicleZoneDistribution.useddealer.chanceToPartDamage = 30;
	VehicleZoneDistribution.useddealer.chanceToSpawnKey = 80;
	VehicleZoneDistribution.useddealer.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.useddealer.spawnRate = 37;

	---Racing: Race cars and other track-based vehicles should go here.---

	VehicleZoneDistribution.racing = VehicleZoneDistribution.racing or {};
	VehicleZoneDistribution.racing.vehicles = VehicleZoneDistribution.racing.vehicles or {};

	VehicleZoneDistribution.racing.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.racing.chanceToPartDamage = 0;
	VehicleZoneDistribution.racing.chanceToSpawnKey = 80;
	VehicleZoneDistribution.racing.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.racing.spawnRate = 30;

	--drift: Spawn zones for the drift car(s)
	VehicleZoneDistribution.drift = VehicleZoneDistribution.drift or {};
	VehicleZoneDistribution.drift.vehicles = VehicleZoneDistribution.drift.vehicles or {};

	VehicleZoneDistribution.drift.chanceToSpawnKey = 90;
	VehicleZoneDistribution.drift.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.drift.spawnRate = 200;

	--Trailerutility: Utility trailers, small to medium size.--
	VehicleZoneDistribution.trailerutility = VehicleZoneDistribution.trailerutility or {};
	VehicleZoneDistribution.trailerutility.vehicles = VehicleZoneDistribution.trailerutility.vehicles or {};

	VehicleZoneDistribution.trailerutility.vehicles["Base.Trailer"] = {index = -1, spawnChance = 10};
	VehicleZoneDistribution.trailerutility.vehicles["Base.TrailerCover"] = {index = -1, spawnChance = 10};

	VehicleZoneDistribution.trailerutility.spawnRate = 40;
	VehicleZoneDistribution.trailerutility.chanceToSpawnSpecial = 0;

	--Movers: Various moving company vehicles, near storage units and houses for sale--

	VehicleZoneDistribution.movers = VehicleZoneDistribution.movers or {};
	VehicleZoneDistribution.movers.vehicles = VehicleZoneDistribution.movers.vehicles or {};

	VehicleZoneDistribution.movers.vehicles["Base.Van"] = {index = -1, spawnChance = 10};

	VehicleZoneDistribution.movers.spawnRate = 20;
	VehicleZoneDistribution.movers.chanceToPartDamage = 15;
	VehicleZoneDistribution.movers.baseVehicleQuality = 0.8;

	--Construction: Various construction and large utility vehicles for use near construction zones.--

	VehicleZoneDistribution.construction = VehicleZoneDistribution.construction or {};
	VehicleZoneDistribution.construction.vehicles = VehicleZoneDistribution.construction.vehicles or {};

	VehicleZoneDistribution.construction.spawnRate = 25;
	VehicleZoneDistribution.construction.chanceToPartDamage = 20;
	VehicleZoneDistribution.construction.baseVehicleQuality = 0.7;
	VehicleZoneDistribution.construction.chanceToSpawnSpecial = 0;

	--Waste Service: Garbage trucks near dumpsters and other waste processing areas--

	VehicleZoneDistribution.wasteservice = VehicleZoneDistribution.wasteservice or {};
	VehicleZoneDistribution.wasteservice.vehicles = VehicleZoneDistribution.wasteservice.vehicles or {};

	VehicleZoneDistribution.wasteservice.spawnRate = 35;
	VehicleZoneDistribution.wasteservice.chanceToPartDamage = 20;
	VehicleZoneDistribution.wasteservice.baseVehicleQuality = 0.7;
	VehicleZoneDistribution.wasteservice.chanceToSpawnSpecial = 0;


	--Pace Car: Pace cars and safety cars for use at race tracks--
	VehicleZoneDistribution.pacecar = VehicleZoneDistribution.pacecar or {};
	VehicleZoneDistribution.pacecar.vehicles = VehicleZoneDistribution.pacecar.vehicles or {};

	VehicleZoneDistribution.pacecar.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.pacecar.spawnRate = 200;

	--------------------------------New Special spawn zones--------------------------------


	---Heist Vehicles: Vehicles placed near banks as escape/loot vehicles for a heist story. A bit temp, vehicle stories would be ideal---

	VehicleZoneDistribution.heistvehicle = VehicleZoneDistribution.heistvehicle or {};
	VehicleZoneDistribution.heistvehicle.vehicles = VehicleZoneDistribution.heistvehicle.vehicles or {};

	VehicleZoneDistribution.heistvehicle.vehicles["Base.Van"] = {index = -1, spawnChance = 15};
	VehicleZoneDistribution.heistvehicle.vehicles["Base.PickUpVan"] = {index = -1, spawnChance = 10};
	VehicleZoneDistribution.heistvehicle.vehicles["Base.PickUpTruck"] = {index = -1, spawnChance = 15};

	VehicleZoneDistribution.heistvehicle.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.heistvehicle.spawnRate = 20;

	---Large Police:SWAT Vans, prison buses, and other large law enforcement vehicles---

	VehicleZoneDistribution.policelarge = VehicleZoneDistribution.policelarge or {};
	VehicleZoneDistribution.policelarge.vehicles = VehicleZoneDistribution.policelarge.vehicles or {};

	VehicleZoneDistribution.policelarge.spawnRate = 25;
	VehicleZoneDistribution.policelarge.chanceToSpawnSpecial = 0;

	---Police Exclusive: The vanilla police list, but will only spawn police vehicles---

	VehicleZoneDistribution.policeonly = VehicleZoneDistribution.policeonly or {};
	VehicleZoneDistribution.policeonly.vehicles = VehicleZoneDistribution.policeonly.vehicles or {};

	VehicleZoneDistribution.policeonly.vehicles["Base.PickUpVanLightsPolice"] = {index = 0, spawnChance = 10};
	VehicleZoneDistribution.policeonly.vehicles["Base.CarLightsPolice"] = {index = 0, spawnChance = 10};

	VehicleZoneDistribution.policeonly.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.policeonly.spawnRate = 25;

	---Ambulance Exclusive: The vanilla ambulance list, but will only spawn ambulances---

	VehicleZoneDistribution.ambulanceonly = VehicleZoneDistribution.ambulanceonly or {};
	VehicleZoneDistribution.ambulanceonly.vehicles = VehicleZoneDistribution.ambulanceonly.vehicles or {};

	VehicleZoneDistribution.ambulanceonly.vehicles["Base.VanAmbulance"] = {index = 0, spawnChance = 100};

	VehicleZoneDistribution.ambulanceonly.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.ambulanceonly.spawnRate = 25;

	---Fire Exclusive: The vanilla fire list, but will only spawn fire dept. vehicles---

	VehicleZoneDistribution.fireonly = VehicleZoneDistribution.fireonly or {};
	VehicleZoneDistribution.fireonly.vehicles = VehicleZoneDistribution.fireonly.vehicles or {};

	VehicleZoneDistribution.fireonly.vehicles["Base.PickUpVanLightsFire"] = {index = 0, spawnChance = 50};
	VehicleZoneDistribution.fireonly.vehicles["Base.PickUpTruckLightsFire"] = {index = 0, spawnChance = 50};

	VehicleZoneDistribution.fireonly.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.fireonly.spawnRate = 25;

	--Large Fire: Larger fire dept. vehicles such as fire engines.

	VehicleZoneDistribution.firelarge = VehicleZoneDistribution.firelarge or {};
	VehicleZoneDistribution.firelarge.vehicles = VehicleZoneDistribution.firelarge.vehicles or {};

	VehicleZoneDistribution.firelarge.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.firelarge.spawnRate = 30;

	--vehicletiny: Used for very small vehicles that usually wouldn't be found in a driveway. Usually will be placed in yards and such.--

	VehicleZoneDistribution.vehicletiny = VehicleZoneDistribution.vehicletiny or {};
	VehicleZoneDistribution.vehicletiny.vehicles = VehicleZoneDistribution.vehicletiny.vehicles or {};

	VehicleZoneDistribution.vehicletiny.baseVehicleQuality = 0.8;
	VehicleZoneDistribution.vehicletiny.chanceToSpawnKey = 90;
	VehicleZoneDistribution.vehicletiny.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.vehicletiny.spawnRate = 35;

	--mower: Zone specifically for the mower. Will be near utility sheds, or in some lawns like the tiny vehicle list--

	VehicleZoneDistribution.mower = VehicleZoneDistribution.mower or {};
	VehicleZoneDistribution.mower.vehicles = VehicleZoneDistribution.mower.vehicles or {};

	VehicleZoneDistribution.mower.baseVehicleQuality = 0.8;
	VehicleZoneDistribution.mower.chanceToSpawnKey = 80;
	VehicleZoneDistribution.mower.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.mower.spawnRate = 40;

	--trailertiny: Right now, this is only the mower trailer.--

	VehicleZoneDistribution.trailertiny = VehicleZoneDistribution.trailertiny or {};
	VehicleZoneDistribution.trailertiny.vehicles = VehicleZoneDistribution.trailertiny.vehicles or {};

	VehicleZoneDistribution.trailertiny.baseVehicleQuality = 0.8;
	VehicleZoneDistribution.trailertiny.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.trailertiny.spawnRate = 30;
	
	--hotpursuit: Exotic and special police vehicles--
	
	VehicleZoneDistribution.hotpursuit = VehicleZoneDistribution.hotpursuit or {};
	VehicleZoneDistribution.hotpursuit.vehicles = VehicleZoneDistribution.hotpursuit.vehicles or {};
	
	VehicleZoneDistribution.hotpursuit.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.hotpursuit.spawnRate = 15;
	
end