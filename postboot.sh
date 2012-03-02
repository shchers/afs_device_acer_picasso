#!/system/bin/sh

echo 1 >/sys/EcControl/LEDAndroidOff
echo 7 > /sys/module/wakelock/parameters/debug_mask
