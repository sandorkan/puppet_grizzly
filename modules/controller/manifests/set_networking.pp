define set_networking{

	file {'interfaces':
		path	=> '/etc/network/interfaces',
		ensure	=> file,
		content	=> template('networking/interfaces.erb'),
	}

	exec {'restart.networking':
		command		=> '/etc/puppet/modules/controller/files/networking/restart.networking',
		refreshonly	=> true,
		subscribe	=> File['interfaces'],
	}
}
