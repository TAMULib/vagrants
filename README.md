# vagrants

TAMU project development vagrants provisioned by development chef server.

## dependencies

1. [virtual box](https://www.virtualbox.org/wiki/Downloads)
2. [chef client](https://downloads.chef.io/chef)
3. [vagrant](https://www.vagrantup.com/downloads.html)
4. [vagrant-triggers plugin](https://github.com/emyl/vagrant-triggers)

## setup

- generate ssh key and register with github account
- retrieve client.pem file registered with chef server
- export environment variable, SSH_ID_RSA, to locate ssh id_rsa key used for the git command
  - ```export SSH_ID_RSA="/Users/aggiejack/.ssh/id_rsa"```
- export environment variable, CHEF_HOME, to locate chef client installation
  - ```export CHEF_HOME="/etc/chef"```
- export environment variable, CHEF_CLIENT_PEM, to locate chef client pem file
  - ```export CHEF_CLIENT_PEM="/etc/chef/client.pem"```

## configure

Roles are defined from the attributes json files.

## deploy

1. ```cd [project]```
2. ```vagrant up```

Deploy will create, configure, provision, and start VMs with the associating project. There will be a synced directory, src directory relative to the Vagrantfile, and the deployed app directory on the VM. There will be a client and node created on the chef server associated with the development deployment. 

## cleanup

1. ```vagrant destroy```

Cleanup will delete and remove the VMs, delete the host shared directory, and delete the node and client on the chef server