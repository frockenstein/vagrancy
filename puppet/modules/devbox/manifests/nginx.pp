class devbox::nginx {

    package { 'nginx':
        ensure => installed,
        require => Yumrepo['nginx'],
    }

    file { '/etc/nginx/conf.d/00php-fpm.conf':
        ensure  => present,
        mode    => '0640',
        source  => 'puppet:///modules/devbox/00php-fpm.conf',
        require => Package['nginx'],
        notify => Service['nginx'],
    }

    file { '/etc/nginx/nginx.conf':
        ensure  => present,
        mode    => '0640',
        source  => 'puppet:///modules/devbox/nginx.conf',
        require => Package['nginx'],
        notify => Service['nginx'],
    }

    service { 'nginx':
        ensure => running,
        require => Package['nginx'],
    }

    file { '/etc/nginx/conf.d/default.conf':
        ensure => absent,
        require => Package['nginx'],
    }

    file { '/var/www':
        ensure => directory,
        owner => 'nginx',
        group => 'nginx',
        require => Package['nginx'],
    }
}