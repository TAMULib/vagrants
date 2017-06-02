Setting up Apache / PHP Vagrant box using tl_app cookbook

This assumes you have local chef, and vagrant setup.
You are also able to issue commands to our chef12 server
Four files are attached to this document.
Additional Notes are located in some of the files.

Once this is complete you will have an Apache PHP Vagrant box with a shared document root so you can develop local and run a virtual www server.  My example adds additional php packages so that I could test out my local application.

From a Vagrant box to access your local box use IP 10.0.2.2 
In my local application I used a local MySQL install that is accessed from the Vagrant box.
 
# Here is my directory and file structure that I used
- ```c:\vagrantboxes\apache-php\```

- ```c:\vagrantboxes\apache-php\Berksfile <- Berks File```
- ```c:\vagrantboxes\apache-php\Vagrantfile <- Vagrant File```
- ```c:\vagrantboxes\apache-php\node.json <- Node File```
- ```c:\vagrantboxes\apache-php\role.rb <- Role File```

create directory c:\vagrantboxes\apache-php
copy Vagrantfile to c:\vagrantboxes\apache-php
copy Berksfile to c:\vagrantboxes\apache-php
copy node.json to c:\vagrantboxes\apache-php
copy role.rb to c:\vagrantboxes\apache-php

change directory to c:\vagrantboxes\apache-php

run berks vendor cookbooks/ <- this will download cookbooks needed to c:\vagrantboxes\apache-php\cookbooks

vagrant up <- this will start up the box

vagrant ssh will ssh you into the box

vagrant provision will re-rerun chef

vagrant destroy will start over.

I setup the node name and role name to a simple default.  These could be any name.  If you change the name
you need to change it in the Vagrantfile also.
  
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
