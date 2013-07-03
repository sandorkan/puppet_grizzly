class compute::qemu {

	package{'qemu_pkg':
		name	=> 'qemu',
		ensure	=> installed,
		before	=> Package['libvirt-bin_pkg'],
	}

	package{'libvirt-bin_pkg':
        name    => 'libvirt-bin',
        ensure  => installed,
        before  => Package['pm-utils_pkg'],
    }

	package{'pm-utils_pkg':
        name    => 'pm-utils',
        ensure  => installed,
        before  => File['qemu.conf'],
    }

	file {'qemu.conf':
		path	=> "/etc/libvirt/qemu.conf",
		ensure	=> file,
		source	=> "puppet:///modules/compute/qemu/qemu.conf",
		before	=> File['libvirtd.conf'],
		owner   => "root",
        group   => "root",
        mode    => 0644,
	}

	exec {'delete.default.virtual.bridges':
		command	=> "/etc/puppet/modules/compute/files/qemu/delete.default.virtual.bridges",
		refreshonly	=> true,
		subscribe	=> File['qemu.conf'],
	}

	file {'libvirtd.conf':
		path	=> "/etc/libvirt/libvirtd.conf",
		ensure	=> file,
		source	=> "puppet:///modules/compute/qemu/libvirtd.conf",
		before	=> File['libvirt.bin.conf'],
		owner   => "root",
        group   => "root",
        mode    => 0644,
	}
 	
	file {'libvirt.bin.conf':
		path	=> "/etc/init/libvirt-bin.conf",
		ensure	=> file,
		source	=> "puppet:///modules/compute/qemu/libvirt-bin.conf",
		before	=> File['libvirt.bin'],
		owner   => "root",
        group   => "root",
        mode    => 0644,
	}
	
	file {'libvirt.bin':
        path    => "/etc/default/libvirt-bin",
        ensure  => file,
        source  => "puppet:///modules/compute/qemu/libvirt-bin",
        before  => Exec['restart.libvirt.dbus'],
		owner   => "root",
        group   => "root",
        mode    => 0644,

    }

	exec {'restart.libvirt.dbus':
		command		=> "/etc/puppet/modules/compute/files/qemu/restart.libvirt.dbus",
		refreshonly	=> true,
		subscribe	=> File['libvirt.bin'],
	}
}
