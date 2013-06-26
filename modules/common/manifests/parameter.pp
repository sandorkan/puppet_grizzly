class common::parameter {
	$mysql_root_pw              = 'openstack'
    $mysql_bind_address         = '0.0.0.0'

    $mysql_keystone_db_name     = 'keystone'
    $mysql_keystone_username    = 'keystoneUser'
    $mysql_keystone_pw          = 'keystonePass'

    $mysql_glance_db_name       = 'glance'
    $mysql_glance_username      = 'glanceUser'
    $mysql_glance_pw            = 'glancePass'    

	$mysql_quantum_db_name      = 'quantum'
    $mysql_quantum_username     = 'quantumUser'
    $mysql_quantum_pw           = 'quantumPass'

    $mysql_nova_db_name         = 'nova'
    $mysql_nova_username        = 'novaUser'
    $mysql_nova_pw              = 'novaPass'

    $mysql_cinder_db_name       = 'cinder'
    $mysql_cinder_username      = 'cinderUser'
    $mysql_cinder_pw            = 'cinderPass'

    $controller_mgmt_network_ip = '10.10.10.51'
    $controller_ext_network_ip  = '192.168.100.51'
	
	$network_mgmt_network_ip	= '10.10.10.52'
	$network_ext_network_ip		= '192.168.100.52'
	$network_data_network_ip	= '10.20.20.52'

    $keystone_admin_pass        = 'admin_pass'
    $keystone_service_pass      = 'service_pass'
    $keystone_service_tenant_name = 'service'
    $keystone_region            = 'RegionOne'

}


