#!/bin/bash
echo "$(basename $0) start!"
sudo docker run -d --name jenkins -p 8080:8080 -p 50000:50000 --restart=always -v ~/OneDrive/jenkins:/var/jenkins_home -v /var/run/docker.sock/:/bar/run/docker.sock -v ~/Dropbox/Program:/var/Program jenkins-master
echo "$(basename $0) done!"
exit 0

