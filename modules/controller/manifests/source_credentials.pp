class controller::source_credentials {
	
	
#	exec {'export OS_TENANT_NAME=admin':}
#	exec {'export OS_USERNAME=admin':}
#	exec {'export OS_PASSWORD=$controller::keystone_admin_pass':}
#	exec {'export OS_AUTH_URL="http://${controller::controller_ext_network_ip}:5000/v2.0/"':}

}
