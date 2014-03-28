require 'yaml'

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  ddb_config_path = File.expand_path(File.dirname(__FILE__)) + "/config.yml"
  ddb_config = YAML.load_file(ddb_config_path)

  config.vm.box       = 'precise64'
  config.vm.box_url   = 'http://files.vagrantup.com/precise42.box'
  config.vm.host_name = ddb_config["host_name"]

  config.vm.provider "virtualbox" do |v|
    v.memory = ddb_config["memory"]
    v.cpus = ddb_config["cpus"]
  end

  config.vm.provision :shell, :path => "bootstrap.sh"

  config.vm.synced_folder "src/", "/home/vagrant/src"

  ddb_config["provision_scripts"].each do |path|
    config.vm.provision :shell, :path => path
  end

  ddb_config["services"].each do |service, sconfig|
    config.vm.provision "docker" do |d|
      d.pull_images sconfig["image"]
      d.run service,
        image: sconfig["image"],
        args: sconfig["args"]
    end

    config.vm.network "forwarded_port", guest: sconfig["forwarded_ports"]["guest"], host: sconfig["forwarded_ports"]["guest"]
  end

end
