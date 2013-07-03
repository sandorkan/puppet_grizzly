class compute::quantum {

	package {'quantum-plugin-openvswitch-agent_pkg':
		name	=> 'quantum-plugin-openvswitch-agent',
		ensure	=> installed,
		before	=> File['ovs.quantum.plugin.ini'],
	}

	file {'ovs.quantum.plugin.ini':
        path    => '/etc/quantum/plugins/openvswitch/ovs_quantum_plugin.ini',
        ensure  => file,
        content => template('compute/quantum/ovs_quantum_plugin.ini.erb'),
        before  => File['quantum.conf'],
		owner   => "root",
        group   => "quantum",
        mode    => 0644,
    }

	file {'quantum.conf':
		path    => '/etc/quantum/quantum.conf',
        ensure  => file,
        content => template('compute/quantum/quantum.conf.erb'),
        before  => Exec['quantum.restart.services'],
		owner   => "root",
        group   => "quantum",
        mode    => 0644,
    }

	exec {'quantum.restart.services':
		command		=> "/etc/puppet/modules/compute/files/quantum/restart.services",
		refreshonly	=> true,
		subscribe	=> File['quantum.conf']
	}
}
