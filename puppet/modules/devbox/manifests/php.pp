class devbox::php {

  php::ini { '/etc/php.ini':
      display_errors => 'On',
      html_errors => 'On',
      memory_limit => '256M',
      upload_max_filesize => '8M',
      post_max_size => '12M',
      notify => Service['php-fpm'],
  }

  include php::cli
  include php::fpm::daemon

  php::fpm::conf { 'vagrancy':
    listen  => '/var/run/php5-fpm.sock',
    user    => 'vagrant',
    group   => 'nginx',
    listen_allowed_clients => '127.0.0.1',
    env     => ['PATH'],
    require => Package['nginx'],
  }

  php::module {[
      'pecl-apc',
      'pecl-memcached',
      'pecl-xdebug',
      'mysql',
  ]:
    notify => Service['php-fpm'],
  }

  file { '/etc/php.d/xdebug.ini':
    ensure => present,
    source => 'puppet:///modules/devbox/xdebug.ini',
    notify => Service['php-fpm'],
  }

  file { '/var/run/php5-fpm.sock':
    owner => 'vagrant',
    group => 'nginx',
    mode => 666
  }
}