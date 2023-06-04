# Hypervisor: Proxmox

I use Proxmox as hypervisor to virtualise a Debian and also Windows Server 2019 VM's. I do this so I can work from anywhere on the same Host by connecting to my private Network with a VPN connection.
# Debian VM

VM angaben

This Vm is used for the AWS Config Files. 

## Git Setup

Install git
``` bash
apt install git
```

Create SSH Key
``` bash
ssh-keygen
```

copy ssh key
``` bash
cat /root/.ssh/id_rsa.pub
```

![[screenshot_ssh_key.png]]

Insert into Github Account
![[screenshot_github_ssh_key.png]]

## Vagrant Setup
Ressource: https://developer.hashicorp.com/vagrant/downloads?product_intent=vagrant

Update System
``` bash
apt update && apt upgrade
```

Install gnupg 
``` bash
sudo apt install gnupg && sudo apt install gnupg1
```

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

## Packer Setup
Ressource: https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli
> [!note] 
> The official install Documentation is deprecated, the command "apt-add-key" is no longer supported. In favor of the more secure binary "gpg".

Add the HashiCorp [GPG key](https://apt.releases.hashicorp.com/gpg "HashiCorp GPG key").
``` bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --recv-keys
```

Add the official HashiCorp Linux repository.
``` bash
sudo apt-get install software-properties-common
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

Update and install.
``` bash
sudo apt-get update && sudo apt-get install packer
```

## Docker Setup
Ressource: https://docs.docker.com/engine/install/debian/


# Windows Environment (for VirtualBox)

For this I use a Windows 19 Server VM which is also virtualized on Proxmox.

## VirtualBox
I have installed Vortualbox Version XXX
![[screenshot_Virtualbox.png]]

## Coding
For coding I use Visual Studio Code directly on the Windows Machine or with the SSH Remote Plugin for the Debian VM.
![[screenshot_VSCode.png]]

## Documentation
For Documentation is use Obsidian, this is an advanced Markdown Editor, which supports a number ob Community Plugins. I use this tool also for my Private Knowledge Base.
![[screenshot_Obsidian.png]]

## Vagrant
Download .msi File from here: https://developer.hashicorp.com/vagrant/downloads
Install with the msi File.
Reboot the system
