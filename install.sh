#!/usr/bin/env bash
# Installs upstart task and creates local init scripts
# You will need to run this script after update or switch to other partition
set -eux

[ "$(id -u)" = 0 ] || {
  echo "$0: must be superuser"
  exit 1
}

mount -o remount,rw / || {
    echo "$0: can't remoout rootfs, have you removed verification from it?"
    exit 1
}

readonly DEST="/etc/init/trigger-local-init.conf"

echo "Installing upstart task to ${DEST}"
cp "$(dirname ${0})/trigger-local-init.conf" "${DEST}"

cd /usr/local
[ -d etc ] || {
    mkdir etc
    chown chronos:chronos etc
}

cd etc
for script in pre-start start post-stop; do
    [ -e "${script}" ] && continue
    echo "Creating $PWD/${script}"    
    printf "#/usr/bin/bash\n" > "${script}"
    chmod a+x "${script}"
    chown chronos:chronos "${script}"
done

mount -o remount,ro /
