define compute(
	
	$controller_mgmt_network_ip			= '10.10.10.51',
	$controller_ext_network_ip			= '192.168.100.51',

 	$compute_mgmt_network_ip 			= '10.10.10.53',
   	$compute_mgmt_network_ip_netmask 	= '255.255.255.0',
	$compute_mgmt_network_if 			= 'eth0',

   	$compute_data_network_ip  			= '10.20.20.53',
	$compute_data_network_ip_netmask 	= '255.255.255.0',
   	$compute_data_network_if  			= 'eth1',

	#$network_gateway					= '192.168.100.1',
	)
	{
	
	# Here the common parameters are included. sadly I could not access them in the parameters
 	
	# ***************
	
		include common::parameter

	# ***************

    $mysql_quantum_db_name      = $common::parameter::mysql_quantum_db_name
    $mysql_quantum_username     = $common::parameter::mysql_quantum_username
    $mysql_quantum_pw           = $common::parameter::mysql_quantum_pw

	$mysql_nova_db_name      	= $common::parameter::mysql_nova_db_name
    $mysql_nova_username     	= $common::parameter::mysql_nova_username
    $mysql_nova_pw           	= $common::parameter::mysql_nova_pw

   	$keystone_service_pass      = $common::parameter::keystone_service_pass
   	$keystone_service_tenant_name = $common::parameter::keystone_service_tenant_name
	$keystone_region            = $common::parameter::keystone_region
	
	class {'ntp':
		servers	=> ['10.10.10.51'],
	}

	package {'vlan': 			ensure => installed,}
	package {'bridge-utils':	ensure => installed,}
	
	class {'common::set_ip_forward':}

	class {'compute::qemu':}
	class {'compute::openvswitch':}
	class {'compute::quantum':}
	class {'compute::nova':}

	Class['ntp'] -> Package['vlan'] -> Package['bridge-utils'] -> Class['common::set_ip_forward'] -> Class['compute::qemu'] -> Class['compute::openvswitch'] -> Class['compute::quantum'] -> Class['compute::nova']
}

