#!/bin/bash

# useful to just blow away the WordPress install
# without going through a full Puppet reprovision
rm -rf /var/www/vagrancy/public_html/* && mysql -u root -e 'drop database wordpress;'
echo "he's dead jim"
