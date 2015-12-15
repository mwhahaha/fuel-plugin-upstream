notice('MOULAR: fuel-plugin-upstream/apply_package_fact.pp')

$hiera_dir = '/etc/hiera/override'
$plugin_name = 'upstream'
$plugin_yaml = "${plugin_name}.yaml"

$override_content = "---\nos_package_type: ubuntu\n"

file { $hiera_dir:
  ensure => directory,
}
file { "${hiera_dir}/${plugin_yaml}":
  ensure  => file,
  content => $override_content
}

file_line { "${plugin_name}_hiera_ovverride":
  path  => '/etc/hiera.yaml',
  line  => "  - override/${plugin_name}",
  after => '  - override/plugins'
}
