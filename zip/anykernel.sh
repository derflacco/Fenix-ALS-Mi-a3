# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Fenix-Kernel_Q by derflacco
do.devicecheck=0
do.modules=0
do.systemless=1
device.name1=laurel_sprout
device.name2=laurel
device.name3=laurus
do.cleanup=1
do.cleanuponabort=0
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=1;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel install
dump_boot;

# patch build.prop, enable psi
mount -o rw,remount /system

patch_prop /system/build.prop "ro.lmk.use_psi" "false"

ui_print "build.prop patched!"

# remove old root patch avoidance hack
patch_cmdline "skip_override" "";

write_boot;
  ui_print " "; ui_print "The world is full of good bois. If you can't find one, be one."
## end install
