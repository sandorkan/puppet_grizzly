class purge {
	
    package {'ntp':    			ensure => purged,}
	package {'python-mysqldb':  ensure => purged,}
    package {'vlan':            ensure => purged,}
    package {'bridge-utils':    ensure => purged,}
	package {'keystone':  		ensure => purged,}
    
	package {'mysql-client-5.5':        ensure => purged,}
    package {'mysql-client-core-5.5':	ensure => purged,}
	package {'mysql-common':  			ensure => purged,}
    package {'mysql-server':            ensure => purged,}
    package {'mysql-server-5.5':    	ensure => purged,}
	package {'mysql-server-core-5.5':   ensure => purged,}
	
	package {'glance':   				ensure => purged,}
	package {'glance-api':	            ensure => purged,}
	package {'glance-registry':         ensure => purged,}
	package {'glance-common':  			ensure => purged,}
	
	package {'quantum-common':          ensure => purged,}
    package {'quantum-server':         	ensure => purged,}
    package {'quantum-plugin-openvswitch':	ensure => purged,}

	package {'nova-api':  		ensure => purged,}
	package {'nova-common':		ensure => purged,}
	package {'nova-consoleauth':ensure => purged,}
	package {'nova-novncproxy':	ensure => purged,}
	package {'novnc': 			ensure => purged,}
	package {'nova-cert':  		ensure => purged,}
	package {'nova-conductor':	ensure => purged,}
	package {'nova-doc':  		ensure => purged,}
	package {'nova-scheduler': 	ensure => purged,}
	
	package {'cinder-api':  		ensure => purged,}
	package {'cinder-scheduler':  	ensure => purged,}
	package {'cinder-volume':  		ensure => purged,}
	package {'cinder-common':	 	ensure => purged,}
	package {'iscsitarget':  		ensure => purged,}
	package {'open-iscsi':  		ensure => purged,}
	package {'iscsitarget-dkms':  	ensure => purged,}

	
	exec {'create.lvm.cinder.volume':
        path        => "/sbin",
        command     => "vgremove cinder-volumes && pvremove /dev/sdb1",
	}	

	package {'openstack-dashboard':	ensure => purged,}
	package {'memcached': ensure => purged,}	

	#package {'':  ensure => purged,}

	file {'/etc/puppet/modules/controller/files/keystone/keystone_basic': 	ensure => absent,}
	file {'/etc/puppet/modules/controller/files/keystone/keystone_endpoint': ensure => absent,}
	file {'/etc/puppet/modules/controller/files/mysql/creating.database.script': ensure => absent,}
	file {'/etc/puppet/modules/controller/files/mysql/mysql.preseed': ensure => absent,}

}

include purge
