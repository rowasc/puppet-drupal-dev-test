class other {
  $packages = ["curl", "vim", "emacs", "make", "libtool", "automake", "autoconf","libcurl3-openssl-dev"]
  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }
}
