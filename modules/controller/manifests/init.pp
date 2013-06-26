define controller ( 
	
	$mysql_root_pw				= 'openstack',
	$mysql_bind_address			= '0.0.0.0',

	$mysql_keystone_db_name     = 'keystone',
    $mysql_keystone_username    = 'keystoneUser',
    $mysql_keystone_pw          = 'keystonePass',

    $mysql_glance_db_name       = 'glance',
    $mysql_glance_username      = 'glanceUser',
    $mysql_glance_pw            = 'glancePass',

    $mysql_quantum_db_name      = 'quantum',
    $mysql_quantum_username     = 'quantumUser',
    $mysql_quantum_pw           = 'quantumPass',

    $mysql_nova_db_name         = 'nova',
    $mysql_nova_username        = 'novaUser',
    $mysql_nova_pw              = 'novaPass',

    $mysql_cinder_db_name       = 'cinder',
    $mysql_cinder_username      = 'cinderUser',
    $mysql_cinder_pw            = 'cinderPass',

    $controller_mgmt_network_ip = '10.10.10.51',
    $controller_ext_network_ip  = '192.168.100.51',

	$keystone_admin_pass        = 'admin_pass',
	$keystone_service_pass		= 'service_pass',
	$keystone_service_tenant_name = 'service',
	$keystone_region			= 'RegionOne'
	)


{

	class {'ntp':}
	
	class {'controller::mysql':}

	package {'python-mysqldb': 	ensure => installed,}
	package {'vlan': 			ensure => installed,}
	package {'bridge-utils':	ensure => installed,}

	class {'common::set_ip_forward':}
	class {'controller::keystone':}
	class {'controller::glance':}	
	class {'controller::quantum':}	
	class {'controller::nova':}

	Class['ntp'] -> Class['controller::mysql'] -> Package['python-mysqldb'] -> Package['vlan'] -> Package['bridge-utils'] -> Class['common::set_ip_forward'] -> Class['controller::keystone'] -> Class['controller::glance'] -> Class['controller::quantum'] -> Class['controller::nova']	
	
}

