# -*- mode: ruby -*-
# vi: set ft=ruby :

class MachineConfig
    def initialize(name, sync, box, memory, cpus)
        @name = name
        @box = box
        @sync = sync
        @memory = memory
        @cpus = cpus
    end
    attr_reader :name
    attr_reader :box
    attr_reader :sync
    attr_reader :memory
    attr_reader :cpus
end

class SyncedFolder
    def initialize(name, src, dest, mount_options)
        @name = name
        @src = src
        @dest = dest
        @mount_options = mount_options
    end
    attr_reader :name
    attr_reader :src
    attr_reader :dest
    attr_reader :mount_options
end

# method to define the chef provisioning
def define(config, name)
    # set omnibus chef version to match chef server
    config.omnibus.chef_version = '11.18.12'

    # disable berkshelf
    config.berkshelf.enabled = false

    # define to provisioning
    config.vm.define name do |app|
        provision = JSON.parse(File.read("provision/#{name}.json"))
        attributes = JSON.parse(File.read("attributes/#{name}.json"))
        provision['ports'].each { |port| port(app, port['guest'], port['host']) }
        synced_folder = SyncedFolder.new(name, "src/#{name}", "/data/#{name}", provision['mount_options'])
        machine = MachineConfig.new("#{$base_name}-#{name}", synced_folder, provision['box'], provision['memory'], provision['cpus'])
        provision(app, machine, provision['runlist'], attributes)
    end
end

# method to add port forwarding
def port(app, guest, host, protocol = 'tcp')
    app.vm.network 'forwarded_port', guest: guest, host: host, protocol: protocol
end

# method to perform detailed chef provisioning
def provision(app, machine, runlist, attributes)
    # configure settings
    setup(app, machine)

    # sync directory
    if attributes['angular']
    # currently breaks npm install!!!
    else
      sync(app, machine)
    end

    # copy ssh key for git clone
    app.vm.provision 'file', source: (ENV['SSH_ID_RSA']).to_s,
                             destination: '/home/vagrant/.ssh/git_id_rsa'

    # perform chef provision
    app.vm.provision :chef_client do |chef|
        chef.node_name = machine.name
        chef.version = '11.18.12'

        chef.log_level = Chef::Config[:log_level]
        chef.verbose_logging = Chef::Config[:verbose_logging]
        chef.enable_reporting = Chef::Config[:enable_reporting]
        chef.chef_server_url = Chef::Config[:chef_server_url]
        chef.validation_key_path = Chef::Config[:validation_key]
        chef.validation_client_name = Chef::Config[:validation_client_name]

        # install location of the chef client
        chef.provisioning_path = (ENV['CHEF_HOME']).to_s
        chef.client_key_path = (ENV['CHEF_CLIENT_PEM']).to_s

        chef.delete_node = true
        chef.delete_client = true
        chef.run_list = runlist
        chef.json = attributes
    end
end

# method to setup virtual machine
def setup(app, machine)
    app.vm.box = machine.box
    app.vm.hostname = machine.name
    app.vm.provider :virtualbox do |vb|
        vb.customize ['setextradata', :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/#{machine.sync.name}", '1']
        vb.customize ['modifyvm', :id, '--cpuexecutioncap', '50']
        vb.name = machine.name
        vb.memory = machine.memory
        vb.cpus = machine.cpus
    end
end

# method to create synced folder and bind to source folder
def sync(app, machine)
    # create synced folder for development
    app.vm.synced_folder machine.sync.src.to_s, machine.sync.dest.to_s,
                         id: machine.sync.name, create: true,
                         mount_options: machine.sync.mount_options
end

# method to clean up files on the host after the guest is destroyed
def cleanup(app)
    # add trigger for when destroy is called
    app.trigger.after :destroy do
        run 'rm -rf src/'
    end
end
