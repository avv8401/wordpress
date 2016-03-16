class wordpress (
		  	$vhname 		= 'localhost',
		  	$www 			= "/var/www/wordpress",
		  	$ssl_enable 		= true,
		  	$db_user		= "user",
		 	$db_pass		= "password",
			$db_host		= "localhost",
		  	$db_name		= "dbname",
			$auth_key		= "}FNzb7b,01$X-ffg+bbfyXB#*pvs^n!V^uw+|h|FRyd[#W9=TG#_-#ld*:xAbyH*",
			$secure_auth_key	= "JY|h8L-,+:uy#sRILt-Cz{i@ {p[6J,.vBJ}$wHD@x2+u&T9#U:0)~bOBoDQ}AC.",
			$login_in_key		= "|uUE|7i&b,K94kgT)1?RVc0CZ|T<)M[b>6BWR6p.Yuf<wA>l:?w&I_ylf8tW^qF|",
			$nonce_key		= "SF.`sT$V(KMx9+-M*=?[<|ACD>W:1<G]Ms{w:xP7^R}!.ApKO,+#z$Z@Lj3~{EZW",
			$auth_salt		= "2kcW8};q4[m9qgD~7q=).qw[u,vK:}YOEBD[qW5DGg|=fdhlrRvj{6jLoV^;7lmO",
			$secure_auth_salt       = "T>jtaV94d$35lr*h8D9pZ%CduT70iAxpV-]1H|)Y%5=Fo|(ukGq0Or6lh/?jbUB(",
			$logge_in_salt		= "v=}s1IY|s{l0FB&i<;Orw<1Eq4n3E^Ez@%t<N_*zU^85q~*AUGD|?e TwPJ:#IM&",
			$nonce_salt		= "-TZz(Fp&ax(+;P:q)D1Eb@s;X]]}t$PZ>9i+//B,IitghxYDIZILY?;=q|!bt=H(",
		) {     
			if  defined ( Class ["web_nginx"] ){
				file {$www:
					ensure => $ensure ? {
							'directory' => directory,
							default    => 'directory',
					},
					recurse => true,
					purge   => true,
					source  => "puppet:///modules/wordpress/web",
					owner   => root,
					group   => nginx,

				}
				->
				file { "$www/wp-config.php":
                                        ensure  => present,
                                        content => template('wordpress/wp-config.php.erb'),
                                        mode    => 0640,
                                        owner   => 'nginx',
                                        group   => 'nginx',
                                }

	

				if $ssl_enable {
					file {'/tmp/wordpress.crt':
                                        	recurse => true,
                                        	purge   => true,
                                        	source  => "puppet:///modules/wordpress/ssl_keys/cert.crt",
                                        	owner   => nginx,
                                        	group   => nginx,
                                	}
					->
                                	file {'/tmp/wordpress.key':
                                        	recurse => true,
                                        	purge   => true,
                                        	source  => "puppet:///modules/wordpress/ssl_keys/cert.key",
                                        	owner   => nginx,
                                        	group   => nginx,

                                	}
					->
					nginx::resource::vhost { "${vhname}": 
                				www_root => "$www",
						ssl      => true,
						ssl_cert => '/tmp/wordpress.crt',
   						ssl_key  => '/tmp/wordpress.key',
						rewrite_to_https => true,
        				}
				} else {
					nginx::resource::vhost { "${vhname}":
                                        	www_root => "$www",
						#location_cfg_append => { 
						#'if (!-e $request_filename)' => '{ rewrite ^.+/?(/wp-.*) $1 last; rewrite ^.+/?(/.*\.php)$ $1 last; rewrite ^(.+)$ /index.php?q=$1 last;}#'
						#},
					}

				}

				nginx::resource::location { 'php':
                                        ensure      => present,
                                        vhost       => "${vhname}",
                                        location    => '~ \.php$',
					ssl         => $ssl_enable,
                                        www_root    => "$www",
                                        index_files => ['index.php', 'index.html', 'index.htm'],
                                        fastcgi     => '127.0.0.1:9000',
                                }
                               	nginx::resource::location { 'static':
                                       	ssl                  => $ssl_enable,
                                        ensure               => present,
                                        vhost                => "${vhname}",
                                        location             => '~* ^.+\.(ttf|rss|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|ppt|tar|wav|bmp|rtf)$',
                                        location_custom_cfg  => {
                                                                 'log_not_found' => 'off',
                                                                 'access_log'    => 'off',
								 'expires'	 => 'max',
                                        }

                                }

			}
                        nginx::resource::location { 'robots.txt':
                        	ssl                  => $ssl_enable,
                                ensure               => present,
                                vhost                => "${vhname}",
                                location             => '= /robots.txt',
                                location_custom_cfg  => {
                                               'allow'         => 'all',
                                               'log_not_found' => 'off',
                                               'access_log'    => 'off',
                                }

                        }
					
}
