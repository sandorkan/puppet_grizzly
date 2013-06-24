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

	file {'/etc/puppet/modules/controller/files/keystone/keystone_basic': 	ensure => absent,}
	file {'/etc/puppet/modules/controller/files/keystone/keystone_endpoint': ensure => absent,}
	file {'/etc/puppet/modules/controller/files/mysql/creating.database.script': ensure => absent,}
	file {'/etc/puppet/modules/controller/files/mysql/mysql.preseed': ensure => absent,}

}

include purge
