# chromeos-rc-local
Specify services you want to start or one shot commands like changing mount options or tweak power policy.

# Prerequisites
A device running Chromium OS that has been switched to developer mode is needed.

# Usage
Remove rootfs verification if haven't done this already. There is a helper script which you can execute by running `# bash remove-rootfs-verification.sh` which removes verification and keeps rootfs readonly by default.

Run `# bash install.sh` to install upstart task and create placeholder scripts. 

Modification of the rootfs won't survive after update or if you switch partition branches (/usr/local persists as it's not a part of rootfs) so you will need to rerun the install script.

# Use-cases

Treat it like `rc.local` in tradition linux distro. The `example` folder contains some basic examples which make life easier on chrome os. 
