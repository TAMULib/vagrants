# vagrants

TAMU project development vagrants provisioned by development chef server

## dependencies

1. install [virtual box](https://www.virtualbox.org/wiki/Downloads)
2. install [chef client](https://downloads.chef.io/chef)
3. install [vagrant](https://www.vagrantup.com/downloads.html)
4. install [vagrant-triggers plugin](https://github.com/emyl/vagrant-triggers)

## setup

- generate ssh key and register with github account
- retrieve client.pem file registered with chef server, should be placed in CHEF_HOME
- export environment variable, VAGRANT_ID_RSA, to locate id_rsa key used for the git command
    e.g. ```export ID_RSA_PATH="/Users/aggiejack/.ssh/id_rsa"```
- export environment variable, CHEF_HOME, to locate chef server client pem file
    e.g. ```export CHEF_HOME="/etc/chef"```

## configure

Roles are defined from the attributes json files.

## deploy

1. ```cd [project]```
2. ```vagrant up```
