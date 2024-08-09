# Vehicle Renting Services Script

## Author: FlaaSh

## Support
# Discord: `https://discord.gg/Py8TmSprTR`
# Store  : `https://flaadev.tebex.io`
# Youtube: `https://www.youtube.com/@FlaaDev`

## License
You can buy this script through `https://flaadev.tebex.io/package/6343278`

## Description
Vehicle Services is a FiveM script that allows players to rent a vehicle and use it around the city.
Players can't rent another vehicle until they return the first one or pay fees if they lose it.
Upon renting a vehicle, players receive a rental paper, which they must return when returning the vehicle or pay fees for losing it.

## Requirements
- `qb-core`
- `qb-target`
- `qb-inventory`
- `qb-menu`

## Installation
1. Place the `flaadev-rentcar` folder in your `resources` directory.
2. Add `ensure flaadev-rentcar` to your `server.cfg` file.

## Configuration
Edit the `Config.lua` file to customize the script:

1. **`pedModel`**: Set the model you want.
2. **`pzones`**: Set the renting locations.
3. **`zoneDiameter`**: Set the range for the player to return vehicle.
4. **`blip`**: Define how the blip will look like.
5. **`cars`**: List every available vehicle you need.
6. **`licenseItemName`**: Define the driver license item name in your server.
7. **`rentalFeesPrice`**: Set the fee amount for losing the rental paper.
8. **`carFeesPrice`**: Set the fee amount for losing the vehicle.
9. Put `rentalpaper.png` in `resources\[qb]\qb-inventory\html\images`.
10. Add the following line to `resources\[qb]\qb-core\shared\items.lua`:

   ```lua
   rentalpaper  = { name = "rentalpaper", label = "Rental Paper", weight = 1, type = "item", image = "rentalpaper.png", unique = false, useable = false, shouldClose = true, combinable = nil, description = "Use it to return car"}

## Notes
1. You can add another script language by renaming `empty.lua` file in `locales/` and replace every sentence inside