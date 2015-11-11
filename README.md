fuel-plugin-upstream
====================

This is a plugin for fuel 8.0 that puts in the correct overrides to allow the UCA OpenStack packages to be used.

This plugin will set the os_package_type facts in puppet to 'ubuntu' and pins the haproxy package to leverage the MOS provided package.
