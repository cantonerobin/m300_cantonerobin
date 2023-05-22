# Hypervisor: Proxmox

I use Proxmox as hypervisor to virtualise a Debian VM, on this Debain VM Vigrant is installed.

# Vagrant Host: Debian

Hostname: m300-vagrant
Betriebssystemversion: "Debian GNU/Linux 11 (bullseye)"
CPU-Modell: Common KVM processor
Anzahl CPU-Cores: 2
Gesamter Arbeitsspeicher: 3.8Gi
Genutzter Arbeitsspeicher: 79Mi
Gesamtgröße des Dateisystems:  6.2G
Belegter Speicher auf dem Dateisystem:  1.9G
Freier Speicher auf dem Dateisystem:  4.0G


# Host Setup
Update System
`apt update && apt upgrade`

Install gnupg 
`sudo apt install gnupg && sudo apt install gnupg1`

# Setup Vagrant
Ressource: https://developer.hashicorp.com/vagrant/downloads?product_intent=vagrant

Download public GPG Key from Hashicorp

``` bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

Install Vagrant
```bash
 sudo apt update && sudo apt install vagrant
```

Install aws Vigrant Plugin
``` 
vagrant plugin install vagrant-aws
```

