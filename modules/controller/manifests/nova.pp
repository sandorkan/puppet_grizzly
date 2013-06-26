class controller::nova {

	package{'nova-api_pkg':
		name	=> 'nova-api',
		ensure	=> installed,
		before	=> Package['nova-cert_pkg'],
	}

	package{'nova-cert_pkg':
        name    => 'nova-cert',
        ensure  => installed,
		before  => Package['novnc_pkg'],
    }

	package{'novnc_pkg':
        name    => 'novnc',
        ensure  => installed,
		before  => Package['nova-consoleauth_pkg'],
    }

	package{'nova-consoleauth_pkg':
        name    => 'nova-consoleauth',
        ensure  => installed,
		before  => Package['nova-scheduler_pkg'],
    }

	package{'nova-scheduler_pkg':
        name    => 'nova-scheduler',
        ensure  => installed,
		before  => Package['nova-novncproxy_pkg'],
    }

	package{'nova-novncproxy_pkg':
        name    => 'nova-novncproxy',
        ensure  => installed,
		before  => Package['nova-doc_pkg'],
    }

	package{'nova-doc_pkg':
        name    => 'nova-doc',
        ensure  => installed,
		before  => Package['nova-conductor_pkg'],
    }

	package{'nova-conductor_pkg':
        name    => 'nova-conductor',
        ensure  => installed,
    }

	exec {'sync.nova.db':
		path		=> "/usr/bin",
		command		=> "nova-manage db sync",
		refreshonly	=> true,
		subscribe	=> [File['nova.api.paste.ini'],File['nova.conf']],
	}

	file {'nova.api.paste.ini':
		path	=> '/etc/nova/api-paste.ini',
		ensure	=> file,
		content	=> template('controller/nova/api-paste.ini.erb'),
		require	=> Package['nova-conductor_pkg'],
	}

	file {'nova.conf':
        path    => '/etc/nova/nova.conf',
        ensure  => file,
        content => template('controller/nova/nova.conf.erb'),
		require	=> Package['nova-conductor_pkg'],
    }

	service {'nova-api':
		ensure		=> running,
		enable		=> true,
		subscribe	=> [File['nova.api.paste.ini'],File['nova.conf']],
	}

	service {'nova-cert':
        ensure      => running,
        enable      => true,
        subscribe   => [File['nova.api.paste.ini'],File['nova.conf']],
    }

	service {'nova-conductor':
        ensure      => running,
        enable      => true,
        subscribe   => [File['nova.api.paste.ini'],File['nova.conf']],
    }

	service {'nova-consoleauth':
        ensure      => running,
        enable      => true,
        subscribe   => [File['nova.api.paste.ini'],File['nova.conf']],
    }

	service {'nova-novncproxy':
        ensure      => running,
        enable      => true,
        subscribe   => [File['nova.api.paste.ini'],File['nova.conf']],
    }

	service {'nova-scheduler':
        ensure      => running,
        enable      => true,
        subscribe   => [File['nova.api.paste.ini'],File['nova.conf']],
    }
}
