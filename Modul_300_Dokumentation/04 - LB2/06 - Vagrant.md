## Vagrant File
With Vagrant we deploy theVM which hosts our docker containers. 
You find the VagrantFIle here: https://github.com/cantonerobin/m300_CI-CD/blob/main/vagrant/Vagrantfile

``` 
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.define "dockerhost" do |docker|
    docker.vm.box = "ubuntu/xenial64"
    docker.vm.provider "virtualbox" do |vb|
      vb.memory = "512"  
    end
    docker.vm.hostname = "docker01"
    docker.vm.network "private_network", ip: "192.168.55.100"

    # Sync parent directory to VM
    config.vm.synced_folder "../", "/opt"

    # Install Docker in the VM
    docker.vm.provision "shell", inline: <<-SHELL
      apt update && apt upgrade -y
      apt install -y apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common
      sudo install -m 0755 -d /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
      chmod a+r /etc/apt/keyrings/docker.gpg
      echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null
      apt-get update
      apt-get -y install docker-ce docker-ce-cli containerd.io # docker-buildx-plugin docker-compose-plugin
      docker -v
      docker network create docker-network
      
      # Setup Cronjob to run every minute
      echo "* * * * * /opt/script/update_container.bash" | crontab -
      # Starte den Cron-Daemon neu
      service cron restart

      docker network create my-network

      docker run -d \
        --name web \
        --restart unless-stopped \
        --expose 80 \
        --network my-network \
        cantonerobin/modul300_ci-cd:latest

      docker run -d \
        --name reverse-proxy \
        --restart unless-stopped \
        -p 80:80 \
        -v /opt/nginx.conf:/etc/nginx/nginx.conf:ro \
        --network my-network \
        nginx:latest
    SHELL
  end
end
```


## Bash Script
With the sync Folder method we sync a bash script to the VM
You find the bash script here: https://github.com/cantonerobin/m300_CI-CD/blob/main/script/update_cantainer.bash

``` bash
#!/bin/bash
# Name des Docker Hub Repositorys und des Images
repository="cantonerobin"
image="modul300_ci-cd"


# Aktuelle Version des lokalen Images abrufen
current_version=$(docker inspect --format='{{.Id}}' $image)

# Aktuelle Version des Images auf Docker Hub abrufen
latest_version=$(curl -s "https://hub.docker.com/v2/repositories/$repository/tags/?page_size=1" | jq -r '.results[0].name')

# Prüfen, ob ein neues Image vorhanden ist
if [ "$current_version" != "$latest_version" ]; then
  echo "Ein neues Image wurde gefunden. Aktualisiere das Image..."

  # Container stoppen
  docker stop $image

  # Neues Image herunterladen
  docker pull $repository:$latest_version

  # Container mit dem neuen Image starten
      docker run -d \
        --name web \
        --restart unless-stopped \
        --expose 80 \
        --network my-network \
        cantonerobin/modul300_ci-cd:latest

  echo "Das Image wurde aktualisiert und der Container wurde neu gestartet."
else
  echo "Es ist keine Aktualisierung erforderlich. Das Image ist bereits auf dem neuesten Stand."
fi
```

