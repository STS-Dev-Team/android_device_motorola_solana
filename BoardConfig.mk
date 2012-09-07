# inherit from common
-include device/motorola/common/BoardConfigCommon.mk

# inherit from the proprietary version
-include vendor/motorola/solana/BoardConfigVendor.mk


# Processor
TARGET_BOOTLOADER_BOARD_NAME := solana

# Kernel
BOARD_KERNEL_CMDLINE := root=/dev/ram0 rw mem=512M@0x80000000 console=ttyO2,115200n8 init=/init ip=off brdrev=P2A ramdisk_size=20480 mmcparts=mmcblk1:p7(pds),p15(boot),p16(recovery),p17(cdrom),p18(misc),p19(cid),p20(kpanic),p21(system),p22(cache),p23(preinstall),p24(userdata),p25(emstorage) androidboot.bootloader=0x0A64

# Kernel Build
TARGET_KERNEL_SOURCE := kernel/motorola/mapphone
TARGET_KERNEL_CONFIG := mapphone_solana_defconfig

# Recovery
BOARD_UMS_LUNFILE := "/sys/class/android_usb/android0/f_mass_storage/lun%d/file"
BOARD_NONSAFE_SYSTEM_DEVICE := /dev/block/mmcblk1p21



# Misc.
BOARD_USES_KEYBOARD_HACK := true
BOARD_HAS_MAPPHONE_SWITCH := true