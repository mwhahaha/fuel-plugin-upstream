notice('MOULAR: apply_package_repos.pp')

exec { 'install ubuntu-cloud-keyring':
  command     => 'apt-get -y install ubuntu-cloud-keyring',
  tries       => 3,
  try_sleep   => 1,
  refreshonly => true,
  subscribe   => File["/etc/apt/sources.list.d/uca.list"],
  notify      => Exec['apt_update'],
}

# TODO(aschultz): make release a plugin option
apt::source { 'uca':
  location => 'http://ubuntu-cloud.archive.canonical.com/ubuntu',
  release  => "${::lsbdistcodename}-updates/liberty",
  repos    => 'main'
}
