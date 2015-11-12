notice('MOULAR: fuel-plugin-upstream/apply_package_repos.pp')

$plugin_config = hiera('fuel-plugin-upstream')
$os_release    = pick($plugin_config['uca_openstack_release'], 'liberty')
$uca_repo_url  = pick($plugin_config['uca_repo_url'], 'http://ubuntu-cloud.archive.canonical.com/ubuntu')

package { 'ubuntu-cloud-keyring':
  ensure  => 'present',
}

apt::source { 'UCA':
  location => $uca_repo_url,
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
