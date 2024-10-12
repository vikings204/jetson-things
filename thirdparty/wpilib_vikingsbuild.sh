# builds wpilib, run in root dir of allwpilib
# based on instructions here: https://github.com/wpilibsuite/allwpilib/blob/main/README-CMAKE.md

# WARNING, this literally edges the resources of the jetson,
# i lost all remote access until wpimath was completed.
# idk what beef they fed wpimath but when i tested on a modern
# vmware server, it easily took >11gb ram with 4 cores, 8 jobs

# for protobuf, if on linux, do not create an explicit install dir, just let ninja use default so wpilib cmake can find it
# protobuf install guide here: https://github.com/protocolbuffers/protobuf/blob/v21.12/cmake/README.md
# for some reason, when i tried to build wpimath (which has protobuffers),
# i was getting an error that seemed specific to aarch64
# adding the following args to the protobuf cmake command seemed to remedy it (i think)
# -DCMAKE_C_FLAGS="-fPIC" -DCMAKE_CXX_FLAGS="-fPIC"

# git clone https://github.com/wpilibsuite/allwpilib.git
# cd allwpilib
# mkdir build-cmake
cmake --preset default -DWITH_GUI=OFF -DWITH_CSCORE=OFF -DWITH_TESTS=OFF
cd build-cmake
# first build wpimath cuz it takes like 11gb ram to compile with 8 jobs
cmake --build . --target wpimath --parallel 4
# then do the whole thang
cmake --build . --parallel 8
sudo cmake --build . --target install
