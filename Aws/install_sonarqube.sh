sudo yum update -y
sudo yum upgrade -y
sudo dnf install java-17-amazon-corretto-devel -y
sudo yum install git -y
sudo yum install nodejs npm -y
sudo yum install docker -y
sudo usermod -aG docker ec2-user
sudo newgrp docker
sudo systemctl daemon-reload
sudo systemctl start docker
sudo systemctl enable docker
sudo docker pull sonarqube:9.9-community
sudo docker run -d --name sonarqube -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000 sonarqube:9.9-community