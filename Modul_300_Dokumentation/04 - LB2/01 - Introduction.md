I want to present a real use case. We have the following initial situation. A developer is working on a customer website, the current development status should be visible to the customer at any time for demonstration purposes. For this purpose, it is necessary to provide the current status of the website automatically.

As Overview you can see here the Architecture
![Alt text](<Overview.jpg>)

The GitHub repository used for this automation can be found at:
https://github.com/cantonerobin/m300_CI-CD .

# Used Technoligies
## Git
The developer works with Git and pushes his work to GitHub.

## GitHub
In GitHub we will store our Code and also run the CI/CD job.

## DockerHub
On DockerHub we will store the DockerImage in our own Registry. From here we can pull the Image for later steps.

## Vagrant
We use vagrant to automaticly deploy an ubuntu VM with docker installed.

## Docker
With docker, a containerized environment is made available.


## Nginx
Nginx is used as a web server.

## Bash Script
For the automated deployment of the docker container we use a simple bash script.

