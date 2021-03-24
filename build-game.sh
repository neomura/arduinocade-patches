mkdir -p ./build/games/$1
cp -r ./submodules/rossumur/Arduinocade/examples/$1 ./build/games
cp ./submodules/rossumur/Arduinocade/*.cpp ./build/games/$1
cp ./submodules/rossumur/Arduinocade/*.h ./build/games/$1

if [ $1 != ballblaster ]; then
  sed -i 's/^#define BALLBLASTER_GAME$//g' ./build/games/$1/config.h
fi

# Mirror audio across the two channels.
sed -i 's/^#define AUDIO_PIN       6$/#define AUDIO_PIN_L       5\n#define AUDIO_PIN_R       6/g' ./build/games/$1/video.cpp
sed -i 's/^    OCR0A = 128-_mix;  \/\/ output last audio sample$/    uint8_t correctedMix = 128 - _mix;\n    OCR0A = correctedMix;  \/\/ output last audio sample\n    OCR0B = correctedMix;/g' ./build/games/$1/video.cpp
sed -i 's/^    TCCR0A |= _BV(COM0A1) | _BV(WGM00) | _BV(WGM01); \/\/ fast PWM, turn on OC0A$/    TCCR0A |= _BV(COM0A1) | _BV(COM0B1) | _BV(WGM00) | _BV(WGM01); \/\/ fast PWM, turn on OC0A\/B/g' ./build/games/$1/video.cpp
sed -i 's/^    DDRD |= _BV(AUDIO_PIN) | _BV(VIDEO_PIN);$/    DDRD |= _BV(AUDIO_PIN_L) | _BV(AUDIO_PIN_R) | _BV(VIDEO_PIN);/g' ./build/games/$1/video.cpp
sed -i 's/^    OCR0A = 0x00;$/    OCR0A = 0x00;\n    OCR0B = 0x00;/g' ./build/games/$1/video.cpp

xvfb-run -a ./submodules/arduino/Arduino/build/linux/work/arduino --verify --board arduino:avr:uno --pref build.path=${PWD}/build/games/$1 --verbose ./build/games/$1/$1.ino
