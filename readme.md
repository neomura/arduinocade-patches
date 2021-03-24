# neomura/arduinocade-patches

Unofficial patches to [Arduinocade](https://github.com/rossumur/Arduinocade) to make its games compatible with the [Neomura ATMega328P Cartridge](https://github.com/neomura/atmega328p-cartridge).

## License

While this repository is [MIT licensed](./license.md), it includes Git submodules of:

| Repository                                                      | License    |
| --------------------------------------------------------------- | ---------- |
| [rossumur/Arduinocade](https://github.com/rossumur/Arduinocade) | Unlicensed |
| [arduino/Arduino](https://github.com/arduino/Arduino)           | GPL/LGPL   |

You should make your own checks to ensure that your usage of this repository is valid within these license agreements.

## Required hardware modifications

X1 must be changed to a 28.31818MHz crystal for these games to work at full speed on a real display.

You may find that your ATMega328Ps do not function at this clock speed; not all do.

## Changes made by these patches

- Audio is mirrored to dual mono.
