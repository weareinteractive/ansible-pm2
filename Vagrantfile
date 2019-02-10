# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vbguest.no_remote = true
  config.vbguest.auto_update = false

  config.vm.define 'xenial' do |instance|
    instance.vm.box = 'ubuntu/xenial64'

    config.vm.provision "shell", inline: "
      apt-get update && \
      apt-get install -y gnupg python curl && \
      curl -sL http://deb.nodesource.com/setup_11.x | bash - && \
      apt-get install -y nodejs
    "

    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "tests/main.yml"
      ansible.verbose = 'vv'
      ansible.become = true
    end
  end

  config.vm.define 'centos7' do |instance|
    instance.vm.box = 'geerlingguy/centos7'

    config.vm.provision "shell", inline: "
      curl -sL https://rpm.nodesource.com/setup_11.x | bash - && \
      yum install -y nodejs
    "

    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "tests/main.yml"
      ansible.verbose = 'vv'
      ansible.become = true
    end
  end
end
