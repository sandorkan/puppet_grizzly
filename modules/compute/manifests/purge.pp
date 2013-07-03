class purge {

	qemu                qemu-system         qemu-system-common  qemu-system-misc    qemu-system-sparc   qemu-user
qemu-keymaps        qemu-system-arm     qemu-system-mips    qemu-system-ppc     qemu-system-x86     qemu-utils
	
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

	package {'pm-utils':          ensure => purged,}
}

include purge
