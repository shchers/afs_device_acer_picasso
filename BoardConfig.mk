# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).
# The proprietary variant sets USE_CAMERA_STUB := false, this way
# we use the camera stub when the vendor tree isn't present, and
# the true camera library when the vendor tree is available.  Similarly,
# we set USE_PROPRIETARY_AUDIO_EXTENSIONS to true in the proprietary variant as
# well.
USE_CAMERA_STUB := true
USE_PROPRIETARY_AUDIO_EXTENSIONS := false

# Use a smaller subset of system fonts to keep image size lower
SMALLER_FONT_FOOTPRINT := true

TARGET_BOARD_PLATFORM := tegra

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_ARCH_VARIANT := armv7-a
ARCH_ARM_HAVE_TLS_REGISTER := true
TARGET_USERIMAGES_USE_EXT4 := true
# Will be used my init.rc file
TARGET_PROVIDES_INIT_RC := true

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 251658240
BOARD_USERDATAIMAGE_PARTITION_SIZE := 31399067648
BOARD_FLASH_BLOCK_SIZE := 4096

# Wifi related defines
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := WEXT
BOARD_WLAN_DEVICE                := bcm4329
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wext
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/bcm4329.ko"
WIFI_DRIVER_FW_PATH_STA          := "/vendor/firmware/fw_bcm4329.bin"
WIFI_DRIVER_FW_PATH_AP           := "/vendor/firmware/fw_bcm4329_apsta.bin"
WIFI_DRIVER_MODULE_NAME          :=  "bcm4329"
WIFI_DRIVER_MODULE_ARG           :=  "iface_name=wlan0 firmware_path=/vendor/firmware/fw_bcm4329.bin nvram_path=/system/etc/wifi/bcmdhd.cal"

BOARD_USES_GENERIC_AUDIO := false

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

# In case of use Ericsson Mobile Broadband module f5521gw please refer to:
# http://sourceforge.net/apps/mediawiki/mbm/index.php?title=MBM_HAL_for_Android_Ice_Cream_Sandwich
# and un-comment this property
HAVE_ERICSSON_MBM := true
ifneq ($(HAVE_ERICSSON_MBM),false)
# Disabling Broadcom GPS devices
BOARD_HAVE_GPS_BCM := false
# Disablint qemu GPS deices
USE_QEMU_GPS_HARDWARE := false
# Enable MPM GPS devices
BOARD_USES_MBM_GPS := true
BOARD_GPS_LIBRARIES := gps.picasso
else
# Enable Broadcom GPS devices
BOARD_HAVE_GPS_BCM := true
endif


USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := device/acer/picasso/egl.cfg

ifneq ($(HAVE_NVIDIA_PROP_SRC),false)
# needed for source compilation of nvidia libraries
-include vendor/nvidia/proprietary_src/build/definitions.mk
-include vendor/nvidia/build/definitions.mk
endif

# FIXME: We have no recovery :(

#TARGET_RECOVERY_UI_LIB := librecovery_ui_picasso
#TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

# Avoid the generation of ldrcc instructions
NEED_WORKAROUND_CORTEX_A9_745320 := true
# u-boot parameters
# Notes: this is original command line
#BOARD_KERNEL_CMDLINE := tegraid=20.1.3.0.0 mem=1024M@0M vmalloc=256M video=tegrafb console=none debug_uartport=hsport usbcore.old_scheme_first=1 tegra_fbmem=8197120@0x3d81c000 lp0_vec=8192@0x1840c000 brand=acer target_product=a500_ww_gen1 tegraboot=sdmmc gpt gpt_sector=31258623
BOARD_KERNEL_CMDLINE :=
