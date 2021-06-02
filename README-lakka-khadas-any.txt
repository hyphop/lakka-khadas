# LAKKA OS - for Khadas Edge sbc VIM1 VIM2 / Edge

Lakka is a lightweight Linux distribution that transforms 
a small computer into a full blown retrogaming console.

## DEVICES

+ [Khadas Vim](https://www.khadas.com/vim)
+ [Khadas Edge](https://www.khadas.com/edge)

## NOTES

+ rebuilt last develop lakka.tv fork https://github.com/hyphop/lakka-khadas.git
+ Lakka version 3.0 https://www.lakka.tv/articles/2021/05/22/lakka-3.0/
+ Removed unused firmwares
+ Operating system based on LibreELEC 9.2 build system
+ RetroArch updated to 1.9.3
+ bootable from mainline uboot
+ embedded last mainline uboot - easy to boot other distros
+ New libretro cores
+ some optimizations
+ 1920x1080 60 fps force full-hd mode
+ Onboard Wi-Fi - OK
+ EMMC Boot - OK
+ SD Boot - OK
+ Bluetooth - OK
+ [Khadas IR Remote Control](https://www.khadas.com/product-page/ir-remote) - OK
+ test demo collection for education purposes
+ amlogic VIM1/VIM2 - aarch64
+ amlogic VIM1/VIM2 - arm/32bit
+ rockchip Edge - arm/32bit

## Lakka

Menu Toggle Controller - Hold Start (2 sec)

## DOWNLOADS

+ https://dl.khadas.com/Firmware/VIM1/Lakka/ - sd - emmc images
+ https://dl.khadas.com/Firmware/VIM2/Lakka/ - sd - emmc images
+ https://dl.khadas.com/Firmware/Edge/Lakka/ - sd - emmc images

we can download sd/emmc image - this image suitable for direct writing to SD (same for EMMC)

## Krescue

easiest way for writing this lakka image to Emmc is Krescue, just start krescue from SD
and write Lakka to emmc via online installation

+ https://dl.khadas.com/Firmware/Krescue/

## SSH Login

+     user: root
+ password: root

NOTE: ssh service disabled by default (need activate before use it)

## Build from Sources

+ https://github.com/hyphop/lakka-khadas

## Links 

+ http://lakka.tv/

