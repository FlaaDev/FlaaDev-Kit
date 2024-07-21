local Translations = {
    error = {
        ["alreadyRented"]      = "您已经租了一辆车！",
        ["enoughCash"]         = "您没有足够的现金！",
        ["fakeDrivingLicense"] = "这不是您的驾驶执照！快去拿您的驾照！",
        ["space"]              = "您没有足够的空间！",
        ["noDrivingLicense"]   = "您必须有驾驶执照！",
        ["didnotRent"]         = "您没有租一辆车！",
        ["beDriver"]           = "您必须是司机！",
        ["notTheCar"]          = "这不是您租的车！",
    },
    success = {
        ["rented"]             = "请保管好车辆。",
        ["back"]               = "感谢您完好无损地归还！",
    },
    info = {
        ["rentalMenuHeader"]   = "租赁服务",
        ["lostVehicle"]        = "我丢失了车辆 - $",
        ["payFees"]            = "支付费用！",
        ["close"]              = "关闭",
        ["feesMenuHeader"]     = "您没有租赁文件。",
        ["payRentalFees"]      = "支付费用 - $",
        ["returnCar"]          = "E - 归还车辆",
    },
    warning = {
        ["lostVehicle"]        = "下次注意！"
    }
}

if GetConvar('qb_locale', 'en') == 'cn' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end