local Translations = {
    error = {
        ["alreadyRented"]      = "Već ste iznajmili vozilo!",
        ["enoughCash"]         = "Nemate dovoljno gotovine!",
        ["fakeDrivingLicense"] = "Nije to tvoja vozačka! UZMI SVOJU!",
        ["space"]              = "Nemate dovoljno mjesta!",
        ["noDrivingLicense"]   = "Morate imati vozačku dozvolu!",
        ["didnotRent"]         = "Nisi iznajmio vozilo!",
        ["beDriver"]           = "Ti mora da si vozač!",
        ["notTheCar"]          = "To nije auto koji ste unajmili!",
    },
    success = {
        ["rented"]             = "Čuvajte vozilo.",
        ["back"]               = "Hvala što ste ga vratili u jednom komadu!",
    },
    info = {
        ["rentalMenuHeader"]   = "Usluga iznajmljivanja",
        ["lostVehicle"]        = "Izgubio sam vozilo - $",
        ["payFees"]            = "Plati naknade!",
        ["close"]              = "Zatvoriti",
        ["feesMenuHeader"]     = "Nemate papir za iznajmljivanje.",
        ["payRentalFees"]      = "Plati naknade - $",
        ["returnCar"]          = "E - Povratno vozilo",
    },
    warning = {
        ["lostVehicle"]        = "Čuvaj se sljedeći put!"
    }
}

if GetConvar('qb_locale', 'en') == 'bs' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end