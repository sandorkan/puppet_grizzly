class controller::keystone {
	
	package{'keystone_pkg': 
		ensure 	=> installed,
		name	=> 'keystone',
	}

	file {'keystone.conf':
		path	=> '/etc/keystone/keystone.conf',
		ensure	=> file,
		content	=> template("controller/keystone/keystone.conf.erb"),
	}

	service {'keystone':
		ensure		=> running,
		enable		=> true,
		subscribe	=> File['keystone.conf'],
	}

	exec {'sync_keystone_db':
		path		=> ["/usr/bin"],
		command		=> "keystone-manage db_sync",
		subscribe	=> File['keystone.conf'],
		refreshonly	=> true,
	}

	file {'keystone_basic_script':
		ensure		=> file,
		path		=> '/etc/puppet/modules/controller/files/keystone/keystone_basic',
		content		=> template("controller/keystone/keystone_basic.sh.erb"),
		mode		=> 755,
	}

	exec {'run_keystone_basic_script':
		command		=> '/etc/puppet/modules/controller/files/keystone/keystone_basic',
		subscribe	=> File['keystone_basic_script'],
		refreshonly	=> true,
		provider	=> shell,
		returns		=> [0,2],
	}
	
    file {'keystone_endpoint_script':
        path        => '/etc/puppet/modules/controller/files/keystone/keystone_endpoint',
        content     => template("controller/keystone/keystone_endpoints_basic.sh.erb"),
        mode        => 755,
		ensure		=> file,		
    }   

    exec {'run_keystone_endpoint_script':        
		command     => '/etc/puppet/modules/controller/files/keystone/keystone_endpoint',
        subscribe   => File['keystone_endpoint_script'],
        refreshonly => true,
        provider    => shell,
    }

	Package['keystone_pkg'] -> File['keystone.conf'] -> Exec['sync_keystone_db'] -> File['keystone_basic_script'] -> Exec['run_keystone_basic_script'] -> File['keystone_endpoint_script'] -> Exec['run_keystone_endpoint_script']
}
