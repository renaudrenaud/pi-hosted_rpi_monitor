#!/bin/bash

# Update Portainer
# run this script as root
# sudo ./update_portainer.sh
# and be sure to be connected to the internet!!!

#Get the pid and the name of the running container
portainer_pid=`docker ps | grep portainer | awk '{print $1}'`
portainer_name=`docker ps | grep portainer | awk '{print $2}'`

# Stop the container
sudo docker stop $portainer_pid || error "Failed to stop portainer!"

# Remove the container
sudo docker rm $portainer_pid || error "Failed to remove portainer container!"

# Remove the image
sudo docker rmi $portainer_name || error "Failed to remove/untag images from the container!"

# Pull the latest image
# Please pay attention to the PORT NUMBER, use your own port number!
sudo docker run -d -p 9051:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest || error "Failed to execute newer version of Portainer!"

# Enjoy!!!
