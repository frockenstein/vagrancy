define wordpress::config (
  $install_dir,
  $wp_owner,
  $wp_group,
  $db_name,
  $db_host,
  $db_user,
  $db_password,
  $wp_lang,
  $wp_multisite,
  $wp_subdomain_install,
  $wp_domain_current_site,
  $wp_path_current_site,
  $wp_site_id_current_site,
  $wp_blog_id_current_site,

  $saltfile = 'wp-keysalts.php',
  $configfile = 'wp-config.php',
) {

    notify { "writing wordpress config with $name": }
    ## Configure wordpress
    #
    # Template uses no variables
    file { "${install_dir}/${saltfile}":
      ensure  => present,
      content => template('wordpress/wp-keysalts.php.erb'),
      replace => false,
    }
    concat { "${install_dir}/${configfile}":
      owner   => $wp_owner,
      group   => $wp_group,
      mode    => '0755',
    }
    concat::fragment { 'wp-config.php keysalts':
      target  => "${install_dir}/${configfile}",
      source  => "${install_dir}/${saltfile}",
      order   => '10',
      require => File["${install_dir}/${saltfile}"],
    }
    # Template uses: $db_name, $db_user, $db_password, $db_host
    concat::fragment { 'wp-config.php body':
      target  => "${install_dir}/${configfile}",
      content => template('wordpress/wp-config.php.erb'),
      order   => '20',
    }
  }
