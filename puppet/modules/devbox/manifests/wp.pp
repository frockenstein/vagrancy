class devbox::wp::params {
    $install_dir = "/var/www/vagrancy/public_html"
    $user = 'vagrant'

    $db_name = 'wordpress'
    $db_user = 'wordpress'
    $db_password = 'password'

    # main network site info
    $network_name = 'Vagrancy'
    $network_admin = 'admin'
    $admin_email = 'root@localhost.localdomain'
    $admin_password = 'hobo'

    # test site info
    $site_slug = 'testsite'
    $site_title = 'Test Site'
    $site_domain = 'subsite.vagrancy.dev'
}

class devbox::wp inherits devbox::wp::params {
    anchor { 'devbox::wp::begin': } ->
    class { 'devbox::wp::base': } ->
    class { 'devbox::wp::mu': } ->
    class { 'devbox::wp::sunrise': } ->
    class { 'devbox::wp::plugin': } ->
    anchor { 'devbox::wp::end': }
}

class devbox::wp::base inherits devbox::wp::params {

    notify { "domain is $domain": }

    # DATABASE AND INSTALL FOLDERS
    mysql::db { $db_name:
       user     => $db_user,
       password => $db_password,
       host     => $::hostname,
       grant    => ['all'],
       ensure   => present,
       require  => Class['mysql::server']
    } ->

    file { ['/var/www/vagrancy/', '/var/www/vagrancy/public_html/']:
        ensure => directory,
        owner => $user,
        group => $user,
        mode => 644,
        recurse => true,
        require => Package['nginx'],
    }

    # WP CORE AND WP-CLI INSTALL
    exec { 'Install wp-cli':
        cwd => '/home/vagrant/',
        logoutput => true,
        user => $user,
        command => "curl -k -L https://raw.github.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > wp-cli.phar; chmod +x wp-cli.phar; sudo mv wp-cli.phar /usr/bin/wp",
        timeout => 30,
        tries => 2,
        creates => '/usr/bin/wp',
        require => [
            Package['nginx'],
            Class['mysql::server'],
        ],
    }

    exec { 'Core Download':
        cwd => $install_dir,
        user => $user,
        command => "wp core download",
        require => [
            Exec['Install wp-cli'],
            Package['nginx'],
            Class['mysql::server']
        ],
        creates => "$install_dir/index.php",
    }

    # Notice the commented-out sunrise file - used
    # in Update Config File section
    exec { 'Core Config':
        cwd => $install_dir,
        user => $user,
        logoutput => true,
        command => "wp core config --dbname=$db_name --dbuser=$db_user --dbpass=$db_password --extra-php <<PHP
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('SCRIPT_DEBUG', true);
//define('SUNRISE', 'on');
PHP",
        creates => "$install_dir/wp-config.php",
        require => [
            Exec['Core Download'],
            Package['nginx'],
            Class['mysql::server'],
        ],
    }
}


class devbox::wp::mu inherits devbox::wp::params {

    exec { 'Install Multisite':
        cwd => $install_dir,
        logoutput => true,
        user => $user,
        creates => "$install_dir/install-multisite.html",
        command => "wp core multisite-install --path=$install_dir --url=$domain --subdomains --title=$network_name --admin_user=admin --admin_password=$admin_password --admin_email=$admin_email > install-multisite.html",
        require => [
            Class['mysql::server'],
            Exec['Core Config']
        ],
    }

    # ACT ON THE MULTISITE INSTALL NOW...
    exec { 'Install Domain Plugin':
        cwd => "$install_dir/wp-content/plugins/",
        logoutput => true,
        user => $user,
        creates => "$install_dir/wp-content/plugins/domain-wpcli-master/",
        command => 'wp plugin install https://github.com/sebastiaandegeus/domain-wpcli/archive/master.zip --activate',
        require => Exec['Install Multisite'],
    }

    exec { 'Install Site':
        cwd => $install_dir,
        logoutput => true,
        user => $user,
        creates => "$install_dir/install-site.html",
        command => "wp site create --slug=$site_slug --title=\"$site_title\" > install-site.html",
        require => Exec['Install Domain Plugin'],
    }
}

class devbox::wp::sunrise inherits devbox::wp::params {

    # SUNRISE TURNED ON
    file { "$install_dir/wp-content/sunrise.php":
        ensure => link,
        target => '/vagrant/puppet/modules/devbox/files/sunrise.php',
        require => [
            Exec['Install Domain Plugin'],
        ],
    }

    # Uncomment the sunrise line via sed
    exec { 'Update Config File':
        cwd => $install_dir,
        command => "sed -i '/^\\/\\/define/s//define/g' wp-config.php",
        subscribe => File["$install_dir/wp-content/sunrise.php"],
    }
}

class devbox::wp::plugin inherits devbox::wp::params {

    # PLUGIN AND FOLDERS
    # create mu-plugins folder
    file { "$install_dir/wp-content/mu-plugins/":
        ensure => directory,
        owner => $user,
    }

    exec { 'Flush Rewrite Rules':
        cwd => $install_dir,
        user => $user,
        command => "wp rewrite flush --url=$site_domain --path=$install_dir",
        subscribe => Exec['Update Config File'],
    }

    # HANDY HELPER CRAP
    # symlinks to plugin/wp from home dir
    file { '/home/vagrant/wordpress/':
        ensure => link,
        owner => $user,
        target => "$install_dir",
    }

    file { '/var/www/vagrancy/public_html/phpinfo.php':
        ensure => present,
        owner => $user,
        source => 'puppet:///modules/devbox/phpinfo.php',
        require => File[$install_dir],
    }
}
