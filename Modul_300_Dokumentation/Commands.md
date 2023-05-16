
# Vagrant
| Command                          | Effect                                                                           |
| -------------------------------- | -------------------------------------------------------------------------------- |
| vagrant init ubuntu/xenial64     | Creates a Vagrantfile with the default config for the ubuntu/xenial64 Box.       |
| vagrant up --provider virtualbox | Creates a VM with the Config specified in the Vagrant File in the same directory |
| vagrant ssh ${name}              | Open an SSH Shell to the specified VM                                            |
| vagrant destroy (-f)             | Destroys the VM specified in the Vagrant File in the same directory              |
| vagrant reload                   | Check the Vagrantfile for changed Configuration and reload the VM if so          |
| vagrant box list                 | List all downloaden boxes (docker image ls)                                      |
| vagrant box remove ${box_name}   | Delete specified box                                                             |
| vagrant global-status            | Show all running Vm's configured with Vagrant (Cached)                           |
| vagrant global-status --prune    | Updates the Cached entrys                                                        |


