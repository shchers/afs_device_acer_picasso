# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
LOCAL_PATH := device/acer/picasso/prebuild/

# FIXME: this is a hack. This modules should be developed, but for now it was extracted from leaked FW.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/acer/camera.tegra.so:system/lib/hw/camera.tegra.so \
    $(LOCAL_PATH)/acer/sensors.tegra.so:system/lib/hw/sensors.tegra.so \
    $(LOCAL_PATH)/acer/asound.conf:system/etc/asound.conf \
    $(LOCAL_PATH)/acer/libasound.so:system/lib/libasound.so \
    $(LOCAL_PATH)/acer/init.rc:root/init.rc \
    $(LOCAL_PATH)/acer/libmpl.so:system/lib/libmpl.so \
    $(LOCAL_PATH)/acer/libmllite.so:system/lib/libmllite.so \
    $(LOCAL_PATH)/acer/libmlplatform.so:system/lib/libmlplatform.so

# Google binaries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/google/bootanimation.zip:system/media/bootanimation.zip

# Broadcom binaries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/broadcom/bcm4329.hcd:system/etc/firmware/bcm4329.hcd \
    $(LOCAL_PATH)/broadcom/bcmdhd.cal:system/etc/wifi/bcmdhd.cal

# nVidia binaries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/nvidia/nvmm_adtsdec.axf:system/etc/firmware/nvmm_adtsdec.axf \
    $(LOCAL_PATH)/nvidia/nvmm_manager.axf:system/etc/firmware/nvmm_manager.axf \
    $(LOCAL_PATH)/nvidia/nvmm_service.axf:system/etc/firmware/nvmm_service.axf \
    $(LOCAL_PATH)/nvidia/nvmm_wmadec.axf:system/etc/firmware/nvmm_wmadec.axf \
    $(LOCAL_PATH)/nvidia/nvmm_h264dec.axf:system/etc/firmware/nvmm_h264dec.axf \
    $(LOCAL_PATH)/nvidia/nvmm_mp3dec.axf:system/etc/firmware/nvmm_mp3dec.axf \
    $(LOCAL_PATH)/nvidia/nvmm_sorensondec.axf:system/etc/firmware/nvmm_sorensondec.axf \
    $(LOCAL_PATH)/nvidia/nvmm_wmaprodec.axf:system/etc/firmware/nvmm_wmaprodec.axf \
    $(LOCAL_PATH)/nvidia/nvmm_jpegdec.axf:system/etc/firmware/nvmm_jpegdec.axf \
    $(LOCAL_PATH)/nvidia/nvmm_mpeg4dec.axf:system/etc/firmware/nvmm_mpeg4dec.axf \
    $(LOCAL_PATH)/nvidia/nvmm_vc1dec.axf:system/etc/firmware/nvmm_vc1dec.axf \
    $(LOCAL_PATH)/nvidia/nvrm_avp.bin:system/etc/firmware/nvrm_avp.bin \
    $(LOCAL_PATH)/nvidia/nvmm_aacdec.axf:system/etc/firmware/nvmm_aacdec.axf \
    $(LOCAL_PATH)/nvidia/nvmm_jpegenc.axf:system/etc/firmware/nvmm_jpegenc.axf \
    $(LOCAL_PATH)/nvidia/nvmm_reference.axf:system/etc/firmware/nvmm_reference.axf \
    $(LOCAL_PATH)/nvidia/nvmm_wavdec.axf:system/etc/firmware/nvmm_wavdec.axf \
    $(LOCAL_PATH)/nvidia/hwcomposer.tegra.so:system/lib/hw/hwcomposer.tegra.so \
    $(LOCAL_PATH)/nvidia/gralloc.tegra.so:system/lib/hw/gralloc.tegra.so \
    $(LOCAL_PATH)/nvidia/libnvddk_2d_v2.so:system/lib/libnvddk_2d_v2.so \
    $(LOCAL_PATH)/nvidia/libnvmmlite_utils.so:system/lib/libnvmmlite_utils.so \
    $(LOCAL_PATH)/nvidia/libnvmm_video.so:system/lib/libnvmm_video.so \
    $(LOCAL_PATH)/nvidia/libnvomx.so:system/lib/libnvomx.so \
    $(LOCAL_PATH)/nvidia/libnvdispmgr_d.so:system/lib/libnvdispmgr_d.so \
    $(LOCAL_PATH)/nvidia/libnvmmlite_video.so:system/lib/libnvmmlite_video.so \
    $(LOCAL_PATH)/nvidia/libnvmm_vp6_video.so:system/lib/libnvmm_vp6_video.so \
    $(LOCAL_PATH)/nvidia/libnvos.so:system/lib/libnvos.so \
    $(LOCAL_PATH)/nvidia/libcgdrv.so:system/lib/libcgdrv.so \
    $(LOCAL_PATH)/nvidia/libnvmm_asfparser.so:system/lib/libnvmm_asfparser.so \
    $(LOCAL_PATH)/nvidia/libnvmm_manager.so:system/lib/libnvmm_manager.so \
    $(LOCAL_PATH)/nvidia/libnvmm_writer.so:system/lib/libnvmm_writer.so \
    $(LOCAL_PATH)/nvidia/libnvparser.so:system/lib/libnvparser.so \
    $(LOCAL_PATH)/nvidia/libnvasfparserhal.so:system/lib/libnvasfparserhal.so \
    $(LOCAL_PATH)/nvidia/libnvmm_audio.so:system/lib/libnvmm_audio.so \
    $(LOCAL_PATH)/nvidia/libnvmm_misc.so:system/lib/libnvmm_misc.so \
    $(LOCAL_PATH)/nvidia/libnvodm_dtvtuner.so:system/lib/libnvodm_dtvtuner.so \
    $(LOCAL_PATH)/nvidia/libnvrm_graphics.so:system/lib/libnvrm_graphics.so \
    $(LOCAL_PATH)/nvidia/libnvaviparserhal.so:system/lib/libnvaviparserhal.so \
    $(LOCAL_PATH)/nvidia/libnvmm_aviparser.so:system/lib/libnvmm_aviparser.so \
    $(LOCAL_PATH)/nvidia/libnvmm_msaudio.so:system/lib/libnvmm_msaudio.so \
    $(LOCAL_PATH)/nvidia/libnvodm_hdmi.so:system/lib/libnvodm_hdmi.so \
    $(LOCAL_PATH)/nvidia/libnvrm.so:system/lib/libnvrm.so \
    $(LOCAL_PATH)/nvidia/libnvavp.so:system/lib/libnvavp.so \
    $(LOCAL_PATH)/nvidia/libnvmm_camera.so:system/lib/libnvmm_camera.so \
    $(LOCAL_PATH)/nvidia/libnvmm_parser.so:system/lib/libnvmm_parser.so \
    $(LOCAL_PATH)/nvidia/libnvodm_imager.so:system/lib/libnvodm_imager.so \
    $(LOCAL_PATH)/nvidia/libnvsm.so:system/lib/libnvsm.so \
    $(LOCAL_PATH)/nvidia/libnvcontrol_jni.so:system/lib/libnvcontrol_jni.so \
    $(LOCAL_PATH)/nvidia/libnvmm_contentpipe.so:system/lib/libnvmm_contentpipe.so \
    $(LOCAL_PATH)/nvidia/libnvmm_service.so:system/lib/libnvmm_service.so \
    $(LOCAL_PATH)/nvidia/libnvodm_misc.so:system/lib/libnvodm_misc.so \
    $(LOCAL_PATH)/nvidia/libnvtvmr.so:system/lib/libnvtvmr.so \
    $(LOCAL_PATH)/nvidia/libnvcpud_client.so:system/lib/libnvcpud_client.so \
    $(LOCAL_PATH)/nvidia/libnvmm_image.so:system/lib/libnvmm_image.so \
    $(LOCAL_PATH)/nvidia/libnvmm.so:system/lib/libnvmm.so \
    $(LOCAL_PATH)/nvidia/libnvodm_query.so:system/lib/libnvodm_query.so \
    $(LOCAL_PATH)/nvidia/libnvwinsys.so:system/lib/libnvwinsys.so \
    $(LOCAL_PATH)/nvidia/libnvcpud.so:system/lib/libnvcpud.so \
    $(LOCAL_PATH)/nvidia/libnvmmlite_audio.so:system/lib/libnvmmlite_audio.so \
    $(LOCAL_PATH)/nvidia/libnvmm_utils.so:system/lib/libnvmm_utils.so \
    $(LOCAL_PATH)/nvidia/libnvomxadaptor.so:system/lib/libnvomxadaptor.so \
    $(LOCAL_PATH)/nvidia/libnvwsi.so:system/lib/libnvwsi.so \
    $(LOCAL_PATH)/nvidia/libnvddk_2d.so:system/lib/libnvddk_2d.so \
    $(LOCAL_PATH)/nvidia/libnvmmlite.so:system/lib/libnvmmlite.so \
    $(LOCAL_PATH)/nvidia/libnvmm_vc1_video.so:system/lib/libnvmm_vc1_video.so \
    $(LOCAL_PATH)/nvidia/libnvomxilclient.so:system/lib/libnvomxilclient.so \
    $(LOCAL_PATH)/nvidia/libstagefrighthw.so:system/lib/libstagefrighthw.so \
    $(LOCAL_PATH)/nvidia/libEGL_tegra.so:system/lib/egl/libEGL_tegra.so \
    $(LOCAL_PATH)/nvidia/libGLESv1_CM_tegra.so:system/lib/egl/libGLESv1_CM_tegra.so \
    $(LOCAL_PATH)/nvidia/libGLESv2_tegra.so:system/lib/egl/libGLESv2_tegra.so \
    $(LOCAL_PATH)/nvidia/libardrv_dynamic.so:system/lib/libardrv_dynamic.so

# Kernel modules
# WiFi driver
ifeq ($(TARGET_PREBUILT_WIFI_MODULE),)
LOCAL_WIFI_MODULE := $(LOCAL_PATH)/modules/bcm4329.ko
else
LOCAL_WIFI_MODULE := $(TARGET_PREBUILT_WIFI_MODULE)
endif
PRODUCT_COPY_FILES += \
    $(LOCAL_WIFI_MODULE):system/lib/modules/bcm4329.ko

## FIXME: Some(???) scsi driver <- need to check!
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/modules/scsi_wait_scan.ko:system/lib/modules/scsi_wait_scan.ko

## NTFS filesystem module
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/modules/ufsd.ko:system/lib/modules/ufsd.ko
