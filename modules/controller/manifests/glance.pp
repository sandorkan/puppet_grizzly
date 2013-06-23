class controller::glance {
	package {'glance_pkg':
		ensure	=> installed,
		name	=> 'glance',
	
	}
	file {'glance.api.paste.ini':
		path	=> '/etc/glance/glance-api-paste.ini',
		ensure	=> file,
		content	=> template('controller/glance/glance-api-paste.ini.erb'),
	}

    file {'glance.registry.paste.ini':
        path    => '/etc/glance/glance-registry-paste.ini',
        ensure  => file,
        content => template('controller/glance/glance-registry-paste.ini.erb'),
    }

	file {'glance.api.conf':
        path    => '/etc/glance/glance-api.conf',
        ensure  => file,
        content => template('controller/glance/glance-api.conf.erb'),
    }

	file {'glance.registry.conf':
        path    => '/etc/glance/glance-registry.conf',
        ensure  => file,
        content => template('controller/glance/glance-registry.conf.erb'),
    }

	service {'glance-api':
		ensure		=> running,
		enable		=> true,
 		subscribe	=> [File['glance.api.paste.ini'],File['glance.api.conf']]
	}

	service {'glance-registry':        
		ensure      => running,
        enable      => true,
        subscribe   => [File['glance.registry.paste.ini'],File['glance.registry.conf']]
    }

	exec {'sync.glance.db':
        path        => ["/usr/bin","/bin"],
        command     => "glance-manage db_sync",
        subscribe   => File ['glance.registry.conf'],
        refreshonly => true,
    }


/*
	exec {'sync.glance.db.create.image':
		environment	=> ['OS_TENANT_NAME=admin','OS_USERNAME=admin','OS_PASSWORD=admin_pass','OS_AUTH_URL="http://192.168.100.51:5000/v2.0/"'],
		path		=> ["/usr/bin","/bin"],
		command		=> "glance-manage db_sync && glance image-create --name myFirstImage --is-public true --container-format bare --disk-format qcow2 --location https://launchpad.net/cirros/trunk/0.3.0/+download/cirros-0.3.0-x86_64-disk.img",
		subscribe	=> File ['glance.registry.conf'],
		refreshonly	=> true,
	}
*/

/*
	exec {'create.image':
        path        => ["/usr/bin"],
        command     => "glance image-create --name myFirstImage --is-public true --container-format bare --disk-format qcow2 --location https://launchpad.net/cirros/trunk/0.3.0/+download/cirros-0.3.0-x86_64-disk.img",
        #subscribe   => File ['glance.registry.conf'],
        refreshonly => true,
    }
*/

	Package['glance_pkg'] -> File['glance.api.paste.ini'] -> File['glance.registry.paste.ini'] -> File ['glance.api.conf'] -> File ['glance.registry.conf'] -> Exec['sync.glance.db']


}
