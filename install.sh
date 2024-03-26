

on_install() {
  $BOOTMODE || abort "- INSTALLATION FROM RECOVERY NOT SUPPORTED!"
    TMPDIR="/data/adb/modules/FIRUS/"
    MODPATH="/data/adb/modules_update/FIRUS/"
  rm -rf $MODPATH
  rm -rf $TMPDIR
  mkdir -p $TMPDIR
  chcon u:object_r:system_file:s0 $TMPDIR
  cd $TMPDIR || abort "- UNABLE TO CHANGE DIRECTORY"

  ensure_bb
  mount_partitions > /dev/null 2>&1
  boot_actions

  mkdir -p $MODPATH

  unzip -o "$ZIPFILE" -x 'META-INF/*' -d $MODPATH >&2

  set_perm_recursive $MODPATH 0 0 0755 0644
  set_perm_recursive $MODPATH/install 0 0 0755 0755

  [ -f "$MODPATH/install" ] && $MODPATH/install "$MODPATH"

  cd /

    set_perm_recursive $MODPATH/system/etc/* 0 2000 0755 0755
        cp $MODPATH/module.prop $TMPDIR
          touch $TMPDIR/update

  exit 0
}
