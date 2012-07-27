# Camera
USE_CAMERA_STUB := false
BOARD_USES_TI_CAMERA_HAL := true
TI_CAMERAHAL_DEBUG_ENABLED := true

# inherit from the proprietary version
-include vendor/motorola/solana/BoardConfigVendor.mk


# Processor
TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := omap4
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_BOOTLOADER_BOARD_NAME := solana
TARGET_CPU_SMP := true
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_ARCH_VARIANT_CPU := cortex-a9
TARGET_ARCH_VARIANT_FPU := neon
ARCH_ARM_HAVE_TLS_REGISTER := true
NEEDS_ARM_ERRATA_754319_754320 := true
TARGET_GLOBAL_CFLAGS += -DNEEDS_ARM_ERRATA_754319_754320


# Kernel
BOARD_KERNEL_CMDLINE := root=/dev/ram0 rw mem=512M@0x80000000 console=ttyO2,115200n8 init=/init ip=off brdrev=P2A ramdisk_size=20480 mmcparts=mmcblk1:p7(pds),p15(boot),p16(recovery),p17(cdrom),p18(misc),p19(cid),p20(kpanic),p21(system),p22(cache),p23(preinstall),p24(userdata),p25(emstorage) androidboot.bootloader=0x0A64
BOARD_KERNEL_BASE := 0x80000000
BOARD_PAGE_SIZE := 0x4096

# Kernel Build
TARGET_KERNEL_SOURCE := kernel/motorola/solana
TARGET_KERNEL_CONFIG := hashcode_defconfig
TARGET_PREBUILT_KERNEL := device/motorola/solana/kernel

KERNEL_EXTERNAL_MODULES:
	make -C kernel/motorola/solana/external/wlan/mac80211/compat_wl12xx KERNEL_DIR=$(KERNEL_OUT) KLIB=$(KERNEL_OUT) KLIB_BUILD=$(KERNEL_OUT) ARCH=arm CROSS_COMPILE="arm-eabi-"
	mv kernel/motorola/solana/external/wlan/mac80211/compat_wl12xx/compat/compat.ko $(KERNEL_MODULES_OUT)
	mv kernel/motorola/solana/external/wlan/mac80211/compat_wl12xx/net/mac80211/mac80211.ko $(KERNEL_MODULES_OUT)
	mv kernel/motorola/solana/external/wlan/mac80211/compat_wl12xx/net/wireless/cfg80211.ko $(KERNEL_MODULES_OUT)
	mv kernel/motorola/solana/external/wlan/mac80211/compat_wl12xx/drivers/net/wireless/wl12xx/wl12xx.ko $(KERNEL_MODULES_OUT)
	mv kernel/motorola/solana/external/wlan/mac80211/compat_wl12xx/drivers/net/wireless/wl12xx/wl12xx_spi.ko $(KERNEL_MODULES_OUT)
	mv kernel/motorola/solana/external/wlan/mac80211/compat_wl12xx/drivers/net/wireless/wl12xx/wl12xx_sdio.ko $(KERNEL_MODULES_OUT)
	make -C kernel/motorola/solana/external/sgx/src/eurasia_km/eurasiacon/build/linux2/omap4430_android ARCH=arm KERNEL_CROSS_COMPILE=arm-eabi- CROSS_COMPILE=arm-eabi- KERNELSRC=$(KERNEL_OUT)/../../../../../../kernel/motorola/solana KERNELDIR=$(KERNEL_OUT) TARGET_PRODUCT="blaze_tablet" BUILD=release TARGET_SGX=540 PLATFORM_VERSION=4.0
	mv $(KERNEL_OUT)/../../target/kbuild/omaplfb_sgx540_120.ko $(TARGET_ROOT_OUT)/omaplfb_sgx540_120.ko
	mv $(KERNEL_OUT)/../../target/kbuild/pvrsrvkm_sgx540_120.ko $(TARGET_ROOT_OUT)/pvrsrvkm_sgx540_120.ko
	cp $(KERNEL_OUT)/../../kernel $(KERNEL_OUT)/../../system/etc/kexec/zImage

TARGET_KERNEL_MODULES := KERNEL_EXTERNAL_MODULES


# Storage / Sharing
BOARD_VOLD_MAX_PARTITIONS := 100
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/class/android_usb/android0/f_mass_storage/lun%d/file"
BOARD_MTP_DEVICE := "/dev/mtp"

# Connectivity - Wi-Fi
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wl12xx
BOARD_HOSTAPD_DRIVER             := NL80211
PRODUCT_WIRELESS_TOOLS           := true
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_wl12xx
BOARD_WLAN_DEVICE                := wl12xx_mac80211
BOARD_SOFTAP_DEVICE              := wl12xx_mac80211
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wl12xx_sdio.ko"
WIFI_DRIVER_MODULE_NAME          := "wl12xx_sdio"
WIFI_FIRMWARE_LOADER             := ""
COMMON_GLOBAL_CFLAGS += -DUSES_TI_MAC80211

# Audio
BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := true
BUILD_WITH_ALSA_UTILS := true
HAVE_2_3_DSP := 1
TARGET_PROVIDES_LIBAUDIO := true
BOARD_USE_MOTO_DOCK_HACK := true


# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true


# Recovery
BUILD_BOOTMENU_STANDALONE := true
#BOARD_HAS_LOCKED_BOOTLOADER := true
TARGET_PREBUILT_RECOVERY_KERNEL := device/motorola/solana/recovery-kernel
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_UMS_LUNFILE := "/sys/class/android_usb/android0/f_mass_storage/lun%d/file"
BOARD_ALWAYS_INSECURE := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_MKE2FS := device/motorola/solana/releaseutils/mke2fs
BOARD_NONSAFE_SYSTEM_DEVICE := /dev/block/mmcblk1p21
BOARD_HAS_SDCARD_INTERNAL := true
#BOARD_HAS_SDEXT := false
TARGET_RECOVERY_PRE_COMMAND := "echo 1 > /data/.recovery_mode; sync;"
TARGET_RECOVERY_PRE_COMMAND_CLEAR_REASON := true
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"


# Sandbox Filesystem Settings
BOARD_SYSTEM_DEVICE := /dev/block/system
BOARD_SYSTEM_FILESYSTEM_OPTIONS := noatime,nodiratime
BOARD_SYSTEM_FILESYSTEM := ext3


# Graphics
BOARD_EGL_CFG := device/motorola/spyder/prebuilt/etc/egl.cfg
USE_OPENGL_RENDERER := true
COMMON_GLOBAL_CFLAGS += -DSURFACEFLINGER_FORCE_SCREEN_RELEASE


# OMAP
OMAP_ENHANCEMENT := true
ifdef OMAP_ENHANCEMENT
COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT -DTARGET_OMAP4
endif

ENHANCED_DOMX := true
USE_ITTIAM_AAC := true
ifdef USE_ITTIAM_AAC
COMMON_GLOBAL_CFLAGS += -DUSE_ITTIAM_AAC
endif

# MOTOROLA
USE_MOTOROLA_CODE := true
ifdef USE_MOTOROLA_CODE
COMMON_GLOBAL_CFLAGS += -DUSE_MOTOROLA_CODE
endif
USE_MOTOROLA_USERS := true
ifdef USE_MOTOROLA_USERS
COMMON_GLOBAL_CFLAGS += -DUSE_MOTOROLA_USERS
endif


# Media / Radio
# Off currently

# OTA Packaging
TARGET_PROVIDES_RELEASETOOLS := true
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := device/motorola/solana/releasetools/solana_ota_from_target_files
TARGET_RELEASETOOL_IMG_FROM_TARGET_SCRIPT := device/motorola/solana/releasetools/solana_img_from_target_files
TARGET_CUSTOM_RELEASETOOL := ./device/motorola/solana/releasetools/squisher

# CodeAurora Optimizations: msm8960: Improve performance of memmove, bcopy, and memmove_words
# added by twa_priv
TARGET_USE_KRAIT_BIONIC_OPTIMIZATION := true
TARGET_USE_KRAIT_PLD_SET := true
TARGET_KRAIT_BIONIC_PLDOFFS := 10
TARGET_KRAIT_BIONIC_PLDTHRESH := 10
TARGET_KRAIT_BIONIC_BBTHRESH := 64
TARGET_KRAIT_BIONIC_PLDSIZE := 64

# Bootanimation
TARGET_BOOTANIMATION_PRELOAD := true


# Misc.
BOARD_USE_BATTERY_CHARGE_COUNTER := true
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_NEEDS_CUTILS_LOG := true
BOARD_USES_SECURE_SERVICES := true
BOARD_USES_KEYBOARD_HACK := true
BOARD_HAS_MAPPHONE_SWITCH := true
USE_IPV6_ROUTE := true
