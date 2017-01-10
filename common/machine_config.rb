# -*- mode: ruby -*-
# vi: set ft=ruby :

class MachineConfig
    def initialize(name, sync, memory = 2048, cpus = 2)
        @name = name
        @sync = sync
        @memory = memory
        @cpus = cpus
    end
    attr_reader :name
    attr_reader :sync
    attr_reader :memory
    attr_reader :cpus
end
