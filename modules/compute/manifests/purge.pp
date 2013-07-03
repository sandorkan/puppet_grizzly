class purge {

	
    package {'qemu':    			ensure => purged,}
    package {'qemu-keymaps':        ensure => purged,}
	package {'qemu-system':         ensure => purged,}
	package {'qemu-system-arm':     ensure => purged,}
    package {'qemu-system-common':  ensure => purged,}
    package {'qemu-system-mips':    ensure => purged,}
    package {'qemu-system-misc':    ensure => purged,}
    package {'qemu-system-ppc':     ensure => purged,}
    package {'qemu-system-sparc':   ensure => purged,}
    package {'qemu-system-x86':     ensure => purged,}
    package {'qemu-user':           ensure => purged,}
    package {'qemu-utils':          ensure => purged,}

	package {'libvirt-bin':         ensure => purged,}
	package {'libvirt0':			ensure => purged,}

	package {'pm-utils':          	ensure => purged,}

	package {'nova-common':         ensure => purged,}
	package {'nova-compute':        ensure => purged,}
	package {'nova-compute-qemu':	ensure => purged,}

	package {'quantum-common':						ensure => purged,}
    package {'quantum-plugin-openvswitch':        	ensure => purged,}
    package {'quantum-plugin-openvswitch-agent':   	ensure => purged,}

	package {'openvswitch-common':                  ensure => purged,}
    package {'openvswitch-switch':          		ensure => purged,}
    package {'openvswitch-datapath-dkms':    		ensure => purged,}

	
}

include purge
