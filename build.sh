set -e

sudo apt install openjdk-8-jre xvfb -y

rm -rf ./build

mkdir -p ./build/unpacked-dependencies/avr
cp ./submodules/arduino/Arduino/build/linux/avr_tools_linux64.tar.bz2 ./build/unpacked-dependencies/avr
bunzip2 -dk ./build/unpacked-dependencies/avr/avr_tools_linux64.tar.bz2
tar -xvf ./build/unpacked-dependencies/avr/avr_tools_linux64.tar -C ./build/unpacked-dependencies/avr
PATH=$PATH:${PWD}/build/unpacked-dependencies/avr/tools/avr/bin

mkdir -p ./build/games/ballblaster
cp -r ./submodules/rossumur/Arduinocade/examples/ballblaster ./build/games
cp ./submodules/rossumur/Arduinocade/*.cpp ./build/games/ballblaster
cp ./submodules/rossumur/Arduinocade/*.h ./build/games/ballblaster
xvfb-run -a ./submodules/arduino/Arduino/build/linux/work/arduino --verify --board arduino:avr:uno --pref build.path=${PWD}/build/games/ballblaster --verbose ./build/games/ballblaster/ballblaster.ino

mkdir -p ./build/games/jowst
cp -r ./submodules/rossumur/Arduinocade/examples/jowst ./build/games
cp ./submodules/rossumur/Arduinocade/*.cpp ./build/games/jowst
cp ./submodules/rossumur/Arduinocade/*.h ./build/games/jowst
sed -i 's/^#define BALLBLASTER_GAME$//g' ./build/games/jowst/config.h
xvfb-run -a ./submodules/arduino/Arduino/build/linux/work/arduino --verify --board arduino:avr:uno --pref build.path=${PWD}/build/games/jowst --verbose ./build/games/jowst/jowst.ino

mkdir -p ./build/games/pacman
cp -r ./submodules/rossumur/Arduinocade/examples/pacman ./build/games
cp ./submodules/rossumur/Arduinocade/*.cpp ./build/games/pacman
cp ./submodules/rossumur/Arduinocade/*.h ./build/games/pacman
sed -i 's/^#define BALLBLASTER_GAME$//g' ./build/games/pacman/config.h
xvfb-run -a ./submodules/arduino/Arduino/build/linux/work/arduino --verify --board arduino:avr:uno --pref build.path=${PWD}/build/games/pacman --verbose ./build/games/pacman/pacman.ino

mkdir -p ./build/games/titan
cp -r ./submodules/rossumur/Arduinocade/examples/titan ./build/games
cp ./submodules/rossumur/Arduinocade/*.cpp ./build/games/titan
cp ./submodules/rossumur/Arduinocade/*.h ./build/games/titan
sed -i 's/^#define BALLBLASTER_GAME$//g' ./build/games/titan/config.h
xvfb-run -a ./submodules/arduino/Arduino/build/linux/work/arduino --verify --board arduino:avr:uno --pref build.path=${PWD}/build/games/titan --verbose ./build/games/titan/titan.ino
