class ntp ($servers = undef) {
	$service_name = 'ntp'
    $conf_file    = 'ntp.conf'
    $default_servers = ["0.debian.pool.ntp.org iburst",
                        "1.debian.pool.ntp.org iburst",
                        "2.debian.pool.ntp.org iburst",
                        "3.debian.pool.ntp.org iburst",]
       
      
    if $servers == undef {
        $servers_real = $default_servers
    }
    else {
        $servers_real = $servers
    }

    package { 'ntp':
      ensure => installed,
    }

    file { 'ntp.conf':
        path    => '/etc/ntp.conf',
        ensure  => file,
        require => Package['ntp'],
        content => template("ntp/${conf_file}.erb"),
      }

     service { 'ntp':
        name      => $service_name,
        ensure    => running,
        enable    => true,
        subscribe => File['ntp.conf'],
      }
}
