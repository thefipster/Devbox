# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.box_version = "20190503.0.0"
  config.vm.hostname = "automatica-devbox"
  config.ssh.shell = "bash"


  # plugin needed: vagrant plugin install vagrant-disksize
  config.disksize.size = "20GB"

  config.vm.network :forwarded_port, guest: 9000, host: 9000  # portainer
  config.vm.network :forwarded_port, guest: 3000, host: 3000  # app1
  config.vm.network :forwarded_port, guest: 4000, host: 4000  # app2
  config.vm.network :forwarded_port, guest: 5000, host: 5000  # app3

  config.vm.provision :shell, path: "vagrant/provision.sh"
  config.vm.provision :shell, path: "vagrant/startup.sh", run: 'always'

  config.vm.synced_folder "../", "/git"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "8"
    vb.memory = "8192"
  end

  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false  
  end
end
