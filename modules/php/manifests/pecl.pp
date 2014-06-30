class php::pecl {
  include php
  include pear
  include other


  file { "/etc/php5/conf.d/uploadprogress.ini":
    ensure => present,
    source => "/vagrant/modules/php/manifests/php_extensions/uploadprogress.ini",
    require => Exec["pecl install -f -a uploadprogress"]
  }
  #install uploadprogress, which is a drupal requirement
  exec {"pecl install -f -a uploadprogress":
     command => "pecl install -f -a uploadprogress",
     logoutput => on_failure
  }

}
