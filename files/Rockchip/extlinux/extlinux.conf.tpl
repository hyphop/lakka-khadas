cat <<end
LABEL Lakka
  LINUX /KERNEL
  FDTDIR /dtb
  $FDT
  APPEND boot=LABEL=$PART1_LABEL disk=LABEL=$PART2_LABEL quiet console=uart8250,mmio32,0xff1a0000 console=tty0 video=HDMI-A-1:1920x1080@60
end
