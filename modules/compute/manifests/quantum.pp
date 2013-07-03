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
    }

	file {'quantum.conf':
		path    => '/etc/quantum/quantum.conf',
        ensure  => file,
        content => template('compute/quantum/quantum.conf.erb'),
        before  => Exec['quantum.restart.services'],
    }

	exec {'quantum.restart.services':
		command		=> "/etc/puppet/modules/compute/files/quantum/restart.services",
		refreshonly	=> true,
		subscribe	=> File['quantum.conf']
	}
}
