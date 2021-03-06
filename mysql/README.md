This assumes you have local chef, and vagrant setup.
You are also able to read from our chef12 server

At the time of this writing here are the versions I am using:
chef-client version: 12.19.36
Berks version: 5.6.4
Kitchen version: 1.16.0
Vagrant 1.9.3
Virtualbox 5.1.22

Additional Notes are located in some of the files.

Once this is complete you will have an mySQL Vagrant box.  

FYI - From a Vagrant box to access your local box use IP 10.0.2.2.

Here is my directory and file structure that I used
C:.
+---vagrantboxes
          +---mysql
				Berksfile
                node_mysql.json
                role_mysql.rb
                role_base.rb
                vagrant.yaml
                Vagrantfile

change directory to c:\vagrantboxes\mysql
run berks vendor cookbooks/ <- this will download all the cookbooks needed into a cookbooks sub directory located in c:\vagrantboxes\mysql\
vagrant up <- this will start up the box

Since I gave the named the node different from the node file name you will see a new node file created.  This is helpful for re-spinning up the box from scratch if needed.  Just delete the file.

After the box is spun up
vagrant ssh will ssh you into the box

** once connected via ssh you can issue mysql -u root -p -h 127.0.0.1 to connect to mysql
if you want to connect from other boxes issue this command
** GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;  <- The password is defined in the roll 
vagrant provision will re-rerun chef
vagrant destroy will start over

To start over I usually just delete everything except the original files and re-start the process. 
Check out the vagrant.yaml for settings and more notes.


