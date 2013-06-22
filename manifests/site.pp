#mysql {'mysql':}
#class {'ntp':}
controller {'controller1':}
/*
$written = 0

file {'test':
	path	=> '/tmp/test.file.script',
	content	=> template("controller/test.script.erb"),
	mode	=> 744,
}

file {'static':
	path	=> '/tmp/static',
	ensure	=> file,
	require => File['test'],
}

exec {'run_script':
	command		=> '/tmp/test.file.script',
	subscribe	=> File['test'],
	refreshonly	=> true,
}
*/
/*
    file {'keystone_basic_script':
        path        => '/etc/puppet/modules/controller/files/keystone/keystone_basic',
        content     => template("controller/keystone/keystone_basic.sh.erb"),
        mode        => 755,
#        before      => Exec['run_keystone_basic_script']
    }
    
    exec {'run_keystone_basic_script':
        command     => '/etc/puppet/modules/controller/files/keystone/keystone_basic',
        subscribe   => File['keystone_basic_script'],
        refreshonly => true,
        provider    => shell,
    }
*/

#class {'controller::keystone':}
