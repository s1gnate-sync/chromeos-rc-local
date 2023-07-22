#!/usr/bin/env bash
# Removes verification from currently booted kernel allowing rootfs to be remonted as rw 
# You will need to run this script after update or switch to other partition
set -eux

[ "$(id -u)" = 0 ] || {
  echo "$0: must be superuser to remove rootfs verification"
  exit 1
}

readonly ROOTDEV="$(rootdev -s 2>/dev/null)"
readonly ROOTDEV_PARTITION="$(echo $ROOTDEV | sed -n 's/.*[^0-9]\([0-9][0-9]*\)$/\1/p')"
readonly ROOTDEV_DISK="$(rootdev -s -d 2>/dev/null)"
readonly ROOTDEV_KERNEL="$((ROOTDEV_PARTITION - 1))"

/usr/share/vboot/bin/make_dev_ssd.sh \
  --remove_rootfs_verification \
  --nodefault_rw_root \
  --partitions "${ROOTDEV_KERNEL}"

echo "After reboot you will be able to remount rootfs as rw (sudo mount -o remount,rw /)"