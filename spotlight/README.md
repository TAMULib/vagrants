To get this working I had to run the following:

Start with enable_sync : false in the vagrant.yaml
vagrant up
vagrant ssh
sudo yum install kernel-uek-devel-4.1.12-124.18.6.el7uek.x86_64
cd /opt/VBoxGuestAdditions-x.x.x/init
sudo ./vboxadd setup
sudo mkdir /var/www/blacklight-copy
sudo chown blacklight:blacklight /var/www/blacklight-copy/
exit

set enable_sync: true and set the sync folder blacklight-copy
vagrant reload
vagrant ssh
cp -r /var/www/rails/blacklight /var/www/blacklight-copy

change sync folder to /var/www/rails/blacklight/app
vagrant reload

sudo su - blacklight
cd /var/www/rails/blackligt
bundle exec solr_wrapper


make changes then: 
passenger-config restart-app
to apply them


Mount syncdir:
mount -t vboxsf -o dmode=777,fmode=777,uid=1000,gid=1000 www3 /home/blacklight-repo


This assumes you have local chef, and vagrant setup.
You are also able to read from our chef12 server

At the time of this writing here are the versions I am using:
chef-client version: 12.19.36
Berks version: 5.6.4
Kitchen version: 1.16.0
Vagrant 1.9.3
Virtualbox 5.1.22

Additional Notes are located in some of the files.

Once this is complete you will have an Apache PHP Vagrant box with a shared document root so you can develop local and run a virtual box with a www server that has a doc root on your local drive for development.  

FYI - From a Vagrant box to access your local box use IP 10.0.2.2 in my local development I use a local MySQL install that is accessed from the Vagrant box by this ip.

Here is my directory and file structure that I used
C:.
+---vagrantboxes
          +---apache-php
				Berksfile
                node_apache.json
                role_apache.rb
                role_base.rb
                vagrant.yaml
                Vagrantfile

change directory to c:\vagrantboxes\apache-php
run berks vendor cookbooks/ <- this will download all the cookbooks needed into a cookbooks sub directory located in c:\vagrantboxes\apache-php\
vagrant up <- this will start up the box

Since I gave the named the node different from the node file name you will see a new node file created.  This is helpful for re-spinning up the box from scratch if needed.  Just delete the file.

After the box is spun up
vagrant ssh will ssh you into the box
vagrant provision will re-rerun chef
vagrant destroy will start over

To start over I usually just delete everything except the original files and re-start the process. 
Check out the vagrant.yaml for settings and more notes.
