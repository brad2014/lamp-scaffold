#
# Basic development environment.
# Provisions a virtual linux box running a LAMP stack
#
VAGRANTFILE_API_VERSION = "2"
hostname='dev.example.com' # or pick your own name
ip_addr = '192.168.10.10'  # make sure you are not otherwise using this subnet

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #
  # Minimal centos7 box from puppetlabs.  About 562 Mb.
  # If you have a local copy, you can point to it with box_url. By default,
  # vagrant will pull it from from atlas.hashicorp.com.
  #
  config.vm.box = 'puppetlabs/centos-7.2-64-nocm'

  # config.vm.box_url = 'https://atlas.hashicorp.com/puppetlabs/boxes/centos-7.2-64-nocm/versions/1.0.1/providers/virtualbox.box'
  # config.vm.box_download_checksum_type = 'sha256'
  # config.vm.box_download_checksum = '9d59765f42faae377ae52b614615746d3f53d4917134e06ded2a1cf8ff6d270d'

  config.vm.hostname = hostname
  config.vm.network :private_network, ip: ip_addr, nic_type: 'virtio'
  config.vm.provider :virtualbox do |v|
    v.name = hostname
    v.memory = 2048 # Kb
  end

  # install puppet, if necessary, and update box packages
  config.vm.provision :shell, inline: '/vagrant/scripts/init.sh'

  config.vm.provision :puppet do |p|
    p.environment_path = 'environments'
    p.environment = 'vagrant'
    p.working_directory = '/tmp/vagrant-puppet'
    p.hiera_config_path = 'environments/vagrant/hiera.yaml'
    # p.options = '--debug'
  end
end
