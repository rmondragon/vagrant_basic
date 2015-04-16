# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.post_up_message = "

                                                   BB
                     BBBB                        BB  BBBB
                 BBBB    BB                    BB  BB    BBBB
               BB      BB            BBBBBBBBBB    BBBB      BB
             BBBB    BB      BB    BB            BB    BB    BBBB
             BB    BB        BB  BB              BBBB    BB    BB
           BBBB    BB      BB  BB                    BB  BB    BBBB
           BB      BB    BB                        BB    BB      BB
           BB        BB  BB          BBBB        BB    BB        BB
           BB        BB  BB    BBBBBB    BBBBBB    BB  BB        BB
           BB        BBBBBBBBBB                BBBBBBBBBB        BB
           BB      BBBB      BB                BB      BBBB    BBBB
             BB        BB      BB  BB    BB  BB      BB        BB
             BB    BBBBBB        BB        BB        BBBBBB    BB
               BB    BB  BBBB    BB        BB    BBBB  BB    BB
               BBBBBB    BB  BBBBBB        BBBBBB  BB    BBBBBB
                 BBBB  BB  BB  BB  BB    BB  BB  BB  BB  BBBB
                   BB  BB  BB  BB    BBBB    BB  BB  BB  BB
                   BB  BBBBBBBBBB            BBBBBBBBBB  BB
                 BB  BB          BB        BB          BB  BB
             BBBBBBBBBB              BBBB              BBBBBBBBBB
           BB          BB  BBBB  BBBB    BBBB  BBBB  BB          BB
         BB              BB    BB            BB    BB              BB
         BB                        BB    BB                        BB
         BB                      BB        BB                      BB
         BB            BB                            BB            BB
           BB        BB  BB          BBBB          BB  BB        BB
             BB      BB    BBBBBBBBBB    BBBBBBBBBB    BB      BB
               BB    BB    BB  BB            BB  BB    BB    BB
                 BB    BB    BB                BB    BB    BB
                 BB    BB      BBBBBB    BBBBBB      BB    BB
                   BB    BB  BB      BBBB      BB  BB    BB
                   BB    BBBB  BB            BB  BBBB    BB
                     BB    BBBB  BB        BB  BBBB    BB
                     BB    BBBB  BB        BB  BBBB    BB
                   BB      BBBBBBBBBBBBBBBBBBBBBBBB      BB
                   BB                                    BB
                   BB                BBBB                BB
                     BBBB        BBBB    BBBB        BBBB
                         BBBBBBBB            BBBBBBBB
    "
  config.vm.hostname = "devops#{rand(01..99)}.vagrant.vm"
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/trusty64"
  config.vm.define "devops" do |devops|
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 2048]
    vb.name = "devops"
  end

  config.vm.provision :shell, :path => "bootstrap.sh"
  config.vm.synced_folder "../localhost", "/var/www", type:"nfs"

  config.vm.network "private_network", ip: "192.168.56.101"
  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network :forwarded_port, host: 3306, guest: 3306
  config.vm.usable_port_range = 10200..10500

end
