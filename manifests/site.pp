        class { 'iptables':
                broadcast_policy => 'drop',
                multicast_policy => 'drop',
                log              => 'none',

        }
        class{ 'mysql_service':
                datadir => '/mysql',
                rpass   => '44tm9aATJ25p8gG1p'
        }
        ->
        mysql::db { 'mydb':
                user     => 'myuser',
                password => 'mypass',
                host     => 'localhost',
                grant    => ['SELECT', 'UPDATE','INSERT','DELETE','CREATE'],
        }
        class { 'web_nginx':
                 php_version    => "php56",
                 pkg            => ['php','php-cli','php-common','php-mysql'],
        }
        ->
        iptables::rule { '05-web':
                command => '-I',
                rule    => '4 -p tcp -m multiport --dports 80,443 -m comment --comment "Allow Web ports"',
        }
        class { 'wordpress':
                ssl_enable => true,
                db_name    => "mydb",
                db_user    => "myuser",
                db_pass    => "mypass",
        }
