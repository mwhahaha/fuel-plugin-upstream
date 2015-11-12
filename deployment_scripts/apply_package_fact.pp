notice('MOULAR: fuel-plugin-upstream/apply_package_fact.pp')

file { ['/etc/facter', '/etc/facter/facts.d']:
  ensure => 'directory'
}

file { '/etc/facter/facts.d/os_package_type.txt':
  ensure  => 'file',
  content => 'os_package_type=ubuntu'
}
