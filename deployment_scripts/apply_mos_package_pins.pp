notice('MOULAR: fuel-plugin-upstream/apply_mos_package_pins.pp')

$ceph_packages = ['ceph', 'ceph-common', 'libradosstriper1', 'python-ceph',
  'python-rbd', 'python-rados', 'python-cephfs', 'libcephfs1', 'librados2',
  'librbd1', 'radosgw', 'rbd-fuse']

apt::pin { 'haproxy-mos':
  packages => 'haproxy',
  version  => '1.5.3-*',
  priority => '2000',
}

apt::pin { 'ceph-mos':
  packages => $ceph_packages,
  version  => '0.94*',
  priority => '2000',
}

apt::pin { 'rabbitmq-server-mos':
  packages => 'rabbitmq-server',
  version  => '3.5.6-*',
  priority => '2000',
}

