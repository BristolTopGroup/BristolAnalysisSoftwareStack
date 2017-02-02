# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "cernvm/3-prod"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  # forward ports
  # config.vm.network :forwarded_port, guest: 8060, host: 8060

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.

  # config.vm.synced_folder "/hdfs", "/hdfs"
  config.vm.synced_folder ".", "/vagrant",  nfs: false
  config.vm.synced_folder "~/.globus", "/home/vagrant/.globus",  nfs: false
  # if you have an existing vagrant box after this was added in, please run `vagrant provision`
  # after `vagrant up`.
  config.vm.provision "file", source: "~/.gitconfig", destination: "/home/vagrant/.gitconfig"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.gui = false
  end
end
