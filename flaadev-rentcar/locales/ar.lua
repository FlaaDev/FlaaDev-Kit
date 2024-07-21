local Translations = {
    error = {
        ["alreadyRented"]      = "لقد أجرت سيارة بالفعل",
        ["enoughCash"]         = "ليس لديك مال كافي (كاش)",
        ["fakeDrivingLicense"] = "هذه ليست رخصتك! احضر رخصتك",
        ["space"]              = "ليس لديك مساحة كافية في حقيبتك",
        ["noDrivingLicense"]   = "انت لا تحمل رخصة",
        ["didnotRent"]         = "انت لم تستاجر سيارة",
        ["beDriver"]           = "يجب ان تكون السائق",
        ["notTheCar"]          = "هذه ليست السيارة التي اجرتها",
    },
    success = {
        ["rented"]             = "عليك الاهتمام بالسيارة",
        ["back"]               = "شكرا لاعادة السيارة قطعة واحدة",
    },
    info = {
        ["rentalMenuHeader"]   = "خدمة تاجير السيارات",
        ["lostVehicle"]        = "لقد اضعت السيارة - $",
        ["payFees"]            = "ادفع الغرامة",
        ["close"]              = "اغلاق",
        ["feesMenuHeader"]     = "انت لا تحمل اوراق تاجير سيارة",
        ["payRentalFees"]      = "ادفع الغرامة - $",
        ["returnCar"]          = "E - اعد السيارة",
    },
    warning = {
        ["lostVehicle"]        = "انتبه المرة القادمة"
    }
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end