Config = {
    pedModel        = "s_m_y_airworker", -- the model of the ped you want (can be replace by hash = 1644266841)
    zoneDiameter    = 10.0, -- The diameter of the return zone
    licenseItemName = "driver_license", -- The item name of the driver license in your inventory script
    rentalPaperName = "rentalpaper", -- The item name of the rental paper in your inventory script
    rentalFeesPrice = 5000,  -- The price that the player will pay if he lost the rental paper
    carFeesPrice    = 10000, -- The price that the player will pay if he lost the car
    pzones   = { -- The zones of the rental service
        zone1 = { --Legion Square
            pedLocation = vector4(215.29, -806.51, 30.8, 337.1),
            vehspawnloc = vector4(216.13, -801.78, 30.39, 68.31),
            pzvect      = vector3(215.24, -806.55, 30.78),
            wid         = 0.6,
            hig         = 0.6,
            heading     = 338,
            minZ        = 27.58,
            maxZ        = 31.58,
        },
        zone2 = { --Airport
            pedLocation = vector4(-1031.22, -2734.73, 20.17, 21.45),
            vehspawnloc = vector4(-1030.2, -2732.12, 19.67, 241.68),
            pzvect      = vector3(-1031.25, -2734.65, 20.17),
            wid         = 0.6,
            hig         = 0.8,
            heading     = 305,
            minZ        = 16.97,
            maxZ        = 20.97,
        },
        zone3 = { --Paleto
            pedLocation = vector4(145.64, 6563.96, 32.0, 313.11),
            vehspawnloc = vector4(154.45, 6567.83, 31.42, 254.12),
            pzvect      = vector3(145.7, 6564.04, 32.0),
            wid         = 0.6,
            hig         = 0.6,
            heading     = 315,
            minZ        = 28.8,
            maxZ        = 32.8,
        },
        zone4 = { --Sandy Shores
            pedLocation = vector4(1991.19, 3778.08, 32.18, 123.61),
            vehspawnloc = vector4(1984.5, 3767.3, 31.77, 206.01),
            pzvect      = vector3(1991.09, 3778.02, 32.18),
            wid         = 0.6,
            hig         = 0.6,
            heading     = 30,
            minZ        = 28.98,
            maxZ        = 32.98,
        },
        -- Add new Zone
        -- zone5 = { --Sandy Shores
        --     pedLocation = vector4(1991.19, 3778.08, 32.18, 123.61),
        --     vehspawnloc = vector4(1984.5, 3767.3, 31.77, 206.01),
        --     pzvect      = vector3(1991.09, 3778.02, 32.18),
        --     wid         = 0.6,
        --     hig         = 0.6,
        --     heading     = 30,
        --     minZ        = 28.98,
        --     maxZ        = 32.98,
        -- }
    },
    blip = { -- The blip settings of the ped that will be shown on the map
        name  = "Rental Service",
        color = 5,
        id    = 757
    },
    carBlip = { -- The blip settings of the car tracking that will be shown on the map
        name    = "Rented Vehicle",
        color   = 5,
        carID   = 523, -- The car blip id
        motorID = 522  -- The motorbike blip id
    },
    cars = {
        -- The cars will be available in the menu of renting
        { name = "Skyline", id = "skyline", text = "The fastest one!", isCar = true,  price = 4000 },
        { name = "Adder",   id = "adder",   text = "The slowest one!", isCar = true,  price = 2000 },
        { name = "Shinobi", id = "shinobi", text = "The one!",         isCar = false, price = 1000 },
    },
}