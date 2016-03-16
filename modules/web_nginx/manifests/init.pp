class web_nginx (
		$php_version = undef,
		$pkg         = ['php','php-cli','php-common'],

			){
	class { 'nginx':
		#worker_processes=>8,
		worker_rlimit_nofile=>10000,
		worker_connections=>2048,
		sendfile => 'on',
		http_tcp_nopush => 'on',
		server_tokens =>'off'
	}
	file {'/var/www/':
    		ensure => $ensure ? {
      			'directory' => directory,
      			default  => 'directory',
    		},
    		owner  => nginx,
    		group  => nginx,
       	 	mode   => 750,
        }
	if  $php_version {
		yumrepo { "remi-${php_version}":
                	descr		=> "Remi's RPM repository for Enterprise Linux 6",
			mirrorlist	=> "http://rpms.remirepo.net/enterprise/6/$php_version/mirror",
                	gpgkey 		=> "http://rpms.remirepo.net/RPM-GPG-KEY-remi",
                	enabled 	=> 1,
                	gpgcheck 	=> 1,
		}
		yumrepo { "remi":
                        descr           => "Remi's RPM repository for Enterprise Linux 6",
                        mirrorlist      => "http://rpms.remirepo.net/enterprise/6/remi/mirror",
                        gpgkey          => "http://rpms.remirepo.net/RPM-GPG-KEY-remi",
                        enabled         => 1,
                        gpgcheck        => 1,
                }


	}
	class{'php_fpm':
		    pkg          => $pkg
	}
}
