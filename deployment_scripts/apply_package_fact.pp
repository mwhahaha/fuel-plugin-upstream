notice('MOULAR: fuel-plugin-upstream/apply_package_fact.pp')

$hiera_dir = '/etc/hiera/plugins'
$plugin_name = 'fuel-plugin-upstream'
$plugin_yaml = "${plugin_name}.yaml"

$plugin_config = hiera($plugin_name)
$repo_type     = $plugin_config['repo_type']
case $repo_type {
  'uca':   { $package_type = 'ubuntu' }
  default: { $package_type = 'debian' }
}
$override_content = "---\nos_package_type: ${package_type}\n"

file { $hiera_dir:
  ensure => directory,
}
file { "${hiera_dir}/${plugin_yaml}":
  ensure  => file,
  content => $override_content
}
