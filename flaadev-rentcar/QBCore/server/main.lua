local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("flaadev-rental:server:PayRental", function (source, cb, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney("cash", price, "Paid for car rental.") then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback("flaadev-rental:server:CheckLicense", function (source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Shared.licenseItemName
    local paper = Shared.rentalPaperName
    local licensesFound = exports['qb-inventory']:GetItemsByName(src, item)
    if #licensesFound >= 1 then
        for i, v in ipairs(licensesFound) do
            if v.info.firstname == Player.PlayerData.charinfo.firstname and v.info.lastname == Player.PlayerData.charinfo.lastname then
                if exports['qb-inventory']:AddItem(src, paper, 1, false, false, 'Gave Paper') then
                    cb(1)
                else
                    cb(4)
                end
            end
        end
        cb(2)
    else
        cb(3)
    end
end)

QBCore.Functions.CreateCallback("flaadev-rental:server:CheckPaper", function (source, cb)
    local src = source
    local paper = Shared.rentalPaperName
    local hasItems = exports['qb-inventory']:HasItem(src, paper, 1)
    if hasItems then
        exports['qb-inventory']:RemoveItem(src, paper, 1, false, 'Took Paper')
        cb(true)
    else
        cb(false)
    end
end)