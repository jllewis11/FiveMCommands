local j = nil

local teams = {
    {name = "enemies", model = {"g_m_m_chicold_01","g_m_y_ballasout_01","g_m_y_pologoon_01","g_m_y_mexgoon_01"}, weapon = "WEAPON_MACHINEPISTOL"}, 
    
}

local group = {
    {name = "rioters", model = {"a_m_y_breakdance_01", "a_m_y_salton_01", "a_f_m_trampbeac_01","a_f_y_eastsa_01"}, weapon = {"WEAPON_BAT", "WEAPON_GOLFCLUB", "WEAPON_POOLCUE"} }

}



RegisterNetEvent('Event:Riot')
AddEventHandler('Event:Riot', function(source, args)
	AddRelationshipGroup('team1')
	AddRelationshipGroup('team2')
	AddRelationshipGroup('team3')
	-- Team1 is Violent rioters
	-- Team2 is Player
	-- Team3 is Non-violent protestors
	SetRelationshipBetweenGroups(5, 'team1', 'team2')
	SetRelationshipBetweenGroups(5, 'team2', 'team1')
	SetRelationshipBetweenGroups(1, 'team3', 'team1')
	SetRelationshipBetweenGroups(1, 'team3', 'team2')
	SetRelationshipBetweenGroups(1, 'team1', 'team3')
	SetRelationshipBetweenGroups(1, 'team2', 'team3')
	NetworkSetFriendlyFireOption(false)
	SetPedRelationshipGroupHash(GetHashKey("PLAYER"), 'team2')
	
	
	local totalPeople = tonumber(args[1])
	for i=1, totalPeople, 1 
	do
		local ped = GetHashKey(group[1].model[math.random(1,4)])
		RequestModel(ped)
		while not HasModelLoaded(ped) do 
			Citizen.Wait(1)
		end
		local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
		newPed = CreatePed(4, ped, x+math.random(-totalPeople,totalPeople),y,z , 0.0 , false, true)
	
		SetPedCombatAttributes(newPed, 0, true)
		SetPedCombatAttributes(newPed, 5, true)
		SetPedCombatAttributes(newPed, 46, true)
		SetPedFleeAttributes(newPed, 0, true)
		SetPedAsGroupMember(newPed, 2)
		if (math.random(0,10) < 3)
		then
			SetPedRelationshipGroupHash(newPed, 'team1')
			if (math.random(0,10) < 6)
			then
				local c = math.random(1,3)
				GiveWeaponToPed(newPed, GetHashKey(group[1].weapon[c]), 2000, true, false)
			end
		else
			SetPedRelationshipGroupHash(newPed, 'team3')        
		end
		SetPedArmour(newPed, 100)
		SetPedMaxHealth(newPed, 100)
		TaskGoStraightToCoord(newPed, x + math.random(-10, 10),y,z + math.random(-10, 10),100,1000,0,0)
	end
end)


RegisterNetEvent('Event:Ambush')
AddEventHandler('Event:Ambush', function(source, args)
	AddRelationshipGroup('team1')
	AddRelationshipGroup('team2')
	SetRelationshipBetweenGroups(5, 'team1', 'team2')
	SetRelationshipBetweenGroups(5, 'team2', 'team1')
	NetworkSetFriendlyFireOption(false)
	SetPedRelationshipGroupHash(GetHashKey("PLAYER"), 'team2')
	
	
	local totalPeople = tonumber(args[1])
	for i=1, totalPeople, 1 
	do
		local ped = GetHashKey(teams[1].model[math.random(1,4)])
		RequestModel(ped)
		while not HasModelLoaded(ped) do 
			Citizen.Wait(1)
		end
		local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
		newPed = CreatePed(4, ped, x+math.random(-totalPeople,totalPeople),y,z + math.random(-totalPeople,totalPeople), 0.0 , false, true)
	
		SetPedCombatAttributes(newPed, 0, true)
		SetPedCombatAttributes(newPed, 5, true)
		SetPedCombatAttributes(newPed, 46, true)
		SetPedFleeAttributes(newPed, 0, true)
		SetPedAsGroupMember(newPed, 2)
		SetPedRelationshipGroupHash(newPed, 'team1')
		SetRelationshipBetweenGroups(5, GetHashKey(teams[1].name), GetHashKey("PLAYER"))
		GiveWeaponToPed(newPed, GetHashKey(teams[1].weapon), 2000, true, false)
		SetPedArmour(newPed, 100)
		SetPedMaxHealth(newPed, 100)
		TaskGoStraightToCoord(newPed, x,y,z,100,1000,0,0)
	end
end)