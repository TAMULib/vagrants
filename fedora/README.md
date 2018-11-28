This assumes you have local chef, and vagrant setup.
You are also able to read from our chef12 server

At the time of this writing here are the versions I am using:
chef-client version: 13.4.19
Berks version: 6.3.1
Kitchen version: 1.17.0
Vagrant 1.9.8
Virtualbox 5.1.26

Additional Notes are located in some of the files.

Once this is complete you will have an Apache Tomcat Vagrant box running Fedora.  

FYI - From a Vagrant box to access your local box use IP 10.0.2.2 in my local development I use a local MySQL install that is accessed from the Vagrant box by this ip.

Here is my directory and file structure that I used
C:.
+---vagrantboxes
          +---fedora
                Berksfile
                node_tomcat.json
                role_tomcat.rb
                role_base.rb
                vagrant.yaml
                Vagrantfile

change directory to c:\vagrantboxes\fedora
run berks vendor cookbooks/ <- this will download all the cookbooks needed into a cookbooks sub directory located in c:\vagrantboxes\fedora\
vagrant up <- this will start up the box

Since I gave the named the node different from the node file name you will see a new node file created.  This is helpful for re-spinning up the box from scratch if needed.  Just delete the file.

After the box is spun up
vagrant ssh will ssh you into the box
vagrant provision will re-rerun chef
vagrant destroy will start over

To start over I usually just delete everything except the original files and re-start the process. 
Check out the vagrant.yaml for settings and more notes.
