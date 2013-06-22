define controller (){

	class {'ntp':}
	
	mysql {'mysql-server':}

	package {'python-mysqldb':
		ensure => installed,
	}
	
	package {'vlan':
		ensure => installed,
	}

	package {'bridge-utils':
		ensure => installed,
	}

	file {'sysctl.conf':
		path	=> '/etc/sysctl.conf',
		ensure	=> file,
		source  => "puppet:///modules/controller/sysctl.conf",
	}
	
	exec {'set_ip_forward':
		path	=> ["/sbin",],
		command	=> "sysctl net.ipv4.ip_forward=1",
	}
			
	Class['ntp'] -> Mysql['mysql-server'] -> Package['python-mysqldb'] -> Package['vlan'] -> Package['bridge-utils']
	-> File['sysctl.conf'] -> Exec['set_ip_forward']	
}
