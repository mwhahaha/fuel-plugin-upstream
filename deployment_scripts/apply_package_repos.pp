notice('MOULAR: fuel-plugin-upstream/apply_package_repos.pp')

$plugin_config = hiera('fuel-plugin-upstream')
case $plugin_config['repo_type'] {
  'uca':  {
     $os_release = pick($plugin_config['uca_openstack_release'], 'mitaka')
     $repo_url   = pick($plugin_config['uca_repo_url'], 'http://ubuntu-cloud.archive.canonical.com/ubuntu')
     $release    = "${::lsbdistcodename}-updates/${os_release}"
     $repo_name  = 'UCA'
     $originator = 'Canonical'
  }
  'debian': {
     $os_release = pick($plugin_config['debian_trusty_openstack_release'], 'trusty-mitaka-backports')
     $repo_url   = pick($plugin_config['debian_trusty_repo_url'], 'http://mitaka-trusty.pkgs.mirantis.com/debian')
     $release    = $os_release
     $repo_name  = 'debian_trusty'
     $originator = 'Debian'
  }
  default: {
     fail("Invalid repo type ${plugin_config['repo_type']}")
  }
}

package { 'ubuntu-cloud-keyring':
  ensure  => 'present',
}

apt::source { $repo_name:
  location => $repo_url,
  release  => $release
  repos    => 'main'
}

apt::pin { $repo_name:
  packages   => '*',
  release    => $release
  originator => $originator
  codename   => "${release}/${os_release}",
  priority   => '9000',
}

Package['ubuntu-cloud-keyring'] ~>
  Exec['apt_update']
