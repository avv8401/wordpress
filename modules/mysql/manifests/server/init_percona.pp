#
class mysql::server::init_percona {

  file { "/tmp/init_percona.sh":
      source => ["puppet:///modules/mysql/init_percona.sh"]
  }

  exec {"init_percona.sh":
           command=>"/bin/sh /tmp/init_percona.sh",
           path   => "/bin/sh",
           require   => Package['mysql-server'],
  }

}
