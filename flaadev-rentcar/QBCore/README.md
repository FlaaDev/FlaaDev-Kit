# Vehicle Renting Services Script for QBCore

## Author: FlaaSh

## Support
# Discord  : `https://discord.gg/Py8TmSprTR`
# Youtube  : `https://www.youtube.com/@FlaaDev`
# Github   : `https://github.com/FlaaDev/FlaaDev-Kit`
# CFX Forum: `https://forum.cfx.re/u/flaadev-kit`
# Store    : `https://flaadev.tebex.io`
# Fiverr   : `https://www.fiverr.com/maroemad`

## License
You can buy this script through `https://flaadev.tebex.io/package/6343278`

## Description
Vehicle Renting Services is a FiveM script that allows players to rent a vehicle and use it around the city.
Players can't rent another vehicle until they return the first one or pay fees if they lose it.
Upon renting a vehicle, players receive a rental paper, which they must return when returning the vehicle or pay fees for losing it.

## Features
# NEW:
- Tracking blip for the rented vehicle
- Available for ESX
- Bugs fixed for the rental paper
# Last Version:
- Player need driver license to rent a vehicle
- Player can rent one vehicle only until s/he return it or pay the fees
- Player can pay fees also if s/he lost the rental paper
- Vehicle can be returned to any ped around the map
- The Script is fully customizable depending on your needs

## Requirements
- `qb-core`
- `qb-target`
- `qb-menu`

## Installation
1. Place the `flaadev-rentcar` folder in your `resources` directory.
2. Add `ensure flaadev-rentcar` to your `server.cfg` file.
3. Make sure there is `Driver License` item in your server
4. Add new `Rental Paper` item to your inventory script and its name `rentalpaper` 
5. Add the attached image in your inventory script

## Configuration
Edit the `Config.lua` file to customize the script: (it contains comments for everything)

1. If you are using qb-inventory:
- Put `rentalpaper.png` in `resources\[qb]\qb-inventory\html\images`.
- Add the following line to `resources\[qb]\qb-core\shared\items.lua`:

   ```lua
   rentalpaper  = { name = "rentalpaper", label = "Rental Paper", weight = 1, type = "item", image = "rentalpaper.png", unique = false, useable = false, shouldClose = true, combinable = nil, description = "Use it to return car"}

## Notes
1. You can add another script language by renaming `empty.lua` file in `locales/` and replace every sentence inside