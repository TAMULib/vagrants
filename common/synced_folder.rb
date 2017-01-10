# -*- mode: ruby -*-
# vi: set ft=ruby :

class SyncedFolder
    def initialize(name, mount_options, owner = '', group = '')
        @name = name
        @mount_options = mount_options
        @owner = owner
        @group = group
    end
    attr_reader :name
    attr_reader :mount_options
    attr_reader :owner
    attr_reader :group
end
