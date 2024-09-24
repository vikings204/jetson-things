# nd 9/10/24

# https://docs.nvidia.com/jetson/archives/r36.3/DeveloperGuide/SD/Kernel/KernelCustomization.html
# https://forums.developer.nvidia.com/t/problem-smb-jetson-nano/193640/11
# kms
#export KERNEL_DEF_CONFIG=../../../../../../../../kernel_config
#cat kernel/kernel-jammy-src/.config | grep SLCAN

mv sources/Linux_for_Tegra/source/kernel/kernel-jammy-src/arch/arm64/configs/defconfig sources/Linux_for_Tegra/source/kernel/kernel-jammy-src/arch/arm64/configs/defconfig.original
cp kernel_config sources/Linux_for_Tegra/source/kernel/kernel-jammy-src/arch/arm64/configs/defconfig
#sources/Linux_for_Tegra/source/kernel/kernel-jammy-src/scripts/config --enable CONFIG_CAN_SLCAN

# build and install kernel and in-tree modules
cd sources/Linux_for_Tegra/source
make -C kernel
export INSTALL_MOD_PATH=/
sudo -E make install -C kernel
sudo cp kernel/kernel-jammy-src/arch/arm64/boot/Image /boot/Image

# build and install out of tree modules
export KERNEL_HEADERS=$PWD/kernel/kernel-jammy-src
make modules
sudo -E make modules_install
sudo nv-update-initrd

# build and install device trees
make dtbs
sudo cp nvidia-oot/device-tree/platform/generic-dts/dtbs/* /boot/dtb/

#kernel/kernel-jammy-src/scripts/config --undefine CONFIG_CAN_SLCAN
cd kernel/kernel-jammy-src/arch/arm64
mv configs/defconfig.original configs/defconfig

#echo "/home/team204/kernel_work/sources/Linux_for_Tegra/source/kernel/kernel-jammy-src/arch/arm64/boot/Image"
#export NEW_KERNEL=/home/team204/kernel_work/sources/Linux_for_Tegra/source/kernel/kernel-jammy-src/arch/arm64/boot/Image
#echo "Path to new kernel image located at \$NEW_KERNEL"
