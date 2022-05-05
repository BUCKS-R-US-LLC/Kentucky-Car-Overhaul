if not getActivatedMods():contains("SCVP") then

function stzo_stev_override()

	local GetVehicleX;
	local GetVehicleY;
	local GetVehicleScript;
	local GetVehicle;
	local GetVehicleTrunk;
	-- Coord Stuff
	-- Rosewood
	local GetRWXMin = 7865;
	local GetRWXMax = 9350;
	local GetRWYMin = 11250;
	local GetRWYMax = 13500;
	-- Riverside
	local GetRSXMin = 3400;
	local GetRSXMax = 7500;
	local GetRSYMin = 5150;
	local GetRSYMax = 6800;
	-- Muldraugh
	local GetMDXMin = 9800;
	local GetMDXMax = 11300;
	local GetMDYMin = 8800;
	local GetMDYMax = 11150;
	-- WestPoint
	local GetWPXMin = 10700;
	local GetWPXMax = 12200;
	local GetWPYMin = 6500;
	local GetWPYMax = 7300;
	-- JeffersonCountySD1
	local GetJCSD1XMin = 12891;
	local GetJCSD1XMax = 14800;
	local GetJCSD1YMin = 2200;
	local GetJCSD1YMax = 2690;
	-- JeffersonCountySD2
	local GetJCSD2XMin = 13771;
	local GetJCSD2XMax = 14800;
	local GetJCSD2YMin = 2691;
	local GetJCSD2YMax = 3440;
	-- JeffersonCountySD3
	local GetJCSD3XMin = 13041;
	local GetJCSD3XMax = 14800;
	local GetJCSD3YMin = 3441;
	local GetJCSD3YMax = 7460;
	-- JeffersonCountyPD1
	local GetJCPD1XMin = 12901;
	local GetJCPD1XMax = 13770;
	local GetJCPD1YMin = 2691;
	local GetJCPD1YMax = 3440;
	-- JeffersonCountyPD2
	local GetJCPD2XMin = 12901;
	local GetJCPD2XMax = 13040;
	local GetJCPD2YMin = 2691;
	local GetJCPD2YMax = 3865;
	-- LouisvillePD1
	local GetLPD1XMin = 11900;
	local GetLPD1XMax = 12900;
	local GetLPD1YMin = 900;
	local GetLPD1YMax = 2190;
	-- LouisvillePD2
	local GetLPD2XMin = 11900;
	local GetLPD2XMax = 12900;
	local GetLPD2YMin = 2191;
	local GetLPD2YMax = 2690;
	-- LouisvillePD3
	local GetLPD3XMin = 11900;
	local GetLPD3XMax = 12660;
	local GetLPD3YMin = 2691;
	local GetLPD3YMax = 3890;
	-- LouisvilleKSP1
	local GetKSP1XMin = 12901;
	local GetKSP1XMax = 14800;
	local GetKSP1YMin = 900;
	local GetKSP1YMax = 2199;
	-- LouisvilleKSP2
	local GetKSP2XMin = 12200;
	local GetKSP2XMax = 13040;
	local GetKSP2YMin = 3891;
	local GetKSP2YMax = 6700;
	-- LouisvilleKSP3
	local GetKSP3XMin = 3500;
	local GetKSP3XMax = 4800;
	local GetKSP3YMin = 7100;
	local GetKSP3YMax = 11000;
	-- Louisville
	local GetLVXMin = 11900;
	local GetLVXMax = 14800;
	local GetLVYMin = 900;
	local GetLVYMax = 3865;
	-- JeffersonCounty
	local GetJCXMin = 12891;
	local GetJCXMax = 14800;
	local GetJCYMin = 2200;
	local GetJCYMax = 7460;
	-- RavenCreek
	local GetRCRXMin = 3000;
	local GetRCRXMax = 5500;
	local GetRCRYMin = 11001;
	local GetRCRYMax = 13500;

	local GetVehicles = getWorld():getCell():getVehicles();

	if GetVehicles ~= nil then
		for i=0, GetVehicles:size()-1 do
			GetVehicleX = GetVehicles:get(i):getX();
			GetVehicleY = GetVehicles:get(i):getY();
			GetVehicleScript = GetVehicles:get(i):getScriptName();
			GetVehicle = GetVehicles:get(i);
			
			GetVehicleTrunk = GetVehicle:getPartById("TruckBed");

			-- RosewoodSD
			local VehiclesRosewoodSD = {"Base.85crownvic_rosewoodpolice", "Base.87caprice_rosewoodpolice", "Base.91blazer_rosewoodpolice"};
			local str_rwresult = VehiclesRosewoodSD[ZombRand(1,#VehiclesRosewoodSD+1)];
			-- MeadeCountySO
			local VehiclesMeadeSO = {"Base.85crownvic_meadesheriff", "Base.87caprice_meadesheriff"};
			local str_mcresult = VehiclesMeadeSO[ZombRand(1,#VehiclesMeadeSO+1)];
			-- RiversidePD
			local VehiclesRiversidePD = {"Base.85crownvic_riversidepolice", "Base.87caprice_riversidepolice"};
			local str_rsresult = VehiclesRiversidePD[ZombRand(1,#VehiclesRiversidePD+1)];
			-- MuldraughPD
			local VehiclesMuldraughPD = {"Base.85crownvic_muldraughpolice", "Base.87caprice_muldraughpolice"};
			local str_mdresult = VehiclesMuldraughPD[ZombRand(1,#VehiclesMuldraughPD+1)];
			-- WestPointPD
			local VehiclesWestPointPD = {"Base.85crownvic_westpointpolice", "Base.87caprice_westpointpolice"};
			local str_wpresult = VehiclesWestPointPD[ZombRand(1,#VehiclesWestPointPD+1)];
			-- JeffersonCountySD
			local VehiclesJeffersonSD = {"Base.85crownvic_jeffersonsheriff", "Base.87caprice_jeffersonsheriff"};
			local str_jcsdresult = VehiclesJeffersonSD[ZombRand(1,#VehiclesJeffersonSD+1)];
			-- JeffersonCountyPD
			local VehiclesJeffersonPD = {"Base.85crownvic_jeffersonpolice", "Base.87caprice_jeffersonpolice"};
			local str_jcpdresult = VehiclesJeffersonPD[ZombRand(1,#VehiclesJeffersonPD+1)];
			-- LouisvillePD
			local VehiclesLouisvillePD = {"Base.92crownvic_louisvillepolice"};
			local str_lpdresult = VehiclesLouisvillePD[ZombRand(1,#VehiclesLouisvillePD+1)];
			-- LouisvilleKSP
			local VehiclesLouisvilleKSP = {"Base.85crownvic_kentuckystate", "Base.92crownvic_kentuckystate"};
			local str_lkspresult = VehiclesLouisvilleKSP[ZombRand(1,#VehiclesLouisvilleKSP+1)];
			-- RavenCreekPD
			local VehiclesRavenCreekPD = {"Base.85crownvicpdrcr", "Base.87capricepdrcr", "Base.92crownvicpdrcr"};
			local str_rcrpdresult = VehiclesRavenCreekPD[ZombRand(1,#VehiclesRavenCreekPD+1)];
			-- Rangers
			local VehiclesRangers = {"Base.92wranglerranger_NSP", "Base.85crownvicranger_NSP", "Base.91blazerranger_FWS", "Base.85crownvicranger_FWS", "Base.92wranglerranger_FWS", "Base.85crownvicranger_SPR"};
			local str_rresult = VehiclesRangers[ZombRand(1,#VehiclesRangers+1)];
			-- LouisvilleFD
			local VehiclesLVFD = {"Base.firepumper_louisville"};
			local str_lvfdresult = VehiclesLVFD[ZombRand(1,#VehiclesLVFD+1)];
			-- RosewoodFD
			local VehiclesRWFD = {"Base.firepumper_rosewood"};
			local str_rwfdresult = VehiclesRWFD[ZombRand(1,#VehiclesRWFD+1)];
			-- MeadeCountyFD
			local VehiclesMCFD = {"Base.firepumper_meade"};
			local str_mcfdresult = VehiclesMCFD[ZombRand(1,#VehiclesMCFD+1)];
			-- LouisvilleEMS
			local VehiclesLVEMS = {"Base.80f350ambulance_louisville", "Base.86econolineambulance_louisville"};
			local str_lvemsresult = VehiclesLVEMS[ZombRand(1,#VehiclesLVEMS+1)];
			-- 	JeffersonCountyEMS
			local VehiclesJCEMS = {"Base.80f350ambulance_jefferson", "Base.86econolineambulance_jefferson"};
			local str_jcemsresult = VehiclesJCEMS[ZombRand(1,#VehiclesJCEMS+1)];
			-- MeadeCountyEMS
			local VehiclesMCEMS = {"Base.80f350ambulance_meade", "Base.86econolineambulance_meade"};
			local str_mcemsresult = VehiclesMCEMS[ZombRand(1,#VehiclesMCEMS+1)];

			-- RosewoodSD
			if GetVehicleX >= GetRWXMin and GetVehicleX <= GetRWXMax and GetVehicleY >= GetRWYMin and GetVehicleY <= GetRWYMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_rwresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- RiversidePD
			elseif GetVehicleX >= GetRSXMin and GetVehicleX <= GetRSXMax and GetVehicleY >= GetRSYMin and GetVehicleY <= GetRSYMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_rsresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- MuldraughPD
			elseif GetVehicleX >= GetMDXMin and GetVehicleX <= GetMDXMax and GetVehicleY >= GetMDYMin and GetVehicleY <= GetMDYMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_mdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- WestPointPD
			elseif GetVehicleX >= GetWPXMin and GetVehicleX <= GetWPXMax and GetVehicleY >= GetWPYMin and GetVehicleY <= GetWPYMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_wpresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- JeffersonCountySD1(North Chunk)
			elseif GetVehicleX >= GetJCSD1XMin and GetVehicleX <= GetJCSD1XMax and GetVehicleY >= GetJCSD1YMin and GetVehicleY <= GetJCSD1YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_jcsresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- JeffersonCountySD2(Middle Chunk)
			elseif GetVehicleX >= GetJCSD2XMin and GetVehicleX <= GetJCSD2XMax and GetVehicleY >= GetJCSD2YMin and GetVehicleY <= GetJCSD2YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_jcsdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- JeffersonCountySD3(South Chunk)
			elseif GetVehicleX >= GetJCSD3XMin and GetVehicleX <= GetJCSD3XMax and GetVehicleY >= GetJCSD3YMin and GetVehicleY <= GetJCSD3YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_jcsdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- JeffersonCountyPD1(North Chunk)
			elseif GetVehicleX >= GetJCPD1XMin and GetVehicleX <= GetJCPD1XMax and GetVehicleY >= GetJCPD1YMin and GetVehicleY <= GetJCPD1YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_jcpdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- JeffersonCountyPD2(South Chunk)
			elseif GetVehicleX >= GetJCPD2XMin and GetVehicleX <= GetJCPD2XMax and GetVehicleY >= GetJCPD2YMin and GetVehicleY <= GetJCPD2YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_jcpdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- LouisvillePD1(North Chunk)
			elseif GetVehicleX >= GetJCSD1XMin and GetVehicleX <= GetLPD1XMax and GetVehicleY >= GetLPD1YMin and GetVehicleY <= GetLPD1YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_lpdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- LouisvillePD2(South Chunk)
			elseif GetVehicleX >= GetLPD2XMin and GetVehicleX <= GetLPD2XMax and GetVehicleY >= GetLPD2YMin and GetVehicleY <= GetLPD2YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_lpdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- LouisvillePD3(Hospital Chunk)
			elseif GetVehicleX >= GetLPD3XMin and GetVehicleX <= GetLPD3XMax and GetVehicleY >= GetLPD3YMin and GetVehicleY <= GetLPD3YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_lpdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- LouisvilleKSP1(Main Area - Louisville)
			elseif GetVehicleX >= GetKSP1XMin and GetVehicleX <= GetKSP1XMax and GetVehicleY >= GetKSP1YMin and GetVehicleY <= GetKSP1YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_lkspresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- LouisvilleKSP2(Louisville Military Blockade)
			elseif GetVehicleX >= GetKSP2XMin and GetVehicleX <= GetKSP2XMax and GetVehicleY >= GetKSP2YMin and GetVehicleY <= GetKSP2YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_lkspresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- LouisvilleKSP3(Riverside Highway)
			elseif GetVehicleX >= GetKSP3XMin and GetVehicleX <= GetKSP3XMax and GetVehicleY >= GetKSP3YMin and GetVehicleY <= GetKSP3YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_lkspresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			if(getActivatedMods():contains("RavenCreekPDCars")) then
			-- RavenCreekPD
			elseif GetVehicleX >= GetRCRXMin and GetVehicleX <= GetRCRXMax and GetVehicleY >= GetRCRYMin and GetVehicleY <= GetRCRYMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_rcrpdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			end
			-- MeadeCountySO
			else
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_mcresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			end
			-- Rangers
			if GetVehicleScript == "Base.CarLights" or GetVehicleScript == "Base.85vicranger" or GetVehicleScript == "Base.92wranglerranger" then
				GetVehicle:setScript(str_rresult);
					GetVehicle:scriptReloaded();
				GetVehicle:setNeedPartsUpdate(true);
			end
			-- Firefighters
			-- LouisvilleFD
			if GetVehicleX >= GetLVXMin and GetVehicleX <= GetLVXMax and GetVehicleY >= GetLVYMin and GetVehicleY <= GetLVYMax then
				if GetVehicleScript == "Base.PickUpTruckLightsFire" or GetVehicleScript == "Base.PickUpVanLightsFire" or GetVehicleScript == "Base.87c10fire" or GetVehicleScript == "Base.firepumper" then
					GetVehicle:setScript(str_lvfdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- RosewoodFD
			elseif GetVehicleX >= GetRWXMin and GetVehicleX <= GetRWXMax and GetVehicleY >= GetRWYMin and GetVehicleY <= GetRWYMax then
				if GetVehicleScript == "Base.PickUpTruckLightsFire" or GetVehicleScript == "Base.PickUpVanLightsFire" or GetVehicleScript == "Base.87c10fire" or GetVehicleScript == "Base.firepumper" then
					GetVehicle:setScriptName(str_rwfdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- MeadeCountyFD
			else
				if GetVehicleScript == "Base.PickUpTruckLightsFire" or GetVehicleScript == "Base.PickUpVanLightsFire" or GetVehicleScript == "Base.87c10fire" or GetVehicleScript == "Base.firepumper" then
					GetVehicle:setScript(str_mcfdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			end
			-- EMS
			-- LouisvilleEMS
			if GetVehicleX >= GetLVXMin and GetVehicleX <= GetLVXMax and GetVehicleY >= GetLVYMin and GetVehicleY <= GetLVYMax then
				if GetVehicleScript == "Base.VanAmbulance" or GetVehicleScript == "Base.80f350ambulance" or GetVehicleScript == "Base.86econolineambulance" then
					GetVehicle:setScript(str_lvemsresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- JeffersonCountyEMS
			elseif GetVehicleX >= GetJCXMin and GetVehicleX <= GetJCXMax and GetVehicleY >= GetJCYMin and GetVehicleY <= GetJCYMax then
				if GetVehicleScript == "Base.VanAmbulance" or GetVehicleScript == "Base.80f350ambulance" or GetVehicleScript == "Base.86econolineambulance" then
					GetVehicle:setScript(str_jcemsresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- MeadeCountyEMS
			else
				if GetVehicleScript == "Base.VanAmbulance" or GetVehicleScript == "Base.80f350ambulance" or GetVehicleScript == "Base.86econolineambulance" then
					GetVehicle:setScript(str_mcemsresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			end
		end
	end
end

local function stzo_stev_override_key()

	local GetKey;
	local GetVehicleName;

	local GetVehicles = getWorld():getCell():getVehicles();

	if GetVehicles ~= nil then
		for i=0, GetVehicles:size()-1 do

		GetKey = GetVehicles:get(i):getCurrentKey();
		GetVehicleName = GetVehicles:get(i):getScriptName();

	if getActivatedMods():contains("STEVLFN") then
		if GetKey ~= nil then
			-- MeadeCountySO
			if GetVehicleName == "Base.85crownvic_meadesheriff" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.87caprice_meadesheriff" then
				if GetKey:getName() ~= "Chevalier Titan Key" then
					GetKey:setName("Chevalier Titan Key");
				end
			-- RiversidePD
			elseif GetVehicleName == "Base.85crownvic_riversidepolice" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.87caprice_riversidepolice" then
				if GetKey:getName() ~= "Chevalier Titan Key" then
					GetKey:setName("Chevalier Titan Key");
				end
			-- RosewoodSD
			elseif GetVehicleName == "Base.85crownvic_rosewoodpolice" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.87caprice_rosewoodpolice" then
				if GetKey:getName() ~= "Chevalier Titan Key" then
					GetKey:setName("Chevalier Titan Key");
				end
			elseif GetVehicleName == "Base.91blazer_rosewoodpolice" then
				if GetKey:getName() ~= "Chevalier Kobold Key" then
					GetKey:setName("Chevalier Kobold Key");
				end
			-- WestPointPD
			elseif GetVehicleName == "Base.85crownvic_westpointpolice" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.87caprice_westpointpolice" then
				if GetKey:getName() ~= "Chevalier Titan Key" then
					GetKey:setName("Chevalier Titan Key");
				end
			-- MuldraughPD
			elseif GetVehicleName == "Base.85crownvic_muldraughpolice" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.87caprice_muldraughpolice" then
				if GetKey:getName() ~= "Chevalier Titan Key" then
					GetKey:setName("Chevalier Titan Key");
				end
			-- JeffersonCountySD
			elseif GetVehicleName == "Base.85crownvic_jeffersonsheriff" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.87caprice_jeffersonsheriff" then
				if GetKey:getName() ~= "Chevalier Titan Key" then
					GetKey:setName("Chevalier Titan Key");
				end
			-- JeffersonCountyPD
			elseif GetVehicleName == "Base.85crownvic_jeffersonpolice" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.87caprice_jeffersonpolice" then
				if GetKey:getName() ~= "Chevalier Titan Key" then
					GetKey:setName("Chevalier Titan Key");
				end
			-- Kentucky State Police
			elseif GetVehicleName == "Base.85crownvic_kentuckystate" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.92crownvic_kentuckystate" then
				if GetKey:getName() ~= "Crest Andarta Key" then
					GetKey:setName("Crest Andarta Key");
				end
			-- LouisvillePD
			elseif GetVehicleName == "Base.92crownvic_louisvillepolice" then
				if GetKey:getName() ~= "Crest Andarta Key" then
					GetKey:setName("Crest Andarta Key");
				end
			-- Rangers
			elseif GetVehicleName == "Base.92wranglerranger_NSP" then
				if GetKey:getName() ~= "Lark Rancher Key" then
					GetKey:setName("Lark Rancher Key");
				end
			elseif GetVehicleName == "Base.85crownvicranger_NSP" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.91blazerranger_FWS" then
				if GetKey:getName() ~= "Chevalier Kobold Key" then
					GetKey:setName("Chevalier Kobold Key");
				end
			elseif GetVehicleName == "Base.85crownvicranger_FWS" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.92wranglerranger_FWS" then
				if GetKey:getName() ~= "Lark Rancher Key" then
					GetKey:setName("Lark Rancher Key");
				end
			elseif GetVehicleName == "Base.85crownvicranger_SPR" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.firepumper_louisville" then
				if GetKey:getName() ~= "Fire Engine Key" then
					GetKey:setName("Fire Engine Key");
				end
			elseif GetVehicleName == "Base.firepumper_rosewood" then
				if GetKey:getName() ~= "Fire Engine Key" then
					GetKey:setName("Fire Engine Key");
				end
			elseif GetVehicleName == "Base.firepumper_meade" then
				if GetKey:getName() ~= "Fire Engine Key" then
					GetKey:setName("Fire Engine Key");
				end
			elseif GetVehicleName == "Base.80f350ambulance_jefferson" then
				if GetKey:getName() ~= "Franklin EF35 Key" then
					GetKey:setName("Franklin EF35 Key");
				end
			elseif GetVehicleName == "Base.86econolineambulance_jefferson" then
				if GetKey:getName() ~= "Franklin V250 Key" then
					GetKey:setName("Franklin V250 Key");
				end
			elseif GetVehicleName == "Base.80f350ambulance_meade" then
				if GetKey:getName() ~= "Franklin EF35 Key" then
					GetKey:setName("Franklin EF35 Key");
				end
			elseif GetVehicleName == "Base.86econolineambulance_meade" then
				if GetKey:getName() ~= "Franklin V250 Key" then
					GetKey:setName("Franklin V250 Key");
				end
			elseif GetVehicleName == "Base.80f350ambulance_louisville" then
				if GetKey:getName() ~= "Franklin EF35 Key" then
					GetKey:setName("Franklin EF35 Key");
				end
			elseif GetVehicleName == "Base.86econolineambulance_louisville" then
				if GetKey:getName() ~= "Franklin V250 Key" then
					GetKey:setName("Franklin V250 Key");
				end
			end
	elseif getActivatedMods():contains("STEVRN") then
					if GetKey ~= nil then
						-- MeadeCountySO
						if GetVehicleName == "Base.85crownvic_meadesheriff" then
							if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
								GetKey:setName("Ford Crown Victoria LTD Key");
							end
						elseif GetVehicleName == "Base.87caprice_meadesheriff" then
							if GetKey:getName() ~= "Chevrolet Caprice Key" then
								GetKey:setName("Chevrolet Caprice Key");
							end
						-- RiversidePD
						elseif GetVehicleName == "Base.85crownvic_riversidepolice" then
							if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
								GetKey:setName("Ford Crown Victoria LTD Key");
							end
						elseif GetVehicleName == "Base.87caprice_riversidepolice" then
							if GetKey:getName() ~= "Chevrolet Caprice Key" then
								GetKey:setName("Chevrolet Caprice Key");
							end
						-- RosewoodSD
						elseif GetVehicleName == "Base.85crownvic_rosewoodpolice" then
							if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
								GetKey:setName("Ford Crown Victoria LTD Key");
							end
						elseif GetVehicleName == "Base.87caprice_rosewoodpolice" then
							if GetKey:getName() ~= "Chevrolet Caprice Key" then
								GetKey:setName("Chevrolet Caprice Key");
							end
						elseif GetVehicleName == "Base.91blazer_rosewoodpolice" then
							if GetKey:getName() ~= "Chevrolet Blazer Key" then
								GetKey:setName("Chevrolet Blazer Key");
							end
						-- WestPointPD
						elseif GetVehicleName == "Base.85crownvic_westpointpolice" then
							if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
								GetKey:setName("Ford Crown Victoria LTD Key");
							end
						elseif GetVehicleName == "Base.87caprice_westpointpolice" then
							if GetKey:getName() ~= "Chevrolet Caprice Key" then
								GetKey:setName("Chevrolet Caprice Key");
							end
						-- MuldraughPD
						elseif GetVehicleName == "Base.85crownvic_muldraughpolice" then
							if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
								GetKey:setName("Ford Crown Victoria LTD Key");
							end
						elseif GetVehicleName == "Base.87caprice_muldraughpolice" then
							if GetKey:getName() ~= "Chevrolet Caprice Key" then
								GetKey:setName("Chevrolet Caprice Key");
							end
						-- JeffersonCountySD
						elseif GetVehicleName == "Base.85crownvic_jeffersonsheriff" then
							if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
								GetKey:setName("Ford Crown Victoria LTD Key");
							end
						elseif GetVehicleName == "Base.87caprice_jeffersonsheriff" then
							if GetKey:getName() ~= "Chevrolet Caprice Key" then
								GetKey:setName("Chevrolet Caprice Key");
							end
						-- JeffersonCountyPD
						elseif GetVehicleName == "Base.85crownvic_jeffersonpolice" then
							if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
								GetKey:setName("Ford Crown Victoria LTD Key");
							end
						elseif GetVehicleName == "Base.87caprice_jeffersonpolice" then
							if GetKey:getName() ~= "Chevrolet Caprice Key" then
								GetKey:setName("Chevrolet Caprice Key");
							end
						-- Kentucky State Police
						elseif GetVehicleName == "Base.85crownvic_kentuckystate" then
							if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
								GetKey:setName("Ford Crown Victoria LTD Key");
							end
						elseif GetVehicleName == "Base.92crownvic_kentuckystate" then
							if GetKey:getName() ~= "Crown Victoria Key" then
								GetKey:setName("Crown Victoria Key");
							end
						-- LouisvillePD
						elseif GetVehicleName == "Base.92crownvic_louisvillepolice" then
							if GetKey:getName() ~= "Crown Victoria Key" then
								GetKey:setName("Crown Victoria Key");
							end
						-- Rangers
						elseif GetVehicleName == "Base.92wranglerranger_NSP" then
							if GetKey:getName() ~= "Jeep Wrangler Key" then
								GetKey:setName("Jeep Wrangler Key");
							end
						elseif GetVehicleName == "Base.85crownvicranger_NSP" then
							if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
								GetKey:setName("Ford Crown Victoria LTD Key");
							end
						elseif GetVehicleName == "Base.91blazerranger_FWS" then
							if GetKey:getName() ~= "Chevrolet Blazer Key" then
								GetKey:setName("Chevrolet Blazer Key");
							end
						elseif GetVehicleName == "Base.85crownvicranger_FWS" then
							if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
								GetKey:setName("Ford Crown Victoria LTD Key");
							end
						elseif GetVehicleName == "Base.92wranglerranger_FWS" then
							if GetKey:getName() ~= "Jeep Wrangler Key" then
								GetKey:setName("Jeep Wrangler Key");
							end
						elseif GetVehicleName == "Base.85crownvicranger_SPR" then
							if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
								GetKey:setName("Ford Crown Victoria LTD Key");
							end
						elseif GetVehicleName == "Base.firepumper_louisville" then
							if GetKey:getName() ~= "Fire Engine Key" then
								GetKey:setName("Fire Engine Key");
							end
						elseif GetVehicleName == "Base.firepumper_rosewood" then
							if GetKey:getName() ~= "Fire Engine Key" then
								GetKey:setName("Fire Engine Key");
							end
						elseif GetVehicleName == "Base.firepumper_meade" then
							if GetKey:getName() ~= "Fire Engine Key" then
								GetKey:setName("Fire Engine Key");
							end
						elseif GetVehicleName == "Base.80f350ambulance_jefferson" then
							if GetKey:getName() ~= "Ford F350 Key" then
								GetKey:setName("Ford F350 Key");
							end
						elseif GetVehicleName == "Base.86econolineambulance_jefferson" then
							if GetKey:getName() ~= "Ford E350 Key" then
								GetKey:setName("Ford E350 Key");
							end
						elseif GetVehicleName == "Base.80f350ambulance_meade" then
							if GetKey:getName() ~= "Ford F350 Key" then
								GetKey:setName("Ford F350 Key");
							end
						elseif GetVehicleName == "Base.86econolineambulance_meade" then
							if GetKey:getName() ~= "Ford E350 Key" then
								GetKey:setName("Ford E350 Key");
							end
						elseif GetVehicleName == "Base.80f350ambulance_louisville" then
							if GetKey:getName() ~= "Ford F350 Key" then
								GetKey:setName("Ford F350 Key");
							end
						elseif GetVehicleName == "Base.86econolineambulance_louisville" then
							if GetKey:getName() ~= "Ford E350 Key" then
								GetKey:setName("Ford E350 Key");
							end
						end
					end
				end
			end
		end
	end
end

Events.EveryOneMinute.Add(stzo_stev_override_key)
Events.EveryOneMinute.Add(stzo_stev_override)

end

if getActivatedMods():contains("STEVVPL") and getActivatedMods():contains("STEV") then

function stzo_stev_override()

	local GetVehicleX;
	local GetVehicleY;
	local GetVehicleScript;
	local GetVehicle;
	local GetVehicleTrunk;
	-- Coord Stuff
	-- Rosewood
	local GetRWXMin = 7865;
	local GetRWXMax = 9350;
	local GetRWYMin = 11250;
	local GetRWYMax = 13500;
	-- Riverside
	local GetRSXMin = 3400;
	local GetRSXMax = 7500;
	local GetRSYMin = 5150;
	local GetRSYMax = 6800;
	-- Muldraugh
	local GetMDXMin = 9800;
	local GetMDXMax = 11300;
	local GetMDYMin = 8800;
	local GetMDYMax = 11150;
	-- WestPoint
	local GetWPXMin = 10700;
	local GetWPXMax = 12200;
	local GetWPYMin = 6500;
	local GetWPYMax = 7300;
	-- JeffersonCountySD1
	local GetJCSD1XMin = 12891;
	local GetJCSD1XMax = 14800;
	local GetJCSD1YMin = 2200;
	local GetJCSD1YMax = 2690;
	-- JeffersonCountySD2
	local GetJCSD2XMin = 13771;
	local GetJCSD2XMax = 14800;
	local GetJCSD2YMin = 2691;
	local GetJCSD2YMax = 3440;
	-- JeffersonCountySD3
	local GetJCSD3XMin = 13041;
	local GetJCSD3XMax = 14800;
	local GetJCSD3YMin = 3441;
	local GetJCSD3YMax = 7460;
	-- JeffersonCountyPD1
	local GetJCPD1XMin = 12901;
	local GetJCPD1XMax = 13770;
	local GetJCPD1YMin = 2691;
	local GetJCPD1YMax = 3440;
	-- JeffersonCountyPD2
	local GetJCPD2XMin = 12901;
	local GetJCPD2XMax = 13040;
	local GetJCPD2YMin = 2691;
	local GetJCPD2YMax = 3865;
	-- LouisvillePD1
	local GetLPD1XMin = 11900;
	local GetLPD1XMax = 12900;
	local GetLPD1YMin = 900;
	local GetLPD1YMax = 2190;
	-- LouisvillePD2
	local GetLPD2XMin = 11900;
	local GetLPD2XMax = 12900;
	local GetLPD2YMin = 2191;
	local GetLPD2YMax = 2690;
	-- LouisvillePD3
	local GetLPD3XMin = 11900;
	local GetLPD3XMax = 12660;
	local GetLPD3YMin = 2691;
	local GetLPD3YMax = 3890;
	-- LouisvilleKSP1
	local GetKSP1XMin = 12901;
	local GetKSP1XMax = 14800;
	local GetKSP1YMin = 900;
	local GetKSP1YMax = 2199;
	-- LouisvilleKSP2
	local GetKSP2XMin = 12200;
	local GetKSP2XMax = 13040;
	local GetKSP2YMin = 3891;
	local GetKSP2YMax = 6700;
	-- LouisvilleKSP3
	local GetKSP3XMin = 3500;
	local GetKSP3XMax = 4800;
	local GetKSP3YMin = 7100;
	local GetKSP3YMax = 11000;
	-- Louisville
	local GetLVXMin = 11900;
	local GetLVXMax = 14800;
	local GetLVYMin = 900;
	local GetLVYMax = 3865;
	-- JeffersonCounty
	local GetJCXMin = 12891;
	local GetJCXMax = 14800;
	local GetJCYMin = 2200;
	local GetJCYMax = 7460;
	-- RavenCreek
	local GetRCRXMin = 3000;
	local GetRCRXMax = 5500;
	local GetRCRYMin = 11001;
	local GetRCRYMax = 13500;

	local GetVehicles = getWorld():getCell():getVehicles();

	if GetVehicles ~= nil then
		for i=0, GetVehicles:size()-1 do
			GetVehicleX = GetVehicles:get(i):getX();
			GetVehicleY = GetVehicles:get(i):getY();
			GetVehicleScript = GetVehicles:get(i):getScriptName();
			GetVehicle = GetVehicles:get(i);

			GetVehicleTrunk = GetVehicle:getPartById("TruckBed");

			-- RosewoodSD
			local VehiclesRosewoodSD = {"Base.85crownvic_rosewoodpolice", "Base.87caprice_rosewoodpolice", "Base.91blazer_rosewoodpolice", "Base.CarLightsPolice_rosewoodpolice"};
			local str_rwresult = VehiclesRosewoodSD[ZombRand(1,#VehiclesRosewoodSD+1)];
			-- MeadeCountySO
			local VehiclesMeadeSO = {"Base.85crownvic_meadesheriff", "Base.87caprice_meadesheriff", "Base.CarLightsPolice_meadesheriff"};
			local str_mcresult = VehiclesMeadeSO[ZombRand(1,#VehiclesMeadeSO+1)];
			-- RiversidePD
			local VehiclesRiversidePD = {"Base.85crownvic_riversidepolice", "Base.87caprice_riversidepolice", "Base.CarLightsPolice_riversidepolice"};
			local str_rsresult = VehiclesRiversidePD[ZombRand(1,#VehiclesRiversidePD+1)];
			-- MuldraughPD
			local VehiclesMuldraughPD = {"Base.85crownvic_muldraughpolice", "Base.87caprice_muldraughpolice", "Base.CarLightsPolice_muldraughpolice"};
			local str_mdresult = VehiclesMuldraughPD[ZombRand(1,#VehiclesMuldraughPD+1)];
			-- WestPointPD
			local VehiclesWestPointPD = {"Base.85crownvic_westpointpolice", "Base.87caprice_westpointpolice", "Base.CarLightsPolice_westpointpolice"};
			local str_wpresult = VehiclesWestPointPD[ZombRand(1,#VehiclesWestPointPD+1)];
			-- JeffersonCountySD
			local VehiclesJeffersonSD = {"Base.85crownvic_jeffersonsheriff", "Base.87caprice_jeffersonsheriff", "Base.CarLightsPolice_jeffersonsheriff"};
			local str_jcsdresult = VehiclesJeffersonSD[ZombRand(1,#VehiclesJeffersonSD+1)];
			-- JeffersonCountyPD
			local VehiclesJeffersonPD = {"Base.85crownvic_jeffersonpolice", "Base.87caprice_jeffersonpolice", "Base.CarLightsPolice_jeffersonpolice"};
			local str_jcpdresult = VehiclesJeffersonPD[ZombRand(1,#VehiclesJeffersonPD+1)];
			-- LouisvillePD
			local VehiclesLouisvillePD = {"Base.92crownvic_louisvillepolice", "Base.CarLightsPolice_louisvillepolice"};
			local str_lpdresult = VehiclesLouisvillePD[ZombRand(1,#VehiclesLouisvillePD+1)];
			-- LouisvilleKSP
			local VehiclesLouisvilleKSP = {"Base.85crownvic_kentuckystate", "Base.92crownvic_kentuckystate", "Base.CarLightsPolice_kentuckystate"};
			local str_lkspresult = VehiclesLouisvilleKSP[ZombRand(1,#VehiclesLouisvilleKSP+1)];
			-- RavenCreekPD
			local VehiclesRavenCreekPD = {"Base.85crownvicpdrcr", "Base.87capricepdrcr", "Base.92crownvicpdrcr"};
			local str_rcrpdresult = VehiclesRavenCreekPD[ZombRand(1,#VehiclesRavenCreekPD+1)];
			-- Rangers
			local VehiclesRangers = {"Base.92wranglerranger_NSP", "Base.85crownvicranger_NSP", "Base.91blazerranger_FWS", "Base.85crownvicranger_FWS", "Base.92wranglerranger_FWS", "Base.85crownvicranger_SPR", "Base.CarLights_fishandwildlife", "Base.CarLights_nationalparkservice", "Base.CarLights_stateparkranger"};
			local str_rresult = VehiclesRangers[ZombRand(1,#VehiclesRangers+1)];
			-- LouisvilleFD
			local VehiclesLVFD = {"Base.firepumper_louisville"};
			local str_lvfdresult = VehiclesLVFD[ZombRand(1,#VehiclesLVFD+1)];
			-- RosewoodFD
			local VehiclesRWFD = {"Base.firepumper_rosewood"};
			local str_rwfdresult = VehiclesRWFD[ZombRand(1,#VehiclesRWFD+1)];
			-- MeadeCountyFD
			local VehiclesMCFD = {"Base.firepumper_meade"};
			local str_mcfdresult = VehiclesMCFD[ZombRand(1,#VehiclesMCFD+1)];
			-- LouisvilleEMS
			local VehiclesLVEMS = {"Base.80f350ambulance_louisville", "Base.86econolineambulance_louisville"};
			local str_lvemsresult = VehiclesLVEMS[ZombRand(1,#VehiclesLVEMS+1)];
			-- 	JeffersonCountyEMS
			local VehiclesJCEMS = {"Base.80f350ambulance_jefferson", "Base.86econolineambulance_jefferson"};
			local str_jcemsresult = VehiclesJCEMS[ZombRand(1,#VehiclesJCEMS+1)];
			-- MeadeCountyEMS
			local VehiclesMCEMS = {"Base.80f350ambulance_meade", "Base.86econolineambulance_meade"};
			local str_mcemsresult = VehiclesMCEMS[ZombRand(1,#VehiclesMCEMS+1)];

			-- RosewoodSD
			if GetVehicleX >= GetRWXMin and GetVehicleX <= GetRWXMax and GetVehicleY >= GetRWYMin and GetVehicleY <= GetRWYMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_rwresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- RiversidePD
			elseif GetVehicleX >= GetRSXMin and GetVehicleX <= GetRSXMax and GetVehicleY >= GetRSYMin and GetVehicleY <= GetRSYMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_rsresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- MuldraughPD
			elseif GetVehicleX >= GetMDXMin and GetVehicleX <= GetMDXMax and GetVehicleY >= GetMDYMin and GetVehicleY <= GetMDYMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_mdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- WestPointPD
			elseif GetVehicleX >= GetWPXMin and GetVehicleX <= GetWPXMax and GetVehicleY >= GetWPYMin and GetVehicleY <= GetWPYMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_wpresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- JeffersonCountySD1(North Chunk)
			elseif GetVehicleX >= GetJCSD1XMin and GetVehicleX <= GetJCSD1XMax and GetVehicleY >= GetJCSD1YMin and GetVehicleY <= GetJCSD1YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_jcsresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- JeffersonCountySD2(Middle Chunk)
			elseif GetVehicleX >= GetJCSD2XMin and GetVehicleX <= GetJCSD2XMax and GetVehicleY >= GetJCSD2YMin and GetVehicleY <= GetJCSD2YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_jcsdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- JeffersonCountySD3(South Chunk)
			elseif GetVehicleX >= GetJCSD3XMin and GetVehicleX <= GetJCSD3XMax and GetVehicleY >= GetJCSD3YMin and GetVehicleY <= GetJCSD3YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_jcsdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- JeffersonCountyPD1(North Chunk)
			elseif GetVehicleX >= GetJCPD1XMin and GetVehicleX <= GetJCPD1XMax and GetVehicleY >= GetJCPD1YMin and GetVehicleY <= GetJCPD1YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_jcpdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- JeffersonCountyPD2(South Chunk)
			elseif GetVehicleX >= GetJCPD2XMin and GetVehicleX <= GetJCPD2XMax and GetVehicleY >= GetJCPD2YMin and GetVehicleY <= GetJCPD2YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_jcpdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- LouisvillePD1(North Chunk)
			elseif GetVehicleX >= GetJCSD1XMin and GetVehicleX <= GetLPD1XMax and GetVehicleY >= GetLPD1YMin and GetVehicleY <= GetLPD1YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_lpdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- LouisvillePD2(South Chunk)
			elseif GetVehicleX >= GetLPD2XMin and GetVehicleX <= GetLPD2XMax and GetVehicleY >= GetLPD2YMin and GetVehicleY <= GetLPD2YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_lpdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- LouisvillePD3(Hospital Chunk)
			elseif GetVehicleX >= GetLPD3XMin and GetVehicleX <= GetLPD3XMax and GetVehicleY >= GetLPD3YMin and GetVehicleY <= GetLPD3YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_lpdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- LouisvilleKSP1(Main Area - Louisville)
			elseif GetVehicleX >= GetKSP1XMin and GetVehicleX <= GetKSP1XMax and GetVehicleY >= GetKSP1YMin and GetVehicleY <= GetKSP1YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_lkspresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- LouisvilleKSP2(Louisville Military Blockade)
			elseif GetVehicleX >= GetKSP2XMin and GetVehicleX <= GetKSP2XMax and GetVehicleY >= GetKSP2YMin and GetVehicleY <= GetKSP2YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_lkspresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			--LouisvilleKSP3(Riverside Highway)
			elseif GetVehicleX >= GetKSP3XMin and GetVehicleX <= GetKSP3XMax and GetVehicleY >= GetKSP3YMin and GetVehicleY <= GetKSP3YMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_lkspresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			if getActivatedMods():contains("RavenCreekPDCars") then
			--RavenCreekPD
			elseif GetVehicleX >= GetRCRXMin and GetVehicleX <= GetRCRXMax and GetVehicleY >= GetRCRYMin and GetVehicleY <= GetRCRYMax then
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_rcrpdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			end
			--MeadeCountySO
			else
				if GetVehicleScript == "Base.CarLightsPolice" or GetVehicleScript == "Base.PickUpVanLightsPolice" or GetVehicleScript == "Base.85vicsheriff" or GetVehicleScript == "Base.87capricePD" or GetVehicleScript == "Base.91blazerpd" or GetVehicleScript == "Base.92crownvicPD" or GetVehicleScript == "Base.hmmwvpolice" then
					GetVehicle:setScript(str_mcresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			end
			--Rangers
			if GetVehicleScript == "Base.CarLights" or GetVehicleScript == "Base.85vicranger" or GetVehicleScript == "Base.92wranglerranger" then
					GetVehicle:setScript(str_rresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
			end
			-- Firefighters
			-- LouisvilleFD
			if GetVehicleX >= GetLVXMin and GetVehicleX <= GetLVXMax and GetVehicleY >= GetLVYMin and GetVehicleY <= GetLVYMax then
				if GetVehicleScript == "Base.PickUpTruckLightsFire" or GetVehicleScript == "Base.PickUpVanLightsFire" or GetVehicleScript == "Base.87c10fire" or GetVehicleScript == "Base.firepumper" then
					GetVehicle:setScript(str_lvfdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- RosewoodFD
			elseif GetVehicleX >= GetRWXMin and GetVehicleX <= GetRWXMax and GetVehicleY >= GetRWYMin and GetVehicleY <= GetRWYMax then
				if GetVehicleScript == "Base.PickUpTruckLightsFire" or GetVehicleScript == "Base.PickUpVanLightsFire" or GetVehicleScript == "Base.87c10fire" or GetVehicleScript == "Base.firepumper" then
					GetVehicle:setScript(str_rwfdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- MeadeCountyFD
			else
				if GetVehicleScript == "Base.PickUpTruckLightsFire" or GetVehicleScript == "Base.PickUpVanLightsFire" or GetVehicleScript == "Base.87c10fire" or GetVehicleScript == "Base.firepumper" then
					GetVehicle:setScript(str_mcfdresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			end
			-- EMS
			-- LouisvilleEMS
			if GetVehicleX >= GetLVXMin and GetVehicleX <= GetLVXMax and GetVehicleY >= GetLVYMin and GetVehicleY <= GetLVYMax then
				if GetVehicleScript == "Base.VanAmbulance" or GetVehicleScript == "Base.80f350ambulance" or GetVehicleScript == "Base.86econolineambulance" then
					GetVehicle:setScript(str_lvemsresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- JeffersonCountyEMS
			elseif GetVehicleX >= GetJCXMin and GetVehicleX <= GetJCXMax and GetVehicleY >= GetJCYMin and GetVehicleY <= GetJCYMax then
				if GetVehicleScript == "Base.VanAmbulance" or GetVehicleScript == "Base.80f350ambulance" or GetVehicleScript == "Base.86econolineambulance" then
					GetVehicle:setScript(str_jcemsresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			-- MeadeCountyEMS
			else
				if GetVehicleScript == "Base.VanAmbulance" or GetVehicleScript == "Base.80f350ambulance" or GetVehicleScript == "Base.86econolineambulance" then
					GetVehicle:setScript(str_mcemsresult);
					GetVehicle:scriptReloaded();
					GetVehicle:setNeedPartsUpdate(true);
				end
			end
		end
	end
end

local function stzo_stev_override_keyv()

	local GetKey;
	local GetVehicleName;

	local GetVehicles = getWorld():getCell():getVehicles();

	if GetVehicles ~= nil then
		for i=0, GetVehicles:size()-1 do

		GetKey = GetVehicles:get(i):getCurrentKey();
		GetVehicleName = GetVehicles:get(i):getScriptName();

	if getActivatedMods():contains("STEVLFN") then

		if GetKey ~= nil then
			-- MeadeCountySO
			if GetVehicleName == "Base.85crownvic_meadesheriff" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.87caprice_meadesheriff" then
				if GetKey:getName() ~= "Chevalier Titan Key" then
					GetKey:setName("Chevalier Titan Key");
				end
			-- RiversidePD
			elseif GetVehicleName == "Base.85crownvic_riversidepolice" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.87caprice_riversidepolice" then
				if GetKey:getName() ~= "Chevalier Titan Key" then
					GetKey:setName("Chevalier Titan Key");
				end
			-- RosewoodSD
			elseif GetVehicleName == "Base.85crownvic_rosewoodpolice" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.87caprice_rosewoodpolice" then
				if GetKey:getName() ~= "Chevalier Titan Key" then
					GetKey:setName("Chevalier Titan Key");
				end
			elseif GetVehicleName == "Base.91blazer_rosewoodpolice" then
				if GetKey:getName() ~= "Chevalier Kobold Key" then
					GetKey:setName("Chevalier Kobold Key");
				end
			-- WestPointPD
			elseif GetVehicleName == "Base.85crownvic_westpointpolice" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.87caprice_westpointpolice" then
				if GetKey:getName() ~= "Chevalier Titan Key" then
					GetKey:setName("Chevalier Titan Key");
				end
			-- MuldraughPD
			elseif GetVehicleName == "Base.85crownvic_muldraughpolice" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.87caprice_muldraughpolice" then
				if GetKey:getName() ~= "Chevalier Titan Key" then
					GetKey:setName("Chevalier Titan Key");
				end
			-- JeffersonCountySD
			elseif GetVehicleName == "Base.85crownvic_jeffersonsheriff" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.87caprice_jeffersonsheriff" then
				if GetKey:getName() ~= "Chevalier Titan Key" then
					GetKey:setName("Chevalier Titan Key");
				end
			-- JeffersonCountyPD
			elseif GetVehicleName == "Base.85crownvic_jeffersonpolice" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.87caprice_jeffersonpolice" then
				if GetKey:getName() ~= "Chevalier Titan Key" then
					GetKey:setName("Chevalier Titan Key");
				end
			-- Kentucky State Police
			elseif GetVehicleName == "Base.85crownvic_kentuckystate" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.92crownvic_kentuckystate" then
				if GetKey:getName() ~= "Crest Andarta Key" then
					GetKey:setName("Crest Andarta Key");
				end
			-- LouisvillePD
			elseif GetVehicleName == "Base.92crownvic_louisvillepolice" then
				if GetKey:getName() ~= "Crest Andarta Key" then
					GetKey:setName("Crest Andarta Key");
				end
			-- MeadeCountySO
			elseif GetVehicleName == "Base.CarLightsPolice_meadesheriff" then
				if GetKey:getName() ~= "Chevalier Nyala Key" then
					GetKey:setName("Chevalier Nyala Key");
				end
			-- RiversidePD
			elseif GetVehicleName == "Base.CarLightsPolice_riversidepolice" then
				if GetKey:getName() ~= "Chevalier Nyala Key" then
					GetKey:setName("Chevalier Nyala Key");
				end
			-- RosewoodSD
			elseif GetVehicleName == "Base.CarLightsPolice_rosewoodpolice" then
				if GetKey:getName() ~= "Chevalier Nyala Key" then
					GetKey:setName("Chevalier Nyala Key");
				end
			-- WestPointPD
			elseif GetVehicleName == "Base.CarLightsPolice_westpointpolice" then
				if GetKey:getName() ~= "Chevalier Nyala Key" then
					GetKey:setName("Chevalier Nyala Key");
				end
			-- MuldraughPD
			elseif GetVehicleName == "Base.CarLightsPolice_muldraughpolice" then
				if GetKey:getName() ~= "Chevalier Nyala Key" then
					GetKey:setName("Chevalier Nyala Key");
				end
			-- JeffersonCountySD
			elseif GetVehicleName == "Base.CarLightsPolice_jeffersonsheriff" then
				if GetKey:getName() ~= "Chevalier Nyala Key" then
					GetKey:setName("Chevalier Nyala Key");
				end
			-- JeffersonCountyPD
			elseif GetVehicleName == "Base.CarLightsPolice_jeffersonpolice" then
				if GetKey:getName() ~= "Chevalier Nyala Key" then
					GetKey:setName("Chevalier Nyala Key");
				end
			-- Kentucky State Police
			elseif GetVehicleName == "Base.CarLightsPolice_kentuckystate" then
				if GetKey:getName() ~= "Chevalier Nyala Key" then
					GetKey:setName("Chevalier Nyala Key");
				end
			-- LouisvilleKSP
			elseif GetVehicleName == "Base.CarLightsPolice_louisvillepolice" then
				if GetKey:getName() ~= "Chevalier Nyala Key" then
					GetKey:setName("Chevalier Nyala Key");
				end
			-- Rangers
			elseif GetVehicleName == "Base.92wranglerranger_NSP" then
				if GetKey:getName() ~= "Lark Rancher Key" then
					GetKey:setName("Lark Rancher Key");
				end
			elseif GetVehicleName == "Base.85crownvicranger_NSP" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.91blazerranger_FWS" then
				if GetKey:getName() ~= "Chevalier Kobold Key" then
					GetKey:setName("Chevalier Kobold Key");
				end
			elseif GetVehicleName == "Base.85crownvicranger_FWS" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.92wranglerranger_FWS" then
				if GetKey:getName() ~= "Lark Rancher Key" then
					GetKey:setName("Lark Rancher Key");
				end
			elseif GetVehicleName == "Base.85crownvicranger_SPR" then
				if GetKey:getName() ~= "Franklin Crest Andarta LTD Key" then
					GetKey:setName("Franklin Crest Andarta LTD Key");
				end
			elseif GetVehicleName == "Base.CarLights_fishandwildlife" then
				if GetKey:getName() ~= "Chevalier Nyala Key" then
					GetKey:setName("Chevalier Nyala Key");
				end
			elseif GetVehicleName == "Base.CarLights_nationalparkservice" then
				if GetKey:getName() ~= "Chevalier Nyala Key" then
					GetKey:setName("Chevalier Nyala Key");
				end
			elseif GetVehicleName == "Base.CarLights_stateparkranger" then
				if GetKey:getName() ~= "Chevalier Nyala Key" then
					GetKey:setName("Chevalier Nyala Key");
				end
			elseif GetVehicleName == "Base.firepumper_louisville" then
				if GetKey:getName() ~= "Fire Engine Key" then
					GetKey:setName("Fire Engine Key");
				end
			elseif GetVehicleName == "Base.firepumper_rosewood" then
				if GetKey:getName() ~= "Fire Engine Key" then
					GetKey:setName("Fire Engine Key");
				end
			elseif GetVehicleName == "Base.firepumper_meade" then
				if GetKey:getName() ~= "Fire Engine Key" then
					GetKey:setName("Fire Engine Key");
				end
			elseif GetVehicleName == "Base.80f350ambulance_jefferson" then
				if GetKey:getName() ~= "Franklin EF35 Key" then
					GetKey:setName("Franklin EF35 Key");
				end
			elseif GetVehicleName == "Base.86econolineambulance_jefferson" then
				if GetKey:getName() ~= "Franklin V250 Key" then
					GetKey:setName("Franklin V250 Key");
				end
			elseif GetVehicleName == "Base.80f350ambulance_meade" then
				if GetKey:getName() ~= "Franklin EF35 Key" then
					GetKey:setName("Franklin EF35 Key");
				end
			elseif GetVehicleName == "Base.86econolineambulance_meade" then
				if GetKey:getName() ~= "Franklin V250 Key" then
					GetKey:setName("Franklin V250 Key");
				end
			elseif GetVehicleName == "Base.80f350ambulance_louisville" then
				if GetKey:getName() ~= "Franklin EF35 Key" then
					GetKey:setName("Franklin EF35 Key");
				end
			elseif GetVehicleName == "Base.86econolineambulance_louisville" then
				if GetKey:getName() ~= "Franklin V250 Key" then
					GetKey:setName("Franklin V250 Key");
				end
			end
		end

	elseif getActivatedMods():contains("STEVRN") then

		if GetKey ~= nil then
					-- MeadeCountySO
					if GetVehicleName == "Base.85crownvic_meadesheriff" then
						if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
							GetKey:setName("Ford Crown Victoria LTD Key");
						end
					elseif GetVehicleName == "Base.87caprice_meadesheriff" then
						if GetKey:getName() ~= "Chevrolet Caprice Key" then
							GetKey:setName("Chevrolet Caprice Key");
						end
					-- RiversidePD
					elseif GetVehicleName == "Base.85crownvic_riversidepolice" then
						if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
							GetKey:setName("Ford Crown Victoria LTD Key");
						end
					elseif GetVehicleName == "Base.87caprice_riversidepolice" then
						if GetKey:getName() ~= "Chevrolet Caprice Key" then
							GetKey:setName("Chevrolet Caprice Key");
						end
					-- RosewoodSD
					elseif GetVehicleName == "Base.85crownvic_rosewoodpolice" then
						if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
							GetKey:setName("Ford Crown Victoria LTD Key");
						end
					elseif GetVehicleName == "Base.87caprice_rosewoodpolice" then
						if GetKey:getName() ~= "Chevrolet Caprice Key" then
							GetKey:setName("Chevrolet Caprice Key");
						end
					elseif GetVehicleName == "Base.91blazer_rosewoodpolice" then
						if GetKey:getName() ~= "Chevrolet Blazer Key" then
							GetKey:setName("Chevrolet Blazer Key");
						end
					-- WestPointPD
					elseif GetVehicleName == "Base.85crownvic_westpointpolice" then
						if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
							GetKey:setName("Ford Crown Victoria LTD Key");
						end
					elseif GetVehicleName == "Base.87caprice_westpointpolice" then
						if GetKey:getName() ~= "Chevrolet Caprice Key" then
							GetKey:setName("Chevrolet Caprice Key");
						end
					-- MuldraughPD
					elseif GetVehicleName == "Base.85crownvic_muldraughpolice" then
						if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
							GetKey:setName("Ford Crown Victoria LTD Key");
						end
					elseif GetVehicleName == "Base.87caprice_muldraughpolice" then
						if GetKey:getName() ~= "Chevrolet Caprice Key" then
							GetKey:setName("Chevrolet Caprice Key");
						end
					-- JeffersonCountySD
					elseif GetVehicleName == "Base.85crownvic_jeffersonsheriff" then
						if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
							GetKey:setName("Ford Crown Victoria LTD Key");
						end
					elseif GetVehicleName == "Base.87caprice_jeffersonsheriff" then
						if GetKey:getName() ~= "Chevrolet Caprice Key" then
							GetKey:setName("Chevrolet Caprice Key");
						end
					-- JeffersonCountyPD
					elseif GetVehicleName == "Base.85crownvic_jeffersonpolice" then
						if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
							GetKey:setName("Ford Crown Victoria LTD Key");
						end
					elseif GetVehicleName == "Base.87caprice_jeffersonpolice" then
						if GetKey:getName() ~= "Chevrolet Caprice Key" then
							GetKey:setName("Chevrolet Caprice Key");
						end
					-- Kentucky State Police
					elseif GetVehicleName == "Base.85crownvic_kentuckystate" then
						if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
							GetKey:setName("Ford Crown Victoria LTD Key");
						end
					elseif GetVehicleName == "Base.92crownvic_kentuckystate" then
						if GetKey:getName() ~= "Crown Victoria Key" then
							GetKey:setName("Crown Victoria Key");
						end
					-- LouisvillePD
					elseif GetVehicleName == "Base.92crownvic_louisvillepolice" then
						if GetKey:getName() ~= "Crown Victoria Key" then
							GetKey:setName("Crown Victoria Key");
						end
					-- MeadeCountySO
					elseif GetVehicleName == "Base.CarLightsPolice_meadesheriff" then
						if GetKey:getName() ~= "Chevalier Nyala Key" then
							GetKey:setName("Chevalier Nyala Key");
						end
					-- RiversidePD
					elseif GetVehicleName == "Base.CarLightsPolice_riversidepolice" then
						if GetKey:getName() ~= "Chevalier Nyala Key" then
							GetKey:setName("Chevalier Nyala Key");
						end
					-- RosewoodSD
					elseif GetVehicleName == "Base.CarLightsPolice_rosewoodpolice" then
						if GetKey:getName() ~= "Chevalier Nyala Key" then
							GetKey:setName("Chevalier Nyala Key");
						end
					-- WestPointPD
					elseif GetVehicleName == "Base.CarLightsPolice_westpointpolice" then
						if GetKey:getName() ~= "Chevalier Nyala Key" then
							GetKey:setName("Chevalier Nyala Key");
						end
					-- MuldraughPD
					elseif GetVehicleName == "Base.CarLightsPolice_muldraughpolice" then
						if GetKey:getName() ~= "Chevalier Nyala Key" then
							GetKey:setName("Chevalier Nyala Key");
						end
					-- JeffersonCountySD
					elseif GetVehicleName == "Base.CarLightsPolice_jeffersonsheriff" then
						if GetKey:getName() ~= "Chevalier Nyala Key" then
							GetKey:setName("Chevalier Nyala Key");
						end
					-- JeffersonCountyPD
					elseif GetVehicleName == "Base.CarLightsPolice_jeffersonpolice" then
						if GetKey:getName() ~= "Chevalier Nyala Key" then
							GetKey:setName("Chevalier Nyala Key");
						end
					-- Kentucky State Police
					elseif GetVehicleName == "Base.CarLightsPolice_kentuckystate" then
						if GetKey:getName() ~= "Chevalier Nyala Key" then
							GetKey:setName("Chevalier Nyala Key");
						end
					-- LouisvilleKSP
					elseif GetVehicleName == "Base.CarLightsPolice_louisvillepolice" then
						if GetKey:getName() ~= "Chevalier Nyala Key" then
							GetKey:setName("Chevalier Nyala Key");
						end
					-- Rangers
					elseif GetVehicleName == "Base.92wranglerranger_NSP" then
						if GetKey:getName() ~= "Jeep Wrangler Key" then
							GetKey:setName("Jeep Wrangler Key");
						end
					elseif GetVehicleName == "Base.85crownvicranger_NSP" then
						if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
							GetKey:setName("Ford Crown Victoria LTD Key");
						end
					elseif GetVehicleName == "Base.91blazerranger_FWS" then
						if GetKey:getName() ~= "Chevrolet Blazer Key" then
							GetKey:setName("Chevrolet Blazer Key");
						end
					elseif GetVehicleName == "Base.85crownvicranger_FWS" then
						if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
							GetKey:setName("Ford Crown Victoria LTD Key");
						end
					elseif GetVehicleName == "Base.92wranglerranger_FWS" then
						if GetKey:getName() ~= "Jeep Wrangler Key" then
							GetKey:setName("Jeep Wrangler Key");
						end
					elseif GetVehicleName == "Base.85crownvicranger_SPR" then
						if GetKey:getName() ~= "Ford Crown Victoria LTD Key" then
							GetKey:setName("Ford Crown Victoria LTD Key");
						end
					elseif GetVehicleName == "Base.CarLights_fishandwildlife" then
						if GetKey:getName() ~= "Chevalier Nyala Key" then
							GetKey:setName("Chevalier Nyala Key");
						end
					elseif GetVehicleName == "Base.CarLights_nationalparkservice" then
						if GetKey:getName() ~= "Chevalier Nyala Key" then
							GetKey:setName("Chevalier Nyala Key");
						end
					elseif GetVehicleName == "Base.CarLights_stateparkranger" then
						if GetKey:getName() ~= "Chevalier Nyala Key" then
							GetKey:setName("Chevalier Nyala Key");
						end
					elseif GetVehicleName == "Base.firepumper_louisville" then
						if GetKey:getName() ~= "Fire Engine Key" then
							GetKey:setName("Fire Engine Key");
						end
					elseif GetVehicleName == "Base.firepumper_rosewood" then
						if GetKey:getName() ~= "Fire Engine Key" then
							GetKey:setName("Fire Engine Key");
						end
					elseif GetVehicleName == "Base.firepumper_meade" then
						if GetKey:getName() ~= "Fire Engine Key" then
							GetKey:setName("Fire Engine Key");
						end
					elseif GetVehicleName == "Base.80f350ambulance_jefferson" then
						if GetKey:getName() ~= "Ford F350 Key" then
							GetKey:setName("Ford F350 Key");
						end
					elseif GetVehicleName == "Base.86econolineambulance_jefferson" then
						if GetKey:getName() ~= "Ford E350 Key" then
							GetKey:setName("Ford E350 Key");
						end
					elseif GetVehicleName == "Base.80f350ambulance_meade" then
						if GetKey:getName() ~= "Ford F350 Key" then
							GetKey:setName("Ford F350 Key");
						end
					elseif GetVehicleName == "Base.86econolineambulance_meade" then
						if GetKey:getName() ~= "Ford E350 Key" then
							GetKey:setName("Ford E350 Key");
						end
					elseif GetVehicleName == "Base.80f350ambulance_louisville" then
						if GetKey:getName() ~= "Ford F350 Key" then
							GetKey:setName("Ford F350 Key");
						end
					elseif GetVehicleName == "Base.86econolineambulance_louisville" then
						if GetKey:getName() ~= "Ford E350 Key" then
							GetKey:setName("Ford E350 Key");
						end
					end
				end
			end
		end
	end
end

Events.EveryOneMinute.Add(stzo_stev_override_keyv)
Events.EveryOneMinute.Add(stzo_stev_override)

end
