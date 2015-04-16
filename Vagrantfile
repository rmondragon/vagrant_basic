# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!

# Config variables
DIR = File.dirname(File.expand_path(__FILE__))
VAGRANTFILE_API_VERSION = "2"
WEB_SERVER_IP = "192.168.56.101"
DOMAIN = "dev.com"

VIRTUAL_MACHINES = {
  :devops => {
    :ip             => WEB_SERVER_IP,                 ## Private network
    :hostname       => "devops.#{DOMAIN}",            ## devops#{rand(01..99)}.vagrant.vm
    :hostaliases    => ["test.#{DOMAIN}", "ui-bproc.#{DOMAIN}" ,"delivery.#{DOMAIN}"],
  }
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/trusty64"

  config.vm.define "devops" do |devops|
  end

  config.vm.hostname = VIRTUAL_MACHINES[:devops][:hostname]
  config.hostmanager.enabled           = true
  config.hostmanager.manage_host       = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline   = false
  config.hostmanager.aliases           = VIRTUAL_MACHINES[:devops][:hostaliases]

  config.vm.network :private_network, ip: VIRTUAL_MACHINES[:devops][:ip]
  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "forwarded_port", guest: 3306, host: 3306
  config.vm.usable_port_range = 10200..10500

  config.vm.provision :shell, :path => "bootstrap-short.sh"
  config.vm.synced_folder "../rv2", "/var/www", type:"nfs"
  config.vm.synced_folder '/vagrant', '.', :id => 'vagrant-root', :disabled => true

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 2048, "--natdnshostresolver1", "on"]
    vb.name = "devops"
  end

  post_up_message = File.open("#{DIR}/config/post_up_message", 'r'){ |file| file.read }
  config.vm.post_up_message = "#{post_up_message}"

end
