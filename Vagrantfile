# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  servers=[

    {
      :hostname => "server-01",
      :box => "ubuntu/focal64",
      :ip => "192.168.56.101",
      :ssh_port => "2222"
    },

    {
      :hostname => "server-01-backup",
      :box => "ubuntu/focal64",
      :ip => "192.168.56.102",
      :ssh_port => "2223"
    }   

  ]

  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.vm.box = machine[:box]
      node.vm.hostname = machine[:hostname]
      node.vm.network :private_network, ip: machine[:ip]
      node.vm.network "forwarded_port", guest: 22, host: machine[:ssh_port], id: "ssh"
      
      node.vm.provider :virtualbox do |vb|
        vb.memory = 1024
        vb.cpus = 1
      end
    config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub"
    config.vm.provision "file", source: "~/.ssh/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
    config.vm.provision :shell, :inline => "cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys", run: "always"

    end
  end
end