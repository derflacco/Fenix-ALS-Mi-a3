# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=-Fenix-Kernel by DerFlacco
do.devicecheck=0
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1
device.name2=
device.name3=
device.name4=
device.name5=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=1;
ramdisk_compression=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# Add skip_override parameter to cmdline so user doesn't have to reflash Magisk
if [ -d $ramdisk/.subackup -o -d $ramdisk/.backup ]; then
  ui_print " "; ui_print "Magisk detected! Patching cmdline so reflashing Magisk is not necessary...";
  patch_cmdline "skip_override" "skip_override";
else
  patch_cmdline "skip_override" "";
fi;

# If the kernel image and dtbs are separated in the zip
#decompressed_image=/tmp/anykernel/kernel/Image
#compressed_image=$decompressed_image.gz
#if [ -f $compressed_image ]; then
#  # Hexpatch the kernel if Magisk is installed ('skip_initramfs' -> 'want_initramfs')
#  if [ -d $ramdisk/.backup ]; then
#    ui_print " "; ui_print "Magisk detected! Patching kernel so reflashing Magisk is not necessary...";
#   $bin/magiskboot --decompress $compressed_image $decompressed_image;
#    $bin/magiskboot --hexpatch $decompressed_image 736B69705F696E697472616D667300 77616E745F696E697472616D667300;
#    $bin/magiskboot --compress=gzip $decompressed_image $compressed_image;
#  fi;

# Concatenate all of the dtbs to the kernel
#  cat $compressed_image /tmp/anykernel/dtbs/*.dtb > /tmp/anykernel/Image.gz-dtb;
#fi;



# end ramdisk changes

write_boot;

## end install
