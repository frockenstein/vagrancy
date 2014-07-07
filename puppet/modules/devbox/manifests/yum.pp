class devbox::yum {

   yumrepo { 'nginx':
      baseurl => 'http://nginx.org/packages/centos/$releasever/$basearch/',
      enabled => 1,
      gpgcheck => 0,
    }

    yumrepo { 'remi':
      mirrorlist => 'http://rpms.famillecollet.com/enterprise/$releasever/remi/mirror',
      enabled => 1,
      gpgcheck => 0,
    }

    yumrepo { 'epel':
      mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
      enabled => 1,
      gpgcheck => 0,
    }

    yumrepo { 'epel-source':
      mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-source-6&arch=$basearch',
      enabled => 1,
      gpgcheck => 0,
    }
}