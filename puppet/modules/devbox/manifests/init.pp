class devbox {

    Exec { path => ["/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin"] }

    service { 'iptables':
        ensure => stopped
    }

    host { 'Update Hosts':
        name => 'www.vagrancy.dev',
        ip => '127.0.0.1',
    }

    file_line { 'Fix resolv.conf':
        ensure => present,
        path => '/etc/resolv.conf',
        line => "nameserver 8.8.8.8",
    }

    include devbox::yum
    include devbox::nginx
    include devbox::php
    include mysql
    include mysql::server
    include devbox::couchbase
    include git
    include devbox::wp

}