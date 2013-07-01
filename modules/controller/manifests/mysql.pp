class controller::mysql {
	
	file {'mysql.preseed':
        path    => '/etc/puppet/modules/controller/files/mysql/mysql.preseed',
        ensure  => file,
        content => template("controller/mysql/mysql.preseed.erb"),
    }
	
	
    exec {'set_mysql_preseed':
        path    => ["/usr/bin", "/bin"],
        command => 'cat /etc/puppet/modules/controller/files/mysql/mysql.preseed | sudo debconf-set-selections',
        require => File["mysql.preseed"],
    }

    package {'mysql-server':
        ensure  => installed,
        require => Exec['set_mysql_preseed']
    }
	
    file {'my.cnf':
        path    => '/etc/mysql/my.cnf',
        ensure  => file,
        require => Package['mysql-server'],
        content => template("controller/mysql/my.cnf.erb"),
    }

    service {'mysql':
        ensure      => running,
        enable      => true,
        subscribe   => File['my.cnf'],
    }
	
	file {'mysql-db-shell-script':
        path    => '/etc/puppet/modules/controller/files/mysql/creating.database.script',
        ensure  => file,
        require => File['my.cnf'],
        content => template("controller/mysql/creating.database.script.erb"),
        mode    => 744,
    }

    exec {'create_dbs_and_users':
        path        => ["/usr/bin", "/usr/sbin", "/bin"],
        command     => '/etc/puppet/modules/controller/files/mysql/creating.database.script',
        subscribe   => File["mysql-db-shell-script"],
        refreshonly => true,
    }	
}
