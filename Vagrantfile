# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'centos65'
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.synced_folder "./samurai", "/vagrant", mount_options: ["dmode=777", "fmode=666"]
end
