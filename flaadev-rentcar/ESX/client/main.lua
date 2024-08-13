local ESX = exports["es_extended"]:getSharedObject()

local alreadySpawned = false
local rentedCar = 0
local currentCar = 0

local Peds = {}
local blips = {}
local carBlip = 0

Citizen.CreateThread(function()
    RequestModel(Config.pedModel)
    while not HasModelLoaded(Config.pedModel) do
        Wait(1)
    end

    for i, target in pairs(Config.pzones) do
        local coord = target.pedLocation
        Peds[i] = CreatePed(2, Config.pedModel, coord.x, coord.y, coord.z - 1, coord.w, 0, 0)
        FreezeEntityPosition(Peds[i], true)
        SetBlockingOfNonTemporaryEvents(Peds[i], true)
        SetEntityInvincible(Peds[i], true)
        TaskStartScenarioInPlace(Peds[i], "WORLD_HUMAN_CLIPBOARD_FACILITY", -1, 0)

        blips = { coord }
        blips.blip = AddBlipForCoord(coord.x, coord.y, coord.z)
        SetBlipSprite(blips.blip, Config.blip.id)
        SetBlipDisplay(blips.blip, 4)
        SetBlipScale(blips.blip, .7)
        SetBlipColour(blips.blip, Config.blip.color)
        SetBlipAsShortRange(blips.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.blip.name)
        EndTextCommandSetBlipName(blips.blip)
    end

    while true do
        Wait(1)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local vehspawnloc = 0

        for i, target in pairs(Config.pzones) do
            while #(playerCoords - vector3(target.pedLocation.x, target.pedLocation.y, target.pedLocation.z)) < Config.rentZoneDiameter and not IsPedInAnyVehicle(playerPed, false) do
                Wait(1)
                vehspawnloc = target.vehspawnloc
                playerCoords = GetEntityCoords(playerPed)
                ESX.ShowHelpNotification(_U("rentCar"), true)
                if IsControlJustPressed(1, 38) then
                    ESX.UI.Menu.Open(
                        "default",
                        GetCurrentResourceName(),
                        "rental_menu",
                        {
                            title = _U("rentalMenuHeader"),
                            align = "center",
                            elements = Config.cars
                        },
                        function(data, menu)
                            local price = data.current.price
                            local car  = data.current.isCar
                            local type = data.current.id
                            if type == false then
                                if alreadySpawned then
                                    ESX.TriggerServerCallback("flaadev-rental:server:PayRental", function(result)
                                        if result then
                                            ESX.TriggerServerCallback("flaadev-rental:server:CheckPaper", function(result)
                                            end)
                                            ESX.ShowNotification(_U("loostVehicle"), "error")
                                            alreadySpawned = false
                                            menu.close()
                                        else
                                            ESX.ShowNotification(_U("enoughCash"), "error")
                                        end
                                    end, price)
                                else
                                    ESX.ShowNotification(_U("didnotRent"), "error")
                                end
                            else
                                if alreadySpawned then
                                    ESX.ShowNotification(_U("alreadyRented"), "error")
                                else
                                    ESX.TriggerServerCallback("flaadev-rental:server:CheckLicense", function(result2)
                                        if result2 == 1 then
                                            ESX.TriggerServerCallback("flaadev-rental:server:PayRental", function(result)
                                                if result then
                                                    ESX.Game.SpawnVehicle(type, vector3(vehspawnloc.x, vehspawnloc.y, vehspawnloc.z),
                                                        vehspawnloc.w, function(veh)
                                                        rentedCar = veh

                                                        TaskWarpPedIntoVehicle(playerPed, veh, -1)

                                                        carBlip = AddBlipForEntity(veh)
                                                        if car then
                                                            SetBlipSprite(carBlip, Config.carBlip.carID)
                                                        else
                                                            SetBlipSprite(carBlip, Config.carBlip.motorID)
                                                        end
                                                        SetBlipDisplay(carBlip, 4)
                                                        SetBlipScale(carBlip, .7)
                                                        SetBlipColour(carBlip, Config.carBlip.color)
                                                        SetBlipAsShortRange(carBlip, true)
                                                        BeginTextCommandSetBlipName("STRING")
                                                        AddTextComponentString(Config.carBlip.name)
                                                        EndTextCommandSetBlipName(carBlip)
                                                    end)
                                                    alreadySpawned = true
                                                    menu.close()
                                                    ESX.ShowNotification(_U("rented"), "success")
                                                end
                                            end, price)
                                        elseif result2 == 2 then
                                            ESX.ShowNotification(_U("enoughCash"), "error")
                                        elseif result2 == 3 then
                                            ESX.ShowNotification(_U("noDrivingLicense"), "error")
                                        elseif result2 == 4 then
                                            ESX.ShowNotification(_U("space"), "error")
                                        end
                                    end, price)
                                end
                            end
                        end,
                        function(data, menu)
                            menu.close()
                        end
                    )
                end
            end

            while #(playerCoords - vector3(target.vehspawnloc.x, target.vehspawnloc.y, target.vehspawnloc.z)) < Config.returnZoneDiameter and IsPedInAnyVehicle(playerPed, false) and alreadySpawned do
                Wait(1)
                playerCoords = GetEntityCoords(playerPed)
                ESX.ShowHelpNotification(_U("returnCar"), true)
                if IsControlJustPressed(1, 38) then
                    currentCar = GetVehiclePedIsUsing(playerPed)
                    if GetVehicleNumberPlateText(currentCar) == GetVehicleNumberPlateText(rentedCar) then
                        ESX.TriggerServerCallback("flaadev-rental:server:CheckPaper", function(result)
                            if result then
                                local seat = GetPedInVehicleSeat(rentedCar, -1)
                                local playerPed = PlayerPedId()
                                if seat == playerPed then
                                    TaskLeaveVehicle(seat, rentedCar, 0)
                                    ESX.ShowNotification(_U("back"), "success")
                                    Wait(2000)
                                    ESX.Game.DeleteVehicle(rentedCar)
                                    alreadySpawned = false
                                else
                                    ESX.ShowNotification(_U("beDriver"), "error")
                                end
                            else
                                ESX.UI.Menu.Open(
                                    "default",
                                    GetCurrentResourceName(),
                                    "rental_menu",
                                    {
                                        title = _U("feesMenuHeader"),
                                        align = "center",
                                        elements = Config.cancelMenu
                                    },
                                    function(data, menu)
                                        local price = data.current.price
                                        if price == 0 then
                                            menu.close()
                                        else
                                            ESX.TriggerServerCallback("flaadev-rental:server:PayRental", function(result)
                                                if result then
                                                    local seat = GetPedInVehicleSeat(rentedCar, -1)
                                                    local playerPed = PlayerPedId()
                                                    if seat == playerPed then
                                                        TaskLeaveVehicle(seat, rentedCar, 0)
                                                        ESX.ShowNotification(_U("back"), "success")
                                                        Wait(2000)
                                                        ESX.Game.DeleteVehicle(rentedCar)
                                                        alreadySpawned = false
                                                    else
                                                        ESX.ShowNotification(_U("beDriver"), "error")
                                                    end
                                                    menu.close()
                                                else
                                                    ESX.ShowNotification(_U("enoughCash"), "error")
                                                end
                                            end, price)
                                            menu.close()
                                        end
                                    end,
                                    function(data, menu)
                                        menu.close()
                                    end
                                )
                            end
                        end)
                    else
                        ESX.ShowNotification(_U("notTheCar"), "error")
                    end
                end
            end
        end
    end
end)