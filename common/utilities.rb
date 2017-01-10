# -*- mode: ruby -*-
# vi: set ft=ruby :

# convinience method to add port forwarding
def port(app, guest, host, protocol = 'tcp')
    app.vm.network 'forwarded_port', guest: guest, host: host, protocol: protocol
end

# method to perform detailed chef provisioning
def provision(app, machine, runlist, attrubutes)
    # configure settings
    setup(app, machine)

    # create synced folder for development
    app.vm.synced_folder "src/#{machine.sync.name}", "/data/#{machine.sync.name}",
                         id: machine.sync.name, create: true,
                         mount_options: machine.sync.mount_options,
                         owner: machine.sync.owner,
                         group: machine.sync.group

    # copy ssh key for git clone
    app.vm.provision 'file', source: (ENV['VAGRANT_ID_RSA']).to_s,
                             destination: '/home/vagrant/.ssh/git_id_rsa'

    # perform chef provision
    app.vm.provision :chef_client do |chef|
        chef.node_name = machine.name
        chef.version = $chef_version

        chef.log_level = Chef::Config[:log_level]
        chef.verbose_logging = Chef::Config[:verbose_logging]
        chef.enable_reporting = Chef::Config[:enable_reporting]
        chef.chef_server_url = Chef::Config[:chef_server_url]
        chef.validation_key_path = Chef::Config[:validation_key]
        chef.validation_client_name = Chef::Config[:validation_client_name]

        # install location of the chef client
        chef.provisioning_path = '/etc/chef'
        chef.client_key_path = '/etc/chef/client.pem'

        chef.delete_node = true
        chef.delete_client = true
        chef.run_list = runlist
        chef.json = attrubutes
    end
end

# method to setup virtual machine
def setup(app, machine)
    app.vm.box = 'centos/6'
    app.vm.hostname = machine.name
    app.vm.provider :virtualbox do |vb|
        vb.customize ['modifyvm', :id, '--cpuexecutioncap', '50']
        vb.name = machine.name
        vb.memory = machine.memory
        vb.cpus = machine.cpus
    end
end
