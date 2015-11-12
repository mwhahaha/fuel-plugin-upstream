notice('MOULAR: fuel-plugin-upstream/apply_package_repos.pp')

$plugin_config = hiera('fuel-plugin-upstream')
$os_release = $plugin_config['uca_openstack_release']

package { 'ubuntu-cloud-keyring':
  ensure  => 'present',
}

# TODO(aschultz): make release a plugin option
apt::source { 'UCA':
  location => 'http://ubuntu-cloud.archive.canonical.com/ubuntu',
  release  => "${::lsbdistcodename}-updates/${os_release}",
  repos    => 'main'
}

apt::pin { 'UCA':
  packages   => '*',
  release    => "${::lsbdistcodename}-updates",
  originator => 'Canonical',
  codename   => "${::lsbdistcodename}-updates/${os_release}",
  priority   => '9000',
}

Package['ubuntu-cloud-keyring'] ~>
  Exec['apt_update']
