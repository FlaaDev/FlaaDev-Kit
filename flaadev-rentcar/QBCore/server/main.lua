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

QBCore.Functions.CreateCallback("flaadev-rental:server:CheckLicense", function (source, cb, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Config.licenseItemName
    local paper = Config.rentalPaperName
    local licensesFound = Player.Functions.GetItemsByName(item)
    if #licensesFound >= 1 then
        for i, v in ipairs(licensesFound) do
            if v.info.firstname == Player.PlayerData.charinfo.firstname and v.info.lastname == Player.PlayerData.charinfo.lastname then
                if Player.Functions.GetMoney("cash") >= price then
                    if Player.Functions.AddItem(paper, 1) then
                        cb(1)
                    else
                        cb(4)
                    end
                else
                    cb(5)
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
    local Player = QBCore.Functions.GetPlayer(src)
    local paper = Config.rentalPaperName
    Player.Functions.RemoveItem(paper, 1)
    cb(true)
end)