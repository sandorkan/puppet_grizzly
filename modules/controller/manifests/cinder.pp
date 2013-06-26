class controller::cinder {

	package{'cinder-api_pkg':
		ensure	=> installed,
		name	=> 'cinder-api',
		before	=> Package['cinder-scheduler_pkg'],
	}

	package{'cinder-scheduler_pkg':
        ensure  => installed,
        name    => 'cinder-scheduler',
		before  => Package['cinder-volume_pkg'],
    }

	package{'cinder-volume_pkg':
        ensure  => installed,
        name    => 'cinder-volume',
		before  => Package['iscsitarget_pkg'],
    }

	package{'iscsitarget_pkg':
        ensure  => installed,
        name    => 'iscsitarget',
		before  => Package['open-iscsi_pkg'],
    }

	package{'open-iscsi_pkg':
        ensure  => installed,
        name    => 'open-iscsi',
		before  => Package['iscsitarget-dkms_pkg'],
    }

	package{'iscsitarget-dkms_pkg':
        ensure  => installed,
        name    => 'iscsitarget-dkms',
    }

	file{'iscsitarget':
		path	=> '/etc/default/iscsitarget',
		ensure	=> file,
		require	=> [Package['iscsitarget_pkg'],Package[open-iscsi_pkg],Package[iscsitarget-dkms_pkg]],
		source	=> 'puppet:///modules/controller/cinder/iscsitarget',
	}

	service {'iscsitarget':
		ensure		=> running,
		enable		=> true,
		subscribe	=> File['iscsitarget'],
	}

	service {'open-iscsi':
        ensure      => running,
        enable      => true,
        subscribe   => File['iscsitarget'],
    }
	
	file {'cinder.api.paste':
		ensure	=> file,
		path	=> '/etc/cinder/api-paste.ini',
		content	=> template('controller/cinder/api-paste.ini.erb'),
		require	=> Package['cinder-api_pkg'],
	}
		
	file {'cinder.conf':
        ensure  => file,
        path    => '/etc/cinder/cinder.conf',
        content => template('controller/cinder/cinder.conf.erb'),
        require => File['cinder.api.paste'],
    }

	exec {'sync.cinder.db':
		path		=> '/usr/bin',
		command		=> 'cinder-manage db sync',
		refreshonly	=> true,
		subscribe	=> File['cinder.conf'],
	}

	exec {'create.partition':
		command		=> '/etc/puppet/modules/controller/files/cinder/create_partition',
		subscribe	=> File['cinder.conf'],
		refreshonly	=> true,
	}

	exec {'create.lvm.cinder.volume':
		path		=> "/sbin",
		command		=> "pvcreate /dev/sdb1 && vgcreate cinder-volumes /dev/sdb1",
		refreshonly	=> true,
		subscribe	=> exec['create.partition']
	}

	service {'cinder-api':
        ensure      => running,
        enable      => true,
        subscribe   => [File['cinder.api.paste'],File['cinder.conf']],
    }

	service {'cinder-scheduler':
        ensure      => running,
        enable      => true,
    	subscribe   => [File['cinder.api.paste'],File['cinder.conf']],
	}

	service {'cinder-volume':
        ensure      => running,
        enable      => true,
        subscribe   => [File['cinder.api.paste'],File['cinder.conf']],
    }	
}
