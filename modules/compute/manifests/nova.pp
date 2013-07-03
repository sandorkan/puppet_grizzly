class compute::nova {

	package {'nova-compute-qemu_pkg':
		name	=> 'nova-compute-qemu',
		ensure	=> installed,
		before	=> File['api.paste.ini'],
	}

	file {'api.paste.ini':
		path	=> "/etc/nova/api-paste.ini",
		ensure	=> file,
		content	=> template("compute/nova/api-paste.ini.erb"),
		before	=> File['nova.compute.conf'],
		owner   => "nova",
        group   => "nova",
        mode    => 0640,

	}

	file {'nova.compute.conf':
		path	=> "/etc/nova/nova-compute.conf",
		ensure	=> file,
		source	=> "puppet:///modules/compute/nova/nova-compute.conf",
		before	=> File['nova.conf'],
		owner	=> "nova",
		group	=> "nova",
		mode	=> 0600,

	}
	
	file {'nova.conf':
		path	=> "/etc/nova/nova.conf",
		ensure	=> file,
		content	=> template("compute/nova/nova.conf.erb"),
		before 	=> Exec['nova.restart.services'],
		owner   => "nova",
        group   => "nova",
        mode    => 0640,
	}


	exec {'nova.restart.services':
		command		=> "/etc/puppet/modules/compute/files/nova/nova.restart.services",
		refreshonly	=> true,
		subscribe	=> File['nova.conf'],
	}
}
