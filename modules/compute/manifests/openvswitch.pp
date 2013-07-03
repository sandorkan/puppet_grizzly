class compute::openvswitch {
	
	package {'openvswitch-switch_pkg':
		name	=> 'openvswitch-switch',
		ensure	=> installed,
		before	=> Package['openvswitch-datapath-dkms_pkg'],
	}

	package {'openvswitch-datapath-dkms_pkg':
		name	=> 'openvswitch-datapath-dkms',
		ensure	=> installed,
	}

	exec {'compute.create.bridge':
		command		=> "/etc/puppet/modules/compute/files/openvswitch/compute.create.bridge",
		refreshonly	=> true,
		subscribe	=> Package['openvswitch-datapath-dkms_pkg'],
	}

}
