class common::set_ip_forward {
	file {'sysctl.conf':
        path    => '/etc/sysctl.conf',
        ensure  => file,
        source  => "puppet:///modules/common/sysctl.conf",
    }

    exec {'cmd_set_ip_forward':
        path    => ["/sbin",],
        command => "sysctl net.ipv4.ip_forward=1",
    }

}
