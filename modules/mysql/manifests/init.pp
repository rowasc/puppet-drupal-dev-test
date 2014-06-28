class mysql {
  $database_pwd = "qwe123"
  $database = "localdb"
  $database_user ="localuser"
  $database_host = "localhost"
  
  package { "mysql-server":
    ensure => present,
    require => Exec["apt-get update"]
  }

  service { "mysql":
    ensure => running,
    require => Package["mysql-server"],
  }

  exec { "set-mysql-password":
    unless => "mysqladmin -uroot -p$database_pwd status",
    command => "mysqladmin -uroot password $database_pwd",
    require => Service["mysql"]
  }
	
  exec { "set-mysql-db":
    command => "echo 'create database if not exists $database'|mysql -uroot -p$database_pwd",
    require => Service["mysql"]
  }

  exec { "set-mysql-dump-tmp":
    command => "echo -e \"use localdb\"; $(cat /vagrant/data/localdb.sql) > /vagrant/data/tmp.sql;" ,
    require => Service["mysql"]
  }

  exec { "use-mysql-dump-tmp":
   command => "$(mysql -uroot -pqwe123 < /vagrant/data/tmp.sql)",
   subscribe => File["/vagrant/data/tmp.sql"]
  }

}
