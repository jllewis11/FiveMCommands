RegisterCommand("riot", function (source, args, rawCommand)
    if IsPlayerAceAllowed(source, 'event.riot') then
        TriggerClientEvent("Event:Riot", -1, source, args)
    else
        TriggerClientEvent("chatMessage", source, "^*^1Insufficient Permissions.")
    end
end)

RegisterCommand("ambush", function (source, args, rawCommand)
    if IsPlayerAceAllowed(source, 'event.ambush') then 
        TriggerClientEvent("Event:Ambush", -1, source, args)
    else
        TriggerClientEvent("chatMessage", source, "^*^1Insufficient Permissions.")
    end
end)