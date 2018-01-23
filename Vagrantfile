# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # Use the 'leopard/rwtrusty64' box:
  #   http://leopard.in.ua/rwbox/
  #   RWBox contains:
  #     RVM with compiled Ruby 2.0.0-p645, 2.1.6, 2.2.2
  #     MySQL, PostgreSQL, Redis and Memcached
  #     Dev libs for pg, mysql2, rmagick, curb and another gems
    config.vm.box = "leopard/rwtrusty64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. 
  # The 'leopard/rwtrusty64' box already forwards the following ports:
  #    3000-->3100 (Rails web server)
  #    1080-->1180 
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 5432, host: 5532

  # Create a command to run the provisioning script using a --login shell (so RVM commands will work)
  # This is a workaround for the "RVM is not a function..." error when rvm is invoked from a non-login shell.
  $script = "/bin/bash --login /vagrant/bootstrap.sh"

  # Run a shell script to configure the Rails app and set up the database, load data, etc
  config.vm.provision :shell, privileged: false, inline: $script

end
