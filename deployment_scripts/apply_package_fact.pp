notice('MOULAR: fuel-plugin-upstream/apply_package_fact.pp')

$hiera_dir = '/etc/hiera/plugins'
$plugin_name = 'fuel-plugin-upstream'
$plugin_yaml = "${plugin_name}.yaml"

$override_content = "---\nos_package_type: ubuntu\n"

file { $hiera_dir:
  ensure => directory,
}
file { "${hiera_dir}/${plugin_yaml}":
  ensure  => file,
  content => $override_content
}

# hiera file changes between 7.0 and 8.0 so we need to handle the override the
# different yaml formats via these exec hacks.  It should be noted that the
# fuel hiera task will wipe out these this update to the hiera.yaml
exec { "${plugin_name}_hiera_override_7.0":
  command => "sed -i '/  - override\\/plugins/a\\  - plugins\\/${plugin_name}' /etc/hiera.yaml",
  path    => '/bin:/usr/bin',
  unless  => "grep -q '^  - plugins/${plugin_name}' /etc/hiera.yaml",
  onlyif  => 'grep -q "^  - override/plugins" /etc/hiera.yaml'
}

exec { "${plugin_name}_hiera_override_8.0":
  command => "sed -i '/    - override\\/plugins/a\\    - plugins\\/${plugin_name}' /etc/hiera.yaml",
  path    => '/bin:/usr/bin',
  unless  => "grep -q '^    - plugins/${plugin_name}' /etc/hiera.yaml",
  onlyif  => 'grep -q "^    - override/plugins" /etc/hiera.yaml'
}


