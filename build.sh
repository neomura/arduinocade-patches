set -e

sudo apt install openjdk-8-jdk ant xvfb -y

cd ./submodules/arduino/Arduino/build
ant || echo "Expected to fail; enough is built to proceed."
cd ../../../..

rm -rf ./build

mkdir -p ./build/unpacked-dependencies/avr
cp ./submodules/arduino/Arduino/build/linux/avr_tools_linux64.tar.bz2 ./build/unpacked-dependencies/avr
bunzip2 -dk ./build/unpacked-dependencies/avr/avr_tools_linux64.tar.bz2
tar -xvf ./build/unpacked-dependencies/avr/avr_tools_linux64.tar -C ./build/unpacked-dependencies/avr
PATH=$PATH:${PWD}/build/unpacked-dependencies/avr/tools/avr/bin

bash ./build-game.sh ballblaster
bash ./build-game.sh jowst
bash ./build-game.sh pacman
bash ./build-game.sh titan
