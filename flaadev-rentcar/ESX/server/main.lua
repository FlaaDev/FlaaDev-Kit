local ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback("flaadev-rental:server:PayRental", function(source, cb, price)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    if Player.getMoney() >= price then
        Player.removeMoney(price)
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback("flaadev-rental:server:CheckLicense", function(source, cb, price)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local item = Config.licenseItemName
    local paper = Config.rentalPaperName
    local licensesFound = Player.hasItem(item)
    if licensesFound then
        if Player.canCarryItem(paper, 1) then
            if Player.getMoney() >= price then
                Player.addInventoryItem(paper, 1)
                cb(1)
            else
                cb(2)
            end
        else
            cb(4)
        end
    else
        cb(3)
    end
end)

ESX.RegisterServerCallback("flaadev-rental:server:CheckPaper", function(source, cb)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local paper = Config.rentalPaperName
    local hasItems = Player.hasItem(paper)
    if hasItems then
        Player.removeInventoryItem(paper, 1)
        cb(true)
    else
        cb(false)
    end
end)
