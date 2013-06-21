define mysql ($root_pw='openstack', $bind_address='0.0.0.0'){
	
	file {'mysql.preseed':
		path	=> '/etc/puppet/modules/mysql/files/mysql.preseed',
		ensure	=> file,
		content	=> template("mysql/mysql.preseed.erb"),
	}

	exec {'set_mysql_preseed':
		path    => ["/usr/bin", "/usr/sbin", "/bin"],
		command	=> 'cat /etc/puppet/modules/mysql/files/mysql.preseed | sudo debconf-set-selections',
		require	=> File["mysql.preseed"],
	}

	package {'mysql-server':
		ensure	=> installed,
		require	=> Exec['set_mysql_preseed']
	}

	file {'my.cnf':
		path	=> '/etc/mysql/my.cnf',
		ensure	=> file,
		require	=> Package['mysql-server'],
		content	=> template("mysql/my.cnf.erb"),
	}

	service {'mysql':
		ensure		=> running,
		enable		=> true,
		subscribe	=> File['my.cnf'],
	}

	# wird komischerweise direkt ausgefuehrt
	file {'mysql-db-shell-script':
		path 	=> '/etc/puppet/modules/mysql/files/creating.database.script',
		ensure	=> file,
		require	=> File['my.cnf'],
		content	=> template("mysql/creating.database.script.erb"),
		mode	=> 744,
	}
}
