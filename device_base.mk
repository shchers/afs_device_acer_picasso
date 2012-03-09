#
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

DEVICE_PACKAGE_OVERLAYS := \
    device/acer/picasso/overlay

PRODUCT_PROPERTY_OVERRIDES := \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

include frameworks/base/build/tablet-dalvik-heap.mk

PRODUCT_COPY_FILES += \
    device/acer/picasso/init.picasso.rc:root/init.picasso.rc \
    device/acer/picasso/init.picasso.usb.rc:root/init.picasso.usb.rc \
    device/acer/picasso/ueventd.picasso.rc:root/ueventd.picasso.rc \
    device/acer/picasso/postboot.sh:root/postboot.sh

PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/base/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/base/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

PRODUCT_COPY_FILES += \
    device/acer/picasso/vold.fstab:system/etc/vold.fstab \
    device/acer/picasso/idc/atmel-maxtouch.idc:system/usr/idc/atmel-maxtouch.idc \
    device/acer/picasso/idc/panjit_touch.idc:system/usr/idc/panjit_touch.idc \
    device/acer/picasso/keylayout/Acer-AK00LB.kl:system/usr/keylayout/Acer-AK00LB.kl \
    device/acer/picasso/keylayout/acer-dock.kl:system/usr/keylayout/acer-dock.kl \
    device/acer/picasso/keylayout/Bluetooth_00_06_66_42.kl:system/usr/keylayout/Bluetooth_00_06_66_42.kl \
    device/acer/picasso/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    device/acer/picasso/keychars/Acer-AK00LB.kcm:system/usr/keychars/Acer-AK00LB.kcm

PRODUCT_PACKAGES := \
    audio.a2dp.default \
    librs_jni \
    make_ext4fs \
    l2ping \
    hcitool \
    bttest \
    com.android.future.usb.accessory
#    camera.picasso
#    sensors.picasso
#    lights.picasso
#    audio.primary.picasso
#    audio_policy.picasso


PRODUCT_CHARACTERISTICS := tablet

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# media config xml file
PRODUCT_COPY_FILES += \
    device/acer/picasso/media_profiles.xml:system/etc/media_profiles.xml

# Bluetooth config file
PRODUCT_COPY_FILES += \
    system/bluetooth/data/main.nonsmartphone.conf:system/etc/bluetooth/main.conf \

# inherit from the non-open-source side, if present
ifneq ($(filter full_picasso picasso,$(TARGET_PRODUCT)),)
$(call inherit-product-if-exists, vendor/acer/picasso/picasso-vendor.mk)
endif

include device/acer/picasso/prebuild/prebuilds.mk