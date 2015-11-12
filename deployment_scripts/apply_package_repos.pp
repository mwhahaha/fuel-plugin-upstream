notice('MOULAR: fuel-plugin-upstream/apply_package_repos.pp')

package { 'ubuntu-cloud-keyring':
  ensure  => 'present',
}

# TODO(aschultz): make release a plugin option
apt::source { 'UCA':
  location => 'http://ubuntu-cloud.archive.canonical.com/ubuntu',
  release  => "${::lsbdistcodename}-updates/liberty",
  repos    => 'main'
}

apt::pin { 'UCA':
  packages   => '*',
  release    => "${::lsbdistcodename}-updates",
  originator => 'Canonical',
  codename   => "${::lsbdistcodename}-updates/liberty",
  priority   => '9000',
}


Package['ubuntu-cloud-keyring'] ~>
  Exec['apt_update']
