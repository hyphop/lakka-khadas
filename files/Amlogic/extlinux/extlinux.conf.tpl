cat <<end
LABEL Lakka
  LINUX /KERNEL.gz
  FDTDIR /dtb
  $FDT
  APPEND boot=LABEL=$PART1_LABEL disk=LABEL=$PART2_LABEL quiet console=ttyAML0,115200n8 console=tty0 video=HDMI-A-1:1920x1080@60
end
