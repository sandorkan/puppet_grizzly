define network(
	
	$controller_mgmt_network_ip			= '10.10.10.51',

 	$network_mgmt_network_ip 			= '10.10.10.52',
   	$network_mgmt_network_ip_netmask 	= '255.255.255.0',
	$network_mgmt_network_if 			= 'eth0',

   	$network_data_network_ip  			= '10.20.20.52',
	$network_data_network_ip_netmask 	= '255.255.255.0',
   	$network_data_network_if  			= 'eth1',

	$network_ext_network_ip             = '192.168.100.52',
    $network_ext_network_ip_netmask     = '255.255.255.0',
    $network_ext_network_if             = 'eth2',	

	$network_gateway					= '192.168.100.1',
		
	)
	{
	
	# Here the common parameters are included. sadly I could not access them in the parameters
 	
	# ***************
	
		include common::parameter

	# ***************

    $mysql_quantum_db_name      = $common::parameter::mysql_quantum_db_name
    $mysql_quantum_username     = $common::parameter::mysql_quantum_username
    $mysql_quantum_pw           = $common::parameter::mysql_quantum_pw

   	$keystone_service_pass      = $common::parameter::keystone_service_pass
   	$keystone_service_tenant_name = $common::parameter::keystone_service_tenant_name
	$keystone_region            = $common::parameter::keystone_region
	
	class {'ntp':
		servers	=> ['10.10.10.51'],
	}

	package {'vlan': 			ensure => installed,}
	package {'bridge-utils':	ensure => installed,}
	
	class {'common::set_ip_forward':}

    package {'openvswitch-switch':			ensure => installed,}
    package {'openvswitch-datapath-dkms':   ensure => installed,}

	exec {'create.bridges':
		command		=> '/etc/puppet/modules/network/files/openvswitch/create.bridges',
		refreshonly	=> true,
		subscribe	=> Package['openvswitch-datapath-dkms'],
	}

	class {'network::quantum':}

	file {'modified.interfaces':
		path	=> "/etc/network/interfaces",
		ensure	=> file,
		content	=> template("network/openvswitch/interfaces.modified"),
	}

	exec {'add.interface.to.br':
		command		=> "/etc/puppet/modules/network/files/openvswitch/add.interface.to.br",
		refreshonly	=> true,
		subscribe	=> File['modified.interfaces'],
	}

	Class['ntp'] -> Package['vlan'] -> Package['bridge-utils'] -> Class['common::set_ip_forward'] -> Package['openvswitch-switch'] -> Package['openvswitch-datapath-dkms'] -> Exec['create.bridges'] -> Class['network::quantum'] -> File['modified.interfaces'] -> Exec['add.interface.to.br']

}

