# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vbguest.no_remote = true
  config.vbguest.auto_update = false

  config.vm.define 'xenial' do |instance|
    instance.vm.box = 'ubuntu/xenial64'

    config.vm.provision "shell", inline: "sudo apt-get update && apt-get install -y python"
    config.vm.provision "shell", inline: "curl -sL https://deb.nodesource.com/setup_11.x | sudo bash -"

    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "tests/main.yml"
      ansible.verbose = 'vv'
      ansible.become = true
    end
  end

  config.vm.define 'centos7' do |instance|
    instance.vm.box = 'geerlingguy/centos7'

    config.vm.provision "shell", inline: "curl -sL https://rpm.nodesource.com/setup_11.x | sudo bash -"

    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "tests/main.yml"
      ansible.verbose = 'vv'
      ansible.become = true
    end
  end
end
