class devbox::couchbase {

    $url = 'http://packages.couchbase.com/releases/1.8.1/couchbase-server-enterprise_x86_64_1.8.1.rpm'

    exec { 'install couchbase':
        command => "rpm -i --oldpackage $url",
        unless => 'test -x /opt/couchbase/bin/couchbase-cli',
        user => root,
        logoutput => true
    }

}