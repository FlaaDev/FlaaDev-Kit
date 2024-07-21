local Translations = {
    error = {
        ["alreadyRented"]      = "Вече сте наели превозно средство!",
        ["enoughCash"]         = "Нямаш достатъчно пари!",
        ["fakeDrivingLicense"] = "Това не е вашата шофьорска книжка! ВЗЕМЕТЕ СИ!",
        ["space"]              = "Нямате достатъчно място!",
        ["noDrivingLicense"]   = "Трябва да имате шофьорска книжка!",
        ["didnotRent"]         = "Не сте наели превозно средство!",
        ["beDriver"]           = "Ти трябва да си шофьорът!",
        ["notTheCar"]          = "Това не е колата, която сте наели!",
    },
    success = {
        ["rented"]             = "Погрижете се за автомобила.",
        ["back"]               = "Благодаря, че го върнахте цял!",
    },
    info = {
        ["rentalMenuHeader"]   = "Услуга под наем",
        ["lostVehicle"]        = "Изгубих превозното средство - $",
        ["payFees"]            = "Платете таксите!",
        ["close"]              = "Близо",
        ["feesMenuHeader"]     = "Нямате документ за наем.",
        ["payRentalFees"]      = "Плащане на такси - $",
        ["returnCar"]          = "E – Връщане на превозно средство",
    },
    warning = {
        ["lostVehicle"]        = "Внимавай следващия път!"
    }
}

if GetConvar('qb_locale', 'en') == 'bg' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end