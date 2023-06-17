# Hypervisor: Proxmox

I use Proxmox as hypervisor to virtualise a Debian and also Windows Server 2019 VM's. I do this so I can work from anywhere on the same Host by connecting to my private Network with a VPN connection.
# Debian VM

``` root@pve:~# pvesh get /nodes/pve/qemu/600/config
┌─────────┬────────────────────────────────────────────────────────┐
│ key     │ value                                                  │
╞═════════╪════════════════════════════════════════════════════════╡
│ agent   │ 1                                                      │
├─────────┼────────────────────────────────────────────────────────┤
│ boot    │ order=scsi0;net0                                       │
├─────────┼────────────────────────────────────────────────────────┤
│ cores   │ 2                                                      │
├─────────┼────────────────────────────────────────────────────────┤
│ digest  │ a5204c9c0bf7682edf05b4ddeb309c8fe5869d36               │
├─────────┼────────────────────────────────────────────────────────┤
│ memory  │ 4096                                                   │
├─────────┼────────────────────────────────────────────────────────┤
│ name    │ M300-Vagrant                                           │
├─────────┼────────────────────────────────────────────────────────┤
│ net0    │ virtio=CA:18:3B:C3:3C:81,bridge=vmbr0,firewall=1,tag=6 │
├─────────┼────────────────────────────────────────────────────────┤
│ numa    │ 0                                                      │
├─────────┼────────────────────────────────────────────────────────┤
│ ostype  │ l26                                                    │
├─────────┼────────────────────────────────────────────────────────┤
│ scsi0   │ data10:vm-600-disk-0,iothread=1,size=32G               │
├─────────┼────────────────────────────────────────────────────────┤
│ scsihw  │ virtio-scsi-single                                     │
├─────────┼────────────────────────────────────────────────────────┤
│ smbios1 │ uuid=13b5de6a-6c62-4d49-aa3f-8657e4eeb043              │
├─────────┼────────────────────────────────────────────────────────┤
│ sockets │ 1                                                      │
├─────────┼────────────────────────────────────────────────────────┤
│ tags    │ internal                                               │
├─────────┼────────────────────────────────────────────────────────┤
│ vmgenid │ ccaf6152-59a5-4fa8-a8f6-e6eaa981dcc5                   │
└─────────┴────────────────────────────────────────────────────────┘

```

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


# Windows Environment

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
