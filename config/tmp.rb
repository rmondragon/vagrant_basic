Here is my config.yaml:

---
vagrantfile-local:
    vm:
        box: puphpet/ubuntu1404-x64
        box_url: puphpet/ubuntu1404-x64
        hostname: ''
        memory: '512'
        cpus: '1'
        chosen_provider: virtualbox
        network:
            private_network: 192.168.56.101
            forwarded_port:
                X18nynqfDa7K:
                    host: '7694'
                    guest: '22'
        post_up_message: ''
        provider:
            virtualbox:
                modifyvm:
                    natdnshostresolver1: on
            vmware:
                numvcpus: 1
            parallels:
                cpus: 1
        provision:
            puppet:
                manifests_path: puphpet/puppet
                manifest_file: site.pp
                module_path: puphpet/puppet/modules
                options:
                    - '--verbose'
                    - '--hiera_config /vagrant/puphpet/puppet/hiera.yaml'
                    - '--parser future'
        synced_folder:
            NAJL2Fgx9uQg:
                source: ./
                target: /vagrant
                sync_type: default
                rsync:
                    args:
                        - '--verbose'
                        - '--archive'
                        - '-z'
                    exclude:
                        - .vagrant/
                    auto: 'false'
        usable_port_range:
            start: 10200
            stop: 10500
    ssh:
        host: null
        port: null
        private_key_path: null
        username: vagrant
        guest_port: null
        keep_alive: true
        forward_agent: false
        forward_x11: false
        shell: 'bash -l'
    vagrant:
        host: detect
server:
    install: '1'
    packages:
        - libyaml-dev
        - screen
firewall:
    install: '1'
    rules:
        fDjV7sUgS49P:
            port: '80'
            priority: '100'
            proto: tcp
            action: accept
apache:
    install: '0'
    settings:
        user: www-data
        group: www-data
        default_vhost: true
        manage_user: false
        manage_group: false
        sendfile: 0
    modules: {  }
    vhosts: {  }
    mod_pagespeed: 0
nginx:
    install: '1'
    settings:
        default_vhost: 1
        proxy_buffer_size: 128k
        proxy_buffers: '4 256k'
    vhosts:
        Vnrs1zM3JTTR:
            server_name: boxmanager.dev
            server_aliases:
                - www.boxmanager.dev
            www_root: /vagrant/projects/boxmanager/src/boxmanager/public
            listen_port: '80'
            location: \.php$
            index_files:
                - index.html
                - index.htm
                - index.php
            envvars:
                - 'APP_ENV dev'
            engine: php
            ssl_cert: ''
            ssl_key: ''
php:
    install: '1'
    version: '55'
    composer: '1'
    composer_home: ''
    modules:
        php:
            - cli
            - common
            - curl
            - gd
            - imagick
            - intl
            - mbstring
            - mcrypt
            - mysql
            - mysqlnd
            - sqlite
            - tidy
            - xmlrpc
            - xsl
        pear: {  }
        pecl:
            - yaml
            - pecl_http
    ini:
        display_errors: On
        error_reporting: '-1'
        session.save_path: /var/lib/php/session
        extension: yaml.so
    timezone: Europe/Amsterdam
    mod_php: 0
hhvm:
    install: '0'
    nightly: 0
    composer: '1'
    composer_home: ''
    settings:
        host: 127.0.0.1
        port: '9000'
    ini:
        display_errors: On
        error_reporting: '-1'
    timezone: null
xdebug:
    install: '0'
    settings:
        xdebug.default_enable: '1'
        xdebug.remote_autostart: '0'
        xdebug.remote_connect_back: '1'
        xdebug.remote_enable: '1'
        xdebug.remote_handler: dbgp
        xdebug.remote_port: '9000'
xhprof:
    install: '0'
drush:
    install: '0'
    version: 6.3.0
ruby:
    install: '1'
    versions:
        zUW9V7FPDb2B:
            version: ''
nodejs:
    install: '0'
    npm_packages: {  }
python:
    install: '1'
    packages: {  }
    versions:
        U7bdbFXc4cG5:
            version: ''
mysql:
    install: '1'
    root_password: vagrant
    adminer: '1'
    databases:
        mMt7zahrxILo:
            grant:
                - ALL
            name: manager
            host: localhost
            user: manager
            password: manager
            sql_file: ''
postgresql:
    install: '0'
    settings:
        root_password: '123'
        user_group: postgres
        encoding: UTF8
        version: '9.3'
    databases: {  }
    adminer: 0
mariadb:
    install: '0'
    root_password: '123'
    adminer: 0
    databases: {  }
    version: '10.0'
sqlite:
    install: '0'
    adminer: 0
    databases: {  }
mongodb:
    install: '0'
    settings:
        auth: 1
        port: '27017'
    databases: {  }
redis:
    install: '0'
    settings:
        conf_port: '6379'
mailcatcher:
    install: '1'
    settings:
        smtp_ip: 0.0.0.0
        smtp_port: 1025
        http_ip: 0.0.0.0
        http_port: '1080'
        mailcatcher_path: /usr/local/rvm/wrappers/default
        from_email_method: inline
beanstalkd:
    install: '1'
    settings:
        listenaddress: 0.0.0.0
        listenport: '13000'
        maxjobsize: '65535'
        maxconnections: '1024'
        binlogdir: /var/lib/beanstalkd/binlog
        binlogfsync: null
        binlogsize: '10485760'
    beanstalk_console: '1'
    binlogdir: /var/lib/beanstalkd/binlog
rabbitmq:
    install: '0'
    settings:
        port: '5672'
elastic_search:
    install: '0'
    settings:
        java_install: true
        autoupgrade: true
And my Vagrantfile:

require 'yaml'

dir = File.dirname(File.expand_path(__FILE__))

configValues = YAML.load_file("#{dir}/puphpet/config.yaml")
data         = configValues['vagrantfile-local']

Vagrant.require_version '>= 1.6.0'

Vagrant.configure('2') do |config|
  config.vm.box     = "#{data['vm']['box']}"
  config.vm.box_url = "#{data['vm']['box_url']}"

  if data['vm']['hostname'].to_s.strip.length != 0
    config.vm.hostname = "#{data['vm']['hostname']}"
  end

  if data['vm']['network']['private_network'].to_s != ''
    config.vm.network 'private_network', ip: "#{data['vm']['network']['private_network']}"
  end

  data['vm']['network']['forwarded_port'].each do |i, port|
    if port['guest'] != '' && port['host'] != ''
      config.vm.network :forwarded_port, guest: port['guest'].to_i, host: port['host'].to_i
    end
  end

  if !data['vm']['post_up_message'].nil?
    config.vm.post_up_message = "#{data['vm']['post_up_message']}"
  end

  if Vagrant.has_plugin?('vagrant-hostmanager')
    hosts = Array.new()

    if !configValues['apache']['install'].nil? &&
        configValues['apache']['install'].to_i == 1 &&
        configValues['apache']['vhosts'].is_a?(Hash)
      configValues['apache']['vhosts'].each do |i, vhost|
        hosts.push(vhost['servername'])

        if vhost['serveraliases'].is_a?(Array)
          vhost['serveraliases'].each do |vhost_alias|
            hosts.push(vhost_alias)
          end
        end
      end
    elsif !configValues['nginx']['install'].nil? &&
           configValues['nginx']['install'].to_i == 1 &&
           configValues['nginx']['vhosts'].is_a?(Hash)
      configValues['nginx']['vhosts'].each do |i, vhost|
        hosts.push(vhost['server_name'])

        if vhost['server_aliases'].is_a?(Array)
          vhost['server_aliases'].each do |x, vhost_alias|
            hosts.push(vhost_alias)
          end
        end
      end
    end

    if hosts.any?
      contents = File.open("#{dir}/puphpet/shell/ascii-art/hostmanager-notice.txt", 'r'){ |file| file.read }
      puts "\n\033[32m#{contents}\033[0m\n"

      if config.vm.hostname.to_s.strip.length == 0
        config.vm.hostname = 'puphpet-dev-machine'
      end

      config.hostmanager.enabled           = true
      config.hostmanager.manage_host       = true
      config.hostmanager.ignore_private_ip = false
      config.hostmanager.include_offline   = false
      config.hostmanager.aliases           = hosts
    end
  end

  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  end

  data['vm']['synced_folder'].each do |i, folder|
    if folder['source'] != '' && folder['target'] != ''
      if folder['sync_type'] == 'nfs'
        config.vm.synced_folder "#{folder['source']}", "#{folder['target']}", id: "#{i}", type: 'nfs'
      elsif folder['sync_type'] == 'smb'
        config.vm.synced_folder "#{folder['source']}", "#{folder['target']}", id: "#{i}", type: 'smb'
      elsif folder['sync_type'] == 'rsync'
        rsync_args = !folder['rsync']['args'].nil? ? folder['rsync']['args'] : ['--verbose', '--archive', '-z']
        rsync_auto = !folder['rsync']['auto'].nil? ? folder['rsync']['auto'] : true
        rsync_exclude = !folder['rsync']['exclude'].nil? ? folder['rsync']['exclude'] : ['.vagrant/']

        config.vm.synced_folder "#{folder['source']}", "#{folder['target']}", id: "#{i}",
          rsync__args: rsync_args, rsync__exclude: rsync_exclude, rsync__auto: rsync_auto, type: 'rsync'
      else
        config.vm.synced_folder "#{folder['source']}", "#{folder['target']}", id: "#{i}",
          group: 'www-data', owner: 'www-data', mount_options: ['dmode=775', 'fmode=764']
      end
    end
  end

  config.vm.usable_port_range = (data['vm']['usable_port_range']['start'].to_i..data['vm']['usable_port_range']['stop'].to_i)

  if data['vm']['chosen_provider'].empty? || data['vm']['chosen_provider'] == 'virtualbox'
    ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

    config.vm.provider :virtualbox do |virtualbox|
      data['vm']['provider']['virtualbox']['modifyvm'].each do |key, value|
        if key == 'memory'
          next
        end
        if key == 'cpus'
          next
        end

        if key == 'natdnshostresolver1'
          value = value ? 'on' : 'off'
        end

        virtualbox.customize ['modifyvm', :id, "--#{key}", "#{value}"]
      end

      virtualbox.customize ['modifyvm', :id, '--memory', "#{data['vm']['memory']}"]
      virtualbox.customize ['modifyvm', :id, '--cpus', "#{data['vm']['cpus']}"]

      if data['vm']['hostname'].to_s.strip.length != 0
        virtualbox.customize ['modifyvm', :id, '--name', config.vm.hostname]
      end
    end
  end

  if data['vm']['chosen_provider'] == 'vmware_fusion' || data['vm']['chosen_provider'] == 'vmware_workstation'
    ENV['VAGRANT_DEFAULT_PROVIDER'] = (data['vm']['chosen_provider'] == 'vmware_fusion') ? 'vmware_fusion' : 'vmware_workstation'

    config.vm.provider 'vmware_fusion' do |v|
      data['vm']['provider']['vmware'].each do |key, value|
        if key == 'memsize'
          next
        end
        if key == 'cpus'
          next
        end

        v.vmx["#{key}"] = "#{value}"
      end

      v.vmx['memsize']  = "#{data['vm']['memory']}"
      v.vmx['numvcpus'] = "#{data['vm']['cpus']}"

      if data['vm']['hostname'].to_s.strip.length != 0
        v.vmx['displayName'] = config.vm.hostname
      end
    end
  end

  if data['vm']['chosen_provider'] == 'parallels'
    ENV['VAGRANT_DEFAULT_PROVIDER'] = 'parallels'

    config.vm.provider 'parallels' do |v|
      data['vm']['provider']['parallels'].each do |key, value|
        if key == 'memsize'
          next
        end
        if key == 'cpus'
          next
        end

        v.customize ['set', :id, "--#{key}", "#{value}"]
      end

      v.memory = "#{data['vm']['memory']}"
      v.cpus   = "#{data['vm']['cpus']}"

      if data['vm']['hostname'].to_s.strip.length != 0
        v.name = config.vm.hostname
      end
    end
  end

  ssh_username = !data['ssh']['username'].nil? ? data['ssh']['username'] : 'vagrant'

  config.vm.provision 'shell' do |s|
    s.path = 'puphpet/shell/initial-setup.sh'
    s.args = '/vagrant/puphpet'
  end
  config.vm.provision 'shell' do |kg|
    kg.path = 'puphpet/shell/ssh-keygen.sh'
    kg.args = "#{ssh_username}"
  end
  config.vm.provision :shell, :path => 'puphpet/shell/install-ruby.sh'
  config.vm.provision :shell, :path => 'puphpet/shell/install-puppet.sh'

  config.vm.provision :puppet do |puppet|
    puppet.facter = {
      'ssh_username'     => "#{ssh_username}",
      'provisioner_type' => ENV['VAGRANT_DEFAULT_PROVIDER'],
      'vm_target_key'    => 'vagrantfile-local',
    }
    puppet.manifests_path = "#{data['vm']['provision']['puppet']['manifests_path']}"
    puppet.manifest_file  = "#{data['vm']['provision']['puppet']['manifest_file']}"
    puppet.module_path    = "#{data['vm']['provision']['puppet']['module_path']}"

    if !data['vm']['provision']['puppet']['options'].empty?
      puppet.options = data['vm']['provision']['puppet']['options']
    end
  end

  config.vm.provision :shell do |s|
    s.path = 'puphpet/shell/execute-files.sh'
    s.args = ['exec-once', 'exec-always']
  end
  config.vm.provision :shell, run: 'always' do |s|
    s.path = 'puphpet/shell/execute-files.sh'
    s.args = ['startup-once', 'startup-always']
  end
  config.vm.provision :shell, :path => 'puphpet/shell/important-notices.sh'

  if File.file?("#{dir}/puphpet/files/dot/ssh/id_rsa")
    config.ssh.private_key_path = [
      "#{dir}/puphpet/files/dot/ssh/id_rsa",
      "#{dir}/puphpet/files/dot/ssh/insecure_private_key"
    ]
  end

  if !data['ssh']['host'].nil?
    config.ssh.host = "#{data['ssh']['host']}"
  end
  if !data['ssh']['port'].nil?
    config.ssh.port = "#{data['ssh']['port']}"
  end
  if !data['ssh']['username'].nil?
    config.ssh.username = "#{data['ssh']['username']}"
  end
  if !data['ssh']['guest_port'].nil?
    config.ssh.guest_port = data['ssh']['guest_port']
  end
  if !data['ssh']['shell'].nil?
    config.ssh.shell = "#{data['ssh']['shell']}"
  end
  if !data['ssh']['keep_alive'].nil?
    config.ssh.keep_alive = data['ssh']['keep_alive']
  end
  if !data['ssh']['forward_agent'].nil?
    config.ssh.forward_agent = data['ssh']['forward_agent']
  end
  if !data['ssh']['forward_x11'].nil?
    config.ssh.forward_x11 = data['ssh']['forward_x11']
  end
  if !data['vagrant']['host'].nil?
    config.vagrant.host = data['vagrant']['host'].gsub(':', '').intern
  end
end



##################################


Vagrant.require_plugin('vagrant-hostmanager')

domain = 'mydomain.com'

# Define the cluster
nodes = [
  { :hostname => 'node1', :ip => '10.125.0.11', :box => 'ubuntu1204-chef'},
  { :hostname => 'node2', :ip => '10.125.0.12', :box => 'ubuntu1204-chef'},
  { :hostname => 'node3', :ip => '10.125.0.13', :box => 'ubuntu1204-chef'}
]

Vagrant.configure("2") do |config|

  nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      # configure the box, hostname and networking
      node_config.vm.box = node[:box]
      node_config.vm.hostname = node[:hostname] + '.' + domain
      node_config.vm.network :private_network, ip: node[:ip]

	  # configure hostmanager
      node_config.hostmanager.enabled = true
      node_config.hostmanager.manage_host = true
      node_config.hostmanager.ignore_private_ip = false
      node_config.hostmanager.include_offline = true
      node_config.hostmanager.aliases = node[:hostname]

      # use the Chef provisioner to install RabbitMQ
      node_config.vm.provision :chef_solo do |chef|
       chef.add_recipe "rabbitmq"
       chef.add_recipe "rabbitmq::mgmt_console"
      end
    end
  end
end
