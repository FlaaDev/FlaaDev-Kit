local QBCore = exports['qb-core']:GetCoreObject()

local hash = Shared.pedModel
local targets = Shared.pzones
local blipInfo = {
    name = Shared.blip.name,
    color = Shared.blip.color,
    id = Shared.blip.id
}
local cars = Shared.cars

local alreadySpawned = false
local rentedCar = 0
local currentCar = 0

local Peds = {}
local blips = {}
local carlist = {}
local feeslist = {}

RegisterNetEvent("flaadev-rental:client:RentCar", function(data)
    local vehspawnloc = data.location
    local price = data.price
    local type = data.type
    if alreadySpawned then
        QBCore.Functions.Notify(Lang:t("error.alreadyRented"), "error")
    else
        QBCore.Functions.TriggerCallback("flaadev-rental:server:CheckLicense", function(result2)
            if result2 == 1 then
                QBCore.Functions.TriggerCallback("flaadev-rental:server:PayRental", function(result)
                    if result then
                        QBCore.Functions.SpawnVehicle(type, function(veh)
                            TriggerServerEvent("qb-vehiclekeys:server:AcquireVehicleKeys",
                                GetVehicleNumberPlateText(veh))
                            SetVehicleEngineOn(veh, true, true)
                            rentedCar = veh
                        end, vehspawnloc, true, true)
                        alreadySpawned = true
                        QBCore.Functions.Notify(Lang:t("success.rented"), "success")
                    else
                        QBCore.Functions.Notify(Lang:t("error.enoughCash"), "error")
                    end
                end, price)
            elseif result2 == 2 then
                QBCore.Functions.Notify(Lang:t("error.fakeDrivingLicense"), "error")
            elseif result2 == 4 then
                QBCore.Functions.Notify(Lang:t("error.space"), "error")
            else
                QBCore.Functions.Notify(Lang:t("error.noDrivingLicense"), "error")
            end
        end)
    end
    carlist = {}
end)

RegisterNetEvent("flaadev-rental:client:RentMenu", function(data)
    local vehspawnloc = data.args[1]
    carlist[#carlist + 1] = {
        isMenuHeader = true,
        header = Lang:t("info.rentalMenuHeader"),
        icon = 'fas fa-car'
    }
    for k, car in pairs(cars) do
        if car.isCar then
            carlist[#carlist + 1] = {
                header = car.name .. " - $" .. tostring(car.price),
                txt = car.text,
                icon = 'fas fa-car',
                params = {
                    event = 'flaadev-rental:client:RentCar',
                    args = { location = vehspawnloc, type = car.id, price = car.price }
                }
            }
        else
            carlist[#carlist + 1] = {
                header = car.name .. " - $" .. tostring(car.price),
                txt = car.text,
                icon = 'fa-solid fa-motorcycle',
                params = {
                    event = 'flaadev-rental:client:RentCar',
                    args = { location = vehspawnloc, type = car.id, price = car.price }
                }
            }
        end
    end
    carlist[#carlist + 1] = {
        header = Lang:t("info.lostVehicle")..tostring(Shared.carFeesPrice),
        txt = Lang:t("info.payFees"),
        icon = 'fa-solid fa-car-burst',
        params = {
            event = 'flaadev-rental:client:carFeesPayment',
            args = {price = Shared.carFeesPrice}
        }
    }
    carlist[#carlist + 1] = {
        header = Lang:t("info.close"),
        txt = "",
        icon = 'fa-regular fa-circle-xmark',
        params = {
            event = 'flaadev-rental:client:closeMenu',
            args = {}
        }
    }
    exports['qb-menu']:openMenu(carlist)
end)

RegisterNetEvent("flaadev-rental:client:carFeesPayment", function(data)
    local price = data.price
    if alreadySpawned then
        QBCore.Functions.TriggerCallback("flaadev-rental:server:PayRental", function (result)
            if result then
                QBCore.Functions.TriggerCallback("flaadev-rental:server:CheckPaper", function (result)
                end)
                QBCore.Functions.Notify(Lang:t("warning.lostVehicle"), "warning")
                alreadySpawned = false
            else
                QBCore.Functions.Notify(Lang:t("error.enoughCash"), "error")
            end
        end, price)
    else
        QBCore.Functions.Notify(Lang:t("error.didnotRent"), "error")
    end
    carlist = {}
end)


local function returningCar()
    local seat = GetPedInVehicleSeat(rentedCar, -1)
    local playerPed = PlayerPedId()
    if seat == playerPed then
        TaskLeaveVehicle(seat, rentedCar, 0)
        exports['qb-core']:HideText()
        QBCore.Functions.Notify(Lang:t("success.back"), "success")
        Wait(2000)
        QBCore.Functions.DeleteVehicle(rentedCar)
        alreadySpawned = false
    else
        QBCore.Functions.Notify(Lang:t("error.beDriver"), "error")
    end
    feeslist = {}
end

RegisterNetEvent("flaadev-rental:client:paperFeesPayment", function(data)
    local price = data.price
    QBCore.Functions.TriggerCallback("flaadev-rental:server:PayRental", function (result)
        if result then
            returningCar()
        else
            QBCore.Functions.Notify(Lang:t("error.enoughCash"), "error")
        end
    end, price)
    feeslist = {}
end)

local function lostRentalFees()
    feeslist[#feeslist + 1] = {
        isMenuHeader = true,
        header = Lang:t("info.feesMenuHeader"),
        icon = 'fa-solid fa-file-circle-xmark'
    }
    feeslist[#feeslist + 1] = {
        header = Lang:t("info.payRentalFees")..tostring(Shared.rentalFeesPrice),
        txt = "",
        icon = 'fa-solid fa-money-bill-wave',
        params = {
            event = 'flaadev-rental:client:paperFeesPayment',
            args = {price = Shared.rentalFeesPrice}
        }
    }
    feeslist[#feeslist + 1] = {
        header = Lang:t("info.close"),
        txt = "",
        icon = 'fa-regular fa-circle-xmark',
        params = {
            event = 'flaadev-rental:client:closeMenu',
            args = {}
        }
    }
    exports['qb-menu']:openMenu(feeslist)
end

RegisterNetEvent("flaadev-rental:client:closeMenu", function(data)
    carlist = {}
    feeslist = {}
end)

Citizen.CreateThread(function()
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(1)
    end
    
    for i, target in pairs(targets) do
        local coord = target.pedLocation
        Peds[i] = CreatePed(2, hash, coord.x, coord.y, coord.z - 1, coord.w, 0, 0)
        FreezeEntityPosition(Peds[i], true)
        SetBlockingOfNonTemporaryEvents(Peds[i], true)
        SetEntityInvincible(Peds[i], true)
        TaskStartScenarioInPlace(Peds[i], "WORLD_HUMAN_CLIPBOARD_FACILITY", -1, 0)

        blips = { coord }
        blips.blip = AddBlipForCoord(coord.x, coord.y, coord.z)
        SetBlipSprite(blips.blip, blipInfo.id)
        SetBlipDisplay(blips.blip, 4)
        SetBlipScale(blips.blip, .7)
        SetBlipColour(blips.blip, blipInfo.color)
        SetBlipAsShortRange(blips.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipInfo.name)
        EndTextCommandSetBlipName(blips.blip)

        exports['qb-target']:AddBoxZone("flaadev-rentcar:ped" .. tostring(i), target.pzvect, target.wid, target.hig, {
                name = "flaadev-rentcar:ped" .. tostring(i),
                heading = target.heading,
                debugPoly = false,
                minZ = target.minZ,
                maxZ = target.maxZ,
            },
            {
                options = {
                    {
                        type  = "client",
                        event = "flaadev-rental:client:RentMenu",
                        args  = { target.vehspawnloc },
                        icon  = 'fas fa-car',
                        label = Lang:t("info.rentalMenuHeader"),
                    }
                },
                distance = 2.5,
            }
        )
    end

    while true do
        Wait(1)
        carlist = {}
        feeslist = {}
        while alreadySpawned do
            Wait(1)
            carlist = {}
            feeslist = {}
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            for i, target in pairs(targets) do
                while #(playerCoords - vector3(target.vehspawnloc.x, target.vehspawnloc.y, target.vehspawnloc.z)) < Shared.zoneDiameter do
                    Wait(1)
                    carlist = {}
                    feeslist = {}
                    playerCoords = GetEntityCoords(playerPed)
                    if IsPedInAnyVehicle(playerPed, false) then
                        exports['qb-core']:DrawText(Lang:t("info.returnCar"), 'left')
                        if IsControlJustPressed(1, 38) then
                            currentCar = GetVehiclePedIsUsing(playerPed)
                            if GetVehicleNumberPlateText(currentCar) == GetVehicleNumberPlateText(rentedCar) then
                                QBCore.Functions.TriggerCallback("flaadev-rental:server:CheckPaper", function(result)
                                    if result then
                                        returningCar()
                                    else
                                        lostRentalFees()
                                    end
                                end)
                            else
                                QBCore.Functions.Notify(Lang:t("error.notTheCar"), "error")
                            end
                        end
                    else
                        exports['qb-core']:HideText()
                    end
                end
                exports['qb-core']:HideText()
            end
        end
    end
end)