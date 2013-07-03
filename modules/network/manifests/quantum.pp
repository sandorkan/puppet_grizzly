class network::quantum {
	
	package {'quantum-plugin-openvswitch-agent_pkg':
		name	=> 'quantum-plugin-openvswitch-agent',
		ensure	=> installed,
		before	=> Package['quantum-dhcp-agent_pkg'],
	}	

	package {'quantum-dhcp-agent_pkg':
        name    => 'quantum-dhcp-agent',
        ensure  => installed,
        before  => Package['quantum-l3-agent_pkg'],
    }

	package {'quantum-l3-agent_pkg':
        name    => 'quantum-l3-agent',
        ensure  => installed,
        before  => Package['quantum-metadata-agent_pkg'],
    }

	package {'quantum-metadata-agent_pkg':
        name    => 'quantum-metadata-agent',
        ensure  => installed,
        before  => File['quantum.api.paste'],
    }

	file {'quantum.api.paste':
        path    => '/etc/quantum/api-paste.ini',
        ensure  => file,
        content => template('network/quantum/api-paste.ini.erb'),
        before	 => File['quantum.ovs.quantum.plugin.ini'],
    }
	
	file {'quantum.ovs.quantum.plugin.ini':
        path    => '/etc/quantum/plugins/openvswitch/ovs_quantum_plugin.ini',
        ensure  => file,
        content => template('network/quantum/ovs_quantum_plugin.ini.erb'),
        before	=> File['quantum.metadata.agent.ini'],
    }

	file {'quantum.metadata.agent.ini':
        path    => '/etc/quantum/metadata_agent.ini',
        ensure  => file,
        content => template('network/quantum/metadata_agent.ini.erb'),
        before	=> File['quantum.quantum.conf'],
    }

	file {'quantum.quantum.conf':
        path    => '/etc/quantum/quantum.conf',
        ensure  => file,
        content => template('network/quantum/quantum.conf.erb'),
        before	=> Exec['quantum.restart.services'],
    }

	exec {'copy.sudoers':
		path		=> "/bin",
		command		=> "cp modules/network/files/quantum/sudoers /etc/sudoers",
		refreshonly	=> true,
		subscribe	=> File['quantum.quantum.conf']		
	}

	exec {'quantum.restart.services':
		command		=> '/etc/puppet/modules/network/files/quantum/restart.services',
		refreshonly	=> true,
		subscribe	=> Exec['copy.sudoers'],
	} 
}
