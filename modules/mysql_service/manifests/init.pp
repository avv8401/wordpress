class mysql_service (
	$datadir		= '/mysql',
	$rpass			= 'Win48R15',
        $user			= 'mysql',
	$port            	= '3306',
	$socket          	= '/var/lib/mysql/mysql.sock',
	$log_slow_queries	= '/mysql/slow.log',
	$character_set_server	= 'utf8',
	#размер буфера, выделяемого под индексы и доступного всем потокам. Весьма важная настройка, влияющая на производительность. 
	#Значение по умолчанию 8 МБ, его однозначно стоит увеличить. Рекомендуется 15-30% от общего объема ОЗУ. 
	#Наблюдайте за переменными состояния Key_reads и Key_read_requests, отношение Key_reads/Key_read_requests должно быть как можно меньше (< 0,01). Если это отношение велико, то размер буфера стоит увеличить.
	$key_buffer_size 	= '512M',
	$open_files_limit 	= '65500',
	#максимальное количество параллельных соединений к серверу
	$max_connections 	= '100',
	#максимальный размер памяти, выделяемой для временных таблиц, создаваемых MySQL для своих внутренних нужд/
	$tmp_table_size 	= '128M',
	#максимальный допустимый размер таблицы, хранящейся в памяти (типа MEMORY). Значение по умолчанию 16 МБ, если вы не используете MEMORY таблиц, то установите это значение равным tmp_table_size.
	$max_heap_table_size    = '128M',
	#максимальный размер кэшируемого запроса.
	$query_cache_limit 	= '32M',
	#размер кэша. 0 отключает использование кэша. Для выбора оптимального значения необходимо наблюдать за переменной состояния Qcache_lowmem_prunes и добиться, чтобы ее значение увеличивалось незначительно.
	$query_cache_size       = '64M',
	#Размер по умолчанию 16 КБ. В случае ограниченной памяти или использования только небольших запросов значение можно уменьшить. В случае же постоянного использования больших запросов и достаточного объема памяти, 
	#значение стоит увеличить до предполагаемого среднего размера запроса.
      	$max_allowed_packet 	= '16M',
	#количество кэшированных открытых таблиц для всех потоков. Следует учесть, что каждая запись в этом кэше использует системный дескриптор, поэтому возможно придется увеличивать ограничения на количество дескрипторов (ulimit). 
	#Значение по умолчанию 64, его лучше всего увеличить до общего количества таблиц, если их количество в допустимых рамках. 
	$table_open_cache 	= '512',
	#каждый поток, производящий операции сортировки (ORDER BY) или группировки (GROUP BY), выделяет буфер указанного размера. Значение по умолчанию 2 МБ, если вы используете указанные типы запросов и если позволяет память, 
	#то значение стоит увеличить. Большое значение переменной состояния Sort_merge_passes указывает на необходимость увеличения sort_buffer_size. Также стоит проверить скорость выполнения запросов вида 
	#SELECT * FROM table ORDER BY name DESC на больших таблицах, возможно увеличение буфера лишь замедлит работу (в некоторых тестах это так).
	$sort_buffer_size 	= '16M',
	$read_buffer_size 	= '16M',
	# актуально для запросов с "ORDER BY", т.е. для запросов, результат которых должен быть отсортирован и которые обращаются к таблице, имеющей индексы. 
	$read_rnd_buffer_size 	= '16M',
	#размер буфера, выделяемого MyISAM для сортировки индексов при REPAIR TABLE или для создания индексов при CREATE INDEX, ALTER TABLE. Значение по умолчанию 8 МБ, его стоит увеличить вплоть до 30-40% ОЗУ. 
	#Выигрыш в производительности соответственно будет только при выполнении вышеупомянутых запросов.
	$myisam_sort_buffer_size = '64M',
	#указывает число кэшируемых потоков.
	$thread_cache_size	= '8',

	# Try number of CPU's*2 for thread_concurrency
	$thread_concurrency 	= '8', 
	$innodb_data_file_path	= 'ibdata1:10M:autoextend',
	$innodb_file_per_table  = '1',
	$innodb_buffer_pool_size = '512M',
	$innodb_log_file_size 	= '256M',
	$innodb_log_buffer_size = '4M',
        $remove_default_accounts = false,

){
	class { 'percona_repo' : }
	class { '::mysql::server':
		remove_default_accounts=>true,
  		root_password    => $rpass,
  		override_options => {
    			'mysqld' => {
				       	datadir=> $datadir,
        				user	=>$user,
        				port    =>$port,
        				socket	=>$socket,
					slow_query_log		=> '1',
       					slow_query_log_file 	=> $log_slow_queries,
       					#log-slow-queries 	=> $log_slow_queries,
        				character-set-server	=> $character_set_server,
        				key_buffer_size		=> $key_buffer_size,
        				open_files_limit	=> $open_files_limit,
        				max_connections		=> $max_connections,
        				tmp_table_size		=> $tmp_table_size,
        				max_heap_table_size 	=> $max_heap_table_size,
        				query_cache_limit   	=> $query_cache_limit,
        				query_cache_size 	=> $query_cache_size,
        				max_allowed_packet 	=> $max_allowed_packet,
        				table_open_cache 	=> $table_open_cache,
        				sort_buffer_size	=> $sort_buffer_size,
        				read_buffer_size	=> $read_buffer_size,
        				read_buffer_size	=> $read_rnd_buffer_size,
        				myisam_sort_buffer_size	=> $myisam_sort_buffer_size,
        				thread_cache_size 	=> $thread_cache_size,
        				thread_concurrency	=> $thread_concurrency,  
        				innodb_data_file_path	=> $innodb_data_file_path,
        				innodb_file_per_table	=> $innodb_file_per_table,
        				innodb_buffer_pool_size	=> $innodb_buffer_pool_size,
        				innodb_log_file_size 	=> $innodb_log_file_size,
     					innodb_log_buffer_size	=> $innodb_log_buffer_size,


    		        }
  	        },
        }
	#class {'::mysql::server::mysqltuner':}

       ->
	package { 'mysqltuner':
        	ensure   => present,
        	source   => "http://www6.atomicorp.com/channels/atomic/centos/6/i386/RPMS/mysqltuner-1.2.0-4.el6.art.noarch.rpm",
		provider => 'rpm'
    	}
	->
        file { "/usr/bin/mysqltuner":
          source => ["puppet:///modules/mysql/mysqltuner.pl"],
	  mode   => 755,
       }

}
