
# Setup Host
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

