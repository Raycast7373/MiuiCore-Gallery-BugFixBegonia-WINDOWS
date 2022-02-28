(
MODDIR=${0%/*}
resetprop ro.product.miui.gallery Xiaomi
resetprop --delete ro.product.mod_device
sleep 180
grant_permission() {
  UID=`pm list packages -U | grep $PKG | sed -n -e "s/package:$PKG uid://p"`
  pm grant $PKG android.permission.READ_EXTERNAL_STORAGE
  pm grant $PKG android.permission.WRITE_EXTERNAL_STORAGE
  pm grant $PKG android.permission.ACCESS_MEDIA_LOCATION
  appops set --uid $UID LEGACY_STORAGE allow
  appops set $PKG READ_EXTERNAL_STORAGE allow
  appops set $PKG WRITE_EXTERNAL_STORAGE allow
  appops set $PKG ACCESS_MEDIA_LOCATION allow
  appops set $PKG READ_MEDIA_AUDIO allow
  appops set $PKG READ_MEDIA_VIDEO allow
  appops set $PKG READ_MEDIA_IMAGES allow
  appops set $PKG WRITE_MEDIA_AUDIO allow
  appops set $PKG WRITE_MEDIA_VIDEO allow
  appops set $PKG WRITE_MEDIA_IMAGES allow
  if [ $PROP -gt 29 ]; then
    appops set $PKG MANAGE_EXTERNAL_STORAGE allow
    appops set $PKG NO_ISOLATED_STORAGE allow
    appops set $PKG AUTO_REVOKE_PERMISSIONS_IF_UNUSED ignore
  fi
  if [ $PROP -gt 30 ]; then
    pm grant $PKG android.permission.INTERNET
  fi
}
PROP=`getprop ro.build.version.sdk`
PKG=com.miui.gallery
grant_permission
appops set $PKG SYSTEM_ALERT_WINDOW allow
PKG=cn.wps.moffice_eng.xiaomi.lite
if pm list packages | grep -Eq $PKG; then
  grant_permission
fi
) 2>/dev/null



