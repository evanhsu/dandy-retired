#!/bin/bash
#This shell script is called during Provisioning when a Vagrant Virtual Machine is started because it is called from the Vagrantfile.
# If provisioning fails with errors like "RVM is not a function...", then you'll need to manually run this script
# from inside the vagrant machine after it's up and running like this:
#
#       $ vagrant ssh
#       vagrant@vagrant:~$ /vagrant/bootstrap.sh
#
# Then you can exit the ssh session

cd /vagrant  #This is the vagrant shared folder where the rails app lives

# Create the 'dandy_dev' and 'dandy_test' users in mysql
sudo mysql -h127.0.0.1 -uroot -pvagrant -e "GRANT ALL PRIVILEGES ON *.* TO 'dandy_dev' IDENTIFIED BY 'dandypass';"
sudo mysql -h127.0.0.1 -uroot -pvagrant -e "GRANT ALL PRIVILEGES ON *.* TO 'dandy_test' IDENTIFIED BY 'dandypass';"

rvm default ruby-2.0.0-p645 # Change to this (old) ruby version for compatibility with the old gems used in this project
rvm use ruby-2.0.0-p645

bundle install
bundle exec rake db:create
#bundle exec rake db:schema:load
#bundle exec rake db:data:load
mysql -h127.0.0.1 -udandy_dev -pdandypass < mysql_backup_2018-01-23.sql # Load the database with real data

bundle exec rails server -d

echo "======================"
echo "The Rails app has been configured."
echo "Rails server running in detached mode"
echo "To stop the server, SSH into the vagrant machine and run 'lsof -i :3000' :"
echo " "
echo "$ vagrant ssh"
echo "$ lsof -i :3000"
echo ""
echo "Access the site in your browser at http://localhost:3000"


