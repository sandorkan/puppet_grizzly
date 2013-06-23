#mysql {'mysql':}
#class {'ntp':}
controller {'controller1':}
/*
	exec {"foo2":
   		environment => "MYVAR=MYVAL",
	#	path		=> "/bin",
   	#	command      => "/bin/sh -c \"echo \$MYVAR\ > /tmp/test\"",
   		command		=> "echo \$MYVAR > /tmp/test",	
		logoutput    =>  true,
		provider	=> shell,
}
*/
