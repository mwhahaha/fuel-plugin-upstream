notice('MOULAR: fuel-plugin-upstream/apply_mos_package_pins.pp')

# we need the mos fork haproxy
apt::pin { 'haproxy-mos':
  packages => 'haproxy',
  version  => '1.5.3-*',
  priority => '9001',
}
