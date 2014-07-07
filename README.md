vagrancy
========

A sample Vagrant + Puppet + WP-CLI combo

### Setting Up Your Virtual Machine

* [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Download Vagrant](http://downloads.vagrantup.com/)
* Install both
* Run `vagrant plugin install vagrant-vbguest` to add the Vbguest plugin to manage Guest Additions for you
* Clone this repo somewhere if you haven't already
* In a shell (ie Git Bash), `cd` to the this repo folder and run `vagrant up`
* Once it's running, run `vagrant provision` to get everything installed
* Edit your hosts file to contain:

`192.168.33.20 www.vagrancy.dev testsite.vagrancy.dev`

Browse the site and you should have a functioning multisite blog!

### HELP!

You've created the VM, run `vagrant provision`, but still can't get a site?

* Is your computer on? :)
* Have you cleared cookies?
* Is your firewall on?
* Is the VM's firewall on? (`vagrant ssh` then `sudo service iptables stop`)
* Can you `ping www.vagrancy.dev` ?
* Can you `curl www.vagrancy.dev` from your dev box?

