# LAKKA OS - for Khadas Edge sbc (rk3399)

Lakka is a lightweight Linux distribution that transforms 
a small computer into a full blown retrogaming console.

## DEVICES

+ [Khadas Edge](https://www.khadas.com/edge)

## NOTES

+ rebuilt last develop lakka.tv fork https://github.com/hyphop/lakka-khadas.git
+ Lakka version 3.0 https://www.lakka.tv/articles/2021/05/22/lakka-3.0/
+ Removed unused firmwares
+ Operating system based on LibreELEC 9.2 build system
+ RetroArch updated to 1.9.3
+ New libretro cores
+ some optimizations
+ 1920x1080 60 fps force full-hd mode
+ Onboard Wi-Fi - OK
+ EMMC Boot - OK
+ SD Boot - OK
+ Bluetooth - OK
+ [Khadas IR Remote Control](https://www.khadas.com/product-page/ir-remote) - OK
+ test demo collection for education purposes

## Bugs

+ some reboot/poweroff stucks

## DOWNLOADS 

+ https://dl.khadas.com/Firmware/Edge/Lakka/ - sd - emmc images

we can download sd/emmc image - this image suitable for direct writing to SD (same for EMMC)

## Krescue

easiest way for writing this lakka image to Emmc is Krescue, just start krescue from SD
and write  lakka to emmc via online installation

+ https://dl.khadas.com/Firmware/Krescue/

## SSH Login

+     user: root
+ password: root

NOTE: ssh service disabled by default (need activate before use it)

## Build from Sources

+ https://github.com/hyphop/lakka-khadas-edge

## Links 

+ http://lakka.tv/
+ https://forum.khadas.com/t/lakka-for-khadas-edge-rk3399/9538

