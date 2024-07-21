local Translations = {
    error = {
        ["alreadyRented"]      = "You already rented a vehicle!",
        ["enoughCash"]         = "You don't have enough cash!",
        ["fakeDrivingLicense"] = "It's not your driving license! GET YOURS!",
        ["space"]              = "You don't have enough space!",
        ["noDrivingLicense"]   = "You must have your driving license!",
        ["didnotRent"]         = "You didn't rent a Vehicle!",
        ["beDriver"]           = "You must be the driver!",
        ["notTheCar"]          = "It's not the car you rented!",
    },
    success = {
        ["rented"]             = "Take care of the vehicle.",
        ["back"]               = "Thanks for returning it in one piece!",
    },
    info = {
        ["rentalMenuHeader"]   = "Rental Service",
        ["lostVehicle"]        = "I lost the Vehicle - $",
        ["payFees"]            = "Pay The Fees!",
        ["close"]              = "Close",
        ["feesMenuHeader"]     = "You don't have rental paper.",
        ["payRentalFees"]      = "Pay Fees - $",
        ["returnCar"]          = "E - Return Vehicle",
    },
    warning = {
        ["lostVehicle"]        = "Take care next time!"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
