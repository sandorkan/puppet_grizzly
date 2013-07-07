class router {

	notify {"hallo router":}	

	class {'common::set_ip_forward':
		before	=> File['router.interfaces'],
	}
	
	file {'router.interfaces':
		path	=> "/etc/network/interfaces",
		ensure	=> file,
		source	=> "puppet:///modules/router/interfaces",
		before	=> Exec['set.ip.tables'],
	}

	exec {'set.ip.tables':
		command		=> "/etc/puppet/modules/router/files/set.ip.tables",
		refreshonly	=> true,
		subscribe	=> File['router.interfaces'],
	}
}
