Setting up Apache / PHP Vagrant box using tl_app cookbook

This assumes you have local chef, and vagrant setup.
You are also able to issue commands to our chef12 server
Four files are attached to this document.
Additional Notes are located in some of the files.

Once this is complete you will have an Apache PHP Vagrant box with a shared document root so you can develop local and run a virtual www server.  My example adds additional php packages so that I could test out my local application.

From a Vagrant box to access your local box use IP 10.0.2.2 
In my local application I used a local MySQL install that is accessed from the Vagrant box.
 
# Here is my directory and file structure that I used
c:\vagrantboxes\apache-php\
c:\vagrantboxes\chef\cookbooks\
c:\vagrantboxes\chef\nodes\
c:\vagrantboxes\chef\roles\
c:\vagrantboxes\chef\html\

c:\vagrantboxes\apache-php\Berksfile <- Berks File 
c:\vagrantboxes\apache-php\Vagrantfile <- Vagrant File 
c:\vagrantboxes\chef\nodes\apache-php.json <- Node File
c:\vagrantboxes\chef\roles\apache-php.rb <- Role File

create directory c:\vagrantboxes\apache-php
copy Vagrantfile to c:\vagrantboxes\apache-php
copy Berksfile to c:\vagrantboxes\apache-php
change directory to c:\vagrantboxes\apache-php
run berks vendor ../chef/cookbooks/ <- this will download cookbooks needed to c:\vagrantboxes\chef\cookbooks
vagrant up
vagrant ssh will ssh you into the box
vagrant provision will re-rerun chef
vagrant destroy will start over.
For Apache you need to change the node definition to have "tags": [ "fresh_install" ] to re-deploy.
Things to check or change
In the Berksfile
Check the cookbooks needed and where to find them
In the Vagrantfile
Check the variables
Node and Role definition
check the sync folders
Forward additional ports

In the Node file
Check that the node file exists and name matches vagrantfile

In the Role file
Check that the node file exists and name matches vagrantfile
Check that the document_root is the same as the $vm_sync_folder defined in vagrantfile