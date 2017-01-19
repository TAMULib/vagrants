# vagrants

TAMU project development chef_client provisioning vagrants.

## dependencies

1. [virtual box](https://www.virtualbox.org/wiki/Downloads)
2. [chef client](https://downloads.chef.io/chef)
3. [vagrant](https://www.vagrantup.com/downloads.html)

## vagrant plugins

- ```vagrant plugin install chef```
- ```vagrant plugin install vagrant-berkshelf```
- ```vagrant plugin install vagrant-omnibus```
- ```vagrant plugin install vagrant-vbguest```
- ```vagrant plugin install vagrant-triggers```

## setup

- generate ssh key and register with github account
- retrieve client.pem file registered with chef server
- export environment variable, SSH_ID_RSA, to locate ssh id_rsa key used for the git command
  - ```export SSH_ID_RSA="/Users/aggiejack/.ssh/id_rsa"```
- export environment variable, CHEF_HOME, to locate chef client installation
  - ```export CHEF_HOME="/etc/chef"```
- export environment variable, CHEF_CLIENT_PEM, to locate chef client pem file
  - ```export CHEF_CLIENT_PEM="/Users/aggiejack/.chef/aggiejack.pem"```
- update vagrant box for centos 7
  - ```vagrant box update --box bento/centos-6.7"```

## configure

Roles are defined from the attributes json files. Provisioning is defined in provision json files.

## gotcha

Virtual box will not bind to host ports < 1024. Therefor the UIs are hosted on port 8080.

  e.g. ```http://localhost:8080/[project]```

Optional, configure Apache proxy using a VirtualHost ProxyPass to port 8080.

1. Install the HTTP proxy module ```a2enmod proxy_http```
2. Make sure Apache is listening on port 80
3. Add the following VirtualHost to Apache configuration, httpd.conf, or add to a sites-avaliable
    <br />
    ```xml
      <VirtualHost *:80>
        ProxyPreserveHost On
        ProxyRequests Off
        ProxyPass / http://localhost:8080/
        ProxyPassReverse / http://localhost:8080/
      </VirtualHost>
    ```

4. Restart Apache

## deploy

1. ```cd [project]```
2. ```vagrant up```

Deploy will create, configure, provision, and start VMs with the associating project. There will be a synced directory, src directory relative to the Vagrantfile, and /data/[deploy] directory on the VM. There will be a client and node created on the chef server associated with the development deployment.

## cleanup

1. ```vagrant destroy```

Cleanup will delete and remove the VMs, delete the host shared directory, and delete the node and client on the chef server

## Projects

Here are some default host ports for various projects.

### [MyLibrary](https://github.com/TAMULib/vagrants/tree/master/mylibrary)

| Service | Port |
| ------- | ---: |
| spring  | 9000 |
| angular | 8080 |

- - - -

### [Direcory](https://github.com/TAMULib/vagrants/tree/master/directory)

| Service | Port |
| ------- | ---: |
| spring  | 9001 |
| angular | 8081 |

- - - -

### [Subject Librarian](https://github.com/TAMULib/vagrants/tree/master/subject-librarian)

| Service | Port |
| ------- | ---: |
| spring  | 9002 |
| angular | 8082 |

- - - -

### [Magpie](https://github.com/TAMULib/vagrants/tree/master/metadatatool)

| Service | Port |
| ------- | ---: |
| spring  | 9003 |
| angular | 8083 |

- - - -

### [Pelican](https://github.com/TAMULib/vagrants/tree/master/pelican)

| Service | Port |
| ------- | ---: |
| spring  | 9004 |
