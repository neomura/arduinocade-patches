mkdir -p ./build/games/$1
cp -r ./submodules/rossumur/Arduinocade/examples/$1 ./build/games
cp ./submodules/rossumur/Arduinocade/*.cpp ./build/games/$1
cp ./submodules/rossumur/Arduinocade/*.h ./build/games/$1

if [ $1 != ballblaster ]; then
  sed -i 's/^#define BALLBLASTER_GAME$//g' ./build/games/$1/config.h
fi

xvfb-run -a ./submodules/arduino/Arduino/build/linux/work/arduino --verify --board arduino:avr:uno --pref build.path=${PWD}/build/games/$1 --verbose ./build/games/$1/$1.ino
