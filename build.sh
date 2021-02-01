#!/bin/bash 
sudo gem install rmega
export LC_ALL=C 
export KBUILD_BUILD_USER=FraTeG
export KBUILD_BUILD_HOST=Ubuntu
export CROSS_COMPILE=/home/runner/work/Ubuntu-SSH/Ubuntu-SSH/kernel/arm-eabi-4.8/bin/arm-eabi-
export ARCH=arm && export SUBARCH=arm
rm -rf out 
rm -rf make.txt
rm -rf AnyKernel2
mkdir -p out 
make O=out clean 
make O=out mrproper  
make O=out msm8916_sec_defconfig VARIANT_DEFCONFIG=msm8916_sec_a5u_eur_defconfig SELINUX_DEFCONFIG=selinux_defconfig
make O=out menuconfig
make O=out -j$(nproc --all) 
./dtbTool -2 -o ./out/arch/arm/boot/dt.img -s 2048 -p ./out/scripts/dtc/ ./out/arch/arm/boot/dts/ -v
cd out/arch/arm/boot
cp dt.img ~/work/Ubuntu-SSH/Ubuntu-SSH/kernel/AnyKernel2
cp zImage ~/work/Ubuntu-SSH/Ubuntu-SSH/kernel/AnyKernel2
cd .. && cd .. && cd .. && cd .. 
cd AnyKernel2
zip -r9 A5-kernel.zip * -x README.md A5-kernel.zip && rmega-up A5-kernel.zip -u fra6217@gmail.com 

