define network {

    // Here the common parameters are included. sadly I could not access them in the parameters
    include common::parameter

    $mysql_root_pw              = $common::parameter::mysql_root_pw
    $mysql_bind_address         = $common::parameter::mysql_bind_address

    $mysql_keystone_db_name     = $common::parameter::mysql_keystone_db_name
    $mysql_keystone_username    = $common::parameter::mysql_keystone_username
    $mysql_keystone_pw          = $common::parameter::mysql_keystone_pw

    $mysql_glance_db_name       = $common::parameter::mysql_glance_db_name
    $mysql_glance_username      = $common::parameter::mysql_glance_username
    $mysql_glance_pw            = $common::parameter::mysql_glance_pw

    $mysql_quantum_db_name      = $common::parameter::mysql_quantum_db_name
    $mysql_quantum_username     = $common::parameter::mysql_quantum_username
    $mysql_quantum_pw           = $common::parameter::mysql_quantum_pw

    $mysql_nova_db_name         = $common::parameter::mysql_nova_db_name
    $mysql_nova_username        = $common::parameter::mysql_nova_username
    $mysql_nova_pw              = $common::parameter::mysql_nova_pw

    $mysql_cinder_db_name       = $common::parameter::mysql_cinder_db_name
    $mysql_cinder_username      = $common::parameter::mysql_cinder_username
    $mysql_cinder_pw            = $common::parameter::mysql_cinder_pw

    $controller_mgmt_network_ip = $common::parameter::controller_mgmt_network_ip
    $controller_ext_network_ip  = $common::parameter::controller_ext_network_ip

    $keystone_admin_pass        = $common::parameter::keystone_admin_pass
    $keystone_service_pass      = $common::parameter::keystone_service_pass
    $keystone_service_tenant_name = $common::parameter::service_tenant_name
    $keystone_region            = $common::parameter::keystone_region

	class {'ntp':
		servers	=> ["${controller_mgmt_network_ip}",],
	}

}