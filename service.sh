(
  until [ "$(resetprop sys.boot_completed)" -eq "1" ] && [ -d "/sdcard/Android" ]; do
    sleep 1
    done
    sleep 60 && /system/etc/$KEY/$KEY1 2>/dev/null
)&
