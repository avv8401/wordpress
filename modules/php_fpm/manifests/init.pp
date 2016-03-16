#Class: php_fpm
class php_fpm(
  $user          = 'nginx',
  $group         = 'nginx',
  $pkg           = ['php','php-cli','php-common'],

  $address       = '127.0.0.1',
  $port          = '9000',
  $children      = '1',
  $max_requests  = '1000',
  $start         = true,
  $start_on      = 'filesystem and static-network-up',
  $respawn       = true,
  $respawn_limit = '10 5',
  $options       = '-q -b',
  $cgi_fix       = '0',
) {

  $packages = $pkg 
  package{'php-fpm':
  	 ensure => latest,
  }
  ->
  package{$packages:
  	ensure  => latest,
        notify  => Service['php-fpm'],
  }

 

  file {'www.conf':
    	ensure  => file,
    	path    => '/etc/php-fpm.d/www.conf',
    	content => template('php_fpm/www.conf.erb'),
    	owner   => 'root',
    	group   => 'root',
   	mode    => '0644',
  }
  file {'php.ini':
   	ensure  => file,
    	path    => '/etc/php.ini',
    	content => template('php_fpm/php.ini.erb'),
    	owner   => 'root',
    	group   => 'root',
    	mode    => '0644',
  }
  file {'/var/lib/php/session/':
    	ensure  => directory,
    	group   => 'nginx',
  }



  service {'php-fpm':
    ensure   => $start ? {
      true   => running,
      false  => undef,
    },
    enable   => $start,
    provider => redhat,
  }

  Package['php-fpm']   -> File['www.conf'] -> 
    Service['php-fpm']

  File['www.conf'] ~> Service['php-fpm']

}
