class controller::keystone {
/*	
	package{'keystone_pkg': 
		ensure 	=> installed,
		name	=> 'keystone',
	}

	file {'keystone.conf':
		path	=> '/etc/keystone/keystone.conf',
		ensure	=> file,
		content	=> template("controller/keystone/keystone.conf.erb"),
		require	=> Package['keystone_pkg'],
	
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
		path		=> '/etc/puppet/modules/controller/files/keystone/keystone_basic.sh',
		content		=> template("controller/keystone/keystone_basic.sh.erb"),
		mode		=> 755,
		before		=> Exec['run_keystone_basic_script']
	}

	exec {'run_keystone_basic_script':
		command		=> '/etc/puppet/modules/controller/files/keystone/keystone_basic.sh',
		subscribe	=> File['keystone_basic_script'],
		refreshonly	=> true,
		provider	=> shell,
	}
*/
    file {'keystone_endpoint_script':
        path        => '/etc/puppet/modules/controller/files/keystone/keystone_endpoint.sh',
        content     => template("controller/keystone/keystone_endpoints_basic.sh.erb"),
        mode        => 755,
        before      => Exec['run_keystone_endpoint_script']
    }   

    exec {'run_keystone_endpoint_script':        
		command     => '/etc/puppet/modules/controller/files/keystone/keystone_endpoint.sh',
        subscribe   => File['keystone_endpoint_script'],
        refreshonly => true,
        provider    => shell,
    }

}
