# builds wpilib
# WARNING, this literally edges the resources of the jetson,
# i lost all remote access until wpimath was completed.
# idk what beef they fed wpimath but when i tested on a modern
# vmware server, it easily took >11gb ram with 4 cores, 8 jobs

cmake --preset default -DWITH_GUI=OFF -DWITH_CSCORE=OFF -DWITH_TESTS=OFF
cd build-cmake
# first build wpimath cuz it takes like 11gb ram to compile with 8 jobs
cmake --build . --target wpimath --parallel 4
# then do the whole thang
cmake --build . --parallel 8
sudo cmake --build . --target install
