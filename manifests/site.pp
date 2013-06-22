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

#class {'controller::keystone':}
