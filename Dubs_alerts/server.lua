-----------------------------------------------------------
---				          OlIvEr_ALERT					              ---
---			        MADE FOR ENERGYNETWORK			   	        ---
----------------------------------------------------------- 

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","OlIvEr_dispatch")

RegisterServerEvent('dispatch')
AddEventHandler('dispatch', function(dabs, street, playerCoords, vehicleLabel)
  Citizen.Wait(1500)
  local players = {}
  local users = vRP.getUsers({})
  local isPolice = false
  local isEMS = false

    for k,v in pairs(users) do
      
        local player = vRP.getUserSource({k})
        
        if player ~= nil then
          local user_id = vRP.getUserId({player})

          isPolice = vRP.hasGroup({user_id,"Politi-Job"})
          isEMS = vRP.hasGroup({user_id,"EMS-Job"})
          if isPolice then
            if dabs == "Skud affyret" or dabs == "Volds person" or dabs == "Biltyveri" or dabs == "Driveby" or dabs == "Husrøveri" then
            table.insert(players,player)
            end
          elseif isEMS then
            if dabs == "Omkommet" then
            table.insert(players,player)
            end
          end
        end
  end


for k,v in pairs(players) do
    if dabs == "Volds person" then
      data = {["code"] = 'VOLD', ["name"] = "Voldlig person!", ["loc"] = street}
      mytype = 'police'
    elseif dabs == "Husrøveri" then
      mytype = 'police'
      data = {["code"] = 'BILTØVERI', ["name"] = "Husrøveri!", ["loc"] = street}
    elseif dabs == "Skud affyret" then
      mytype = 'police'
      data = {["code"] = 'SKUD', ["name"] = "Skud affyret!", ["loc"] = street}
    elseif dabs == "Biltyveri" then
      mytype = 'police'
      data = {["code"] = 'BILTØVERI', ["name"] = "Biltyveri rappoteret!",  ["loc"] = street}
    elseif dabs == "Driveby" then
      mytype = 'police'
      data = {["code"] = '10-16', ["name"] = "Driveby Skydning!", ["loc"] = street}

    elseif dabs == "Omkommet" then
      mytype = 'ems'
      data = {["code"] = '10-omkommet', ["name"] = "Person bevidstløs!", ["loc"] = street}
  end
    length = 8500
    TriggerClientEvent('esx_outlawalert:outlawNotify', v, mytype, data, length)
    TriggerClientEvent('notifyDispatch', v, playerCoords, dabs)
end
  
end)

