class controller::quantum {
	
	package {'quantum-server_pkg':
		name	=> 'quantum-server',
		ensure	=> 'installed',
	}

	file {'ovs.quantum.plugin.ini':
		path	=> '/etc/quantum/plugins/openvswitch/ovs_quantum_plugin.ini',
		ensure	=> file,
		content	=> template('controller/quantum/ovs_quantum_plugin.ini.erb'),
		notify  => Service['quantum-server'],
	}

	file {'api.paste.ini':
        path    => '/etc/quantum/api-paste.ini',
        ensure  => file,
        content => template('controller/quantum/api-paste.ini.erb'),
		notify  => Service['quantum-server'],
    }

	file {'quantum.conf':
        path    => '/etc/quantum/quantum.conf',
        ensure  => file,
        content => template('controller/quantum/quantum.conf.erb'),
		notify	=> Service['quantum-server'],
    }
	
	service {'quantum-server':
		ensure	=> running,
		enable	=> true,
	}
}
