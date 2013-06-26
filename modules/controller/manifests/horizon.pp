class controller::horizon {
	
	package {'openstack-dashboard_pkg':
		name	=> 'openstack-dashboard',
		ensure	=> installed,
	}

	package {'memcached_pkg':
		name	=> 'memcached',
		ensure	=> installed,
	}

	

}
