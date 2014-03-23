# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box       = 'precise64'
  config.vm.box_url   = 'http://files.vagrantup.com/precise42.box'
  config.vm.host_name = 'docker-devbox'
  #config.vm.customize ["modifyvm", :id, "--memory", 4048]
  #config.vm.customize ["modifyvm", :id, "--cpus", '4']
  #config.vm.customize ["modifyvm", :id, "--ioapic", 'on']

  config.vm.network "forwarded_port", guest: 27017, host: 27017
  config.vm.network "forwarded_port", guest: 6379, host: 6379

  config.vm.provision :shell, :path => "bootstrap.sh"

  config.vm.provision "docker" do |d|
    d.pull_images "ehazlett/mongodb"
    d.pull_images "jasonblanchard/redis"

    d.run "mongodb", 
      image: "ehazlett/mongodb",
      args: "-p 27017:27017 -v /home/vagrant/mongodata:/tmp/mongo -e DATA_DIR=/tmp/mongo"

    d.run "redis",
      image: "jasonblanchard/redis",
      args: "-p 6379:6379"
  end
end
