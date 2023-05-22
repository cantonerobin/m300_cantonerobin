# Boxes
Predifines OS Image Templates which can be downloaded from Hashicorp Repositiory. Similar to docker images
Ressources: https://app.vagrantup.com/boxes/search

# Vagrentfile
The entire configuration is done in the Vagrantfile, which is located in the corresponding directory. The syntax is based on the Ruby programming language:

``` bash
Vagrant.configure("2") do |config|
        config.vm.define :apache do |web|
            web.vm.box = "bento/ubuntu-16.04"
            web.vm.provision :shell, path: "config_web.sh"
            web.vm.hostname = "srv-web"
            web.vm.network :forwarded_port, guest: 80, host: 4567
            web.vm.network "public_network", bridge: "en0: WLAN (AirPort)"
    end
```

# Provisioning
Provisioning in Vagrant means giving instructions to another program. In most cases, to a shell, such as Bash. The following lines install the Apache web server.

``` bash
config.vm.provision :shell, inline: <<-SHELL 
        sudo apt-get update
        sudo apt-get -y install apache2
     SHELL
```

# Provider
The provider specification in the Vagrantfile defines which Dynamic Infrastructure Platform is used (e.g. VirtualBox).
``` bash
config.vm.provider "virtualbox" do |vb|
        vb.memory = "512"  
    end
```
