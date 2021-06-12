
local j = nil

local teams = {
    {name = "enemies", model = "g_m_m_chicold_01", weapon = "WEAPON_MACHINEPISTOL"}, 
    
}

RegisterCommand("convoy", function (source, args)
	AddRelationshipGroup('team1')
	AddRelationshipGroup('team2')

	SetRelationshipBetweenGroups(5, 'team1', 'team2')
	SetRelationshipBetweenGroups(5, 'team2', 'team1')
	NetworkSetFriendlyFireOption(false)
	SetPedRelationshipGroupHash(GetHashKey("PLAYER"), 'team2')
	
	
    local totalPeople = tonumber(args[1])
    for i=1, totalPeople, 1 
	do
        local ped = GetHashKey(teams[1].model)
        -- preload the model
        RequestModel(ped)
        while not HasModelLoaded(ped) do 
            Citizen.Wait(1)
        end
        -- get the source's coords
        local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
        -- refer to ped types here under "PedTypes" -> https://runtime.fivem.net/doc/natives/#_0xD49F9B0955C367DE
        newPed = CreatePed(4, ped, x+100+math.random(-totalPeople,totalPeople),y+100+math.random(-totalPeople,totalPeople),z , 0.0 , false, true)
        --- now lets give the ped some attributes -> https://runtime.fivem.net/doc/natives/#_0x9F7794730795E019
        SetPedCombatAttributes(newPed, 0, true) --[[ BF_CanUseCover ]]
        SetPedCombatAttributes(newPed, 5, true) --[[ BF_CanFightArmedPedsWhenNotArmed ]]
        SetPedCombatAttributes(newPed, 46, true) --[[ BF_AlwaysFight ]]
        SetPedFleeAttributes(newPed, 0, true) --[[ allows/disallows the ped to flee from a threat i think]]
		SetPedAsGroupMember(newPed, 2)
		SetPedRelationshipGroupHash(newPed, 'team1')
        SetRelationshipBetweenGroups(5, GetHashKey(teams[1].name), GetHashKey("PLAYER"))
        GiveWeaponToPed(newPed, GetHashKey(teams[1].weapon), 2000, true, false)
        SetPedArmour(newPed, 100)
        SetPedMaxHealth(newPed, 100)
		TaskGoStraightToCoord(newPed, x,y,z,100,5000,0,0)
    end


end)
