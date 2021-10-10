#!/bin/bash


# From: https://github.com/digitalocean/droplet-1-clicks/tree/master/common/scripts

# DOCKER
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

cat > /etc/apt/sources.list.d/docker.list <<EOM
deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -c -s) stable
EOM

apt-get -y update
apt-get -y install docker-ce

systemctl enable docker
systemctl start docker


# DOCKER COMPOSE
sudo curl -L "https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;
chmod +x /usr/local/bin/docker-compose;


# GRUB OPTS
sed -e 's|GRUB_CMDLINE_LINUX="|GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1|g' \
    -i /etc/default/grub

update-grub


# DOCKER DNS
sed -e 's|#DOCKER_OPTS|DOCKER_OPTS|g' \
    -i /etc/default/docker



#UFW

ufw limit ssh
ufw allow 80,443,3000,996,7946,4789,2377/tcp; ufw allow 7946,4789,2377/udp;
ufw --force enable



### CapRover
docker pull caprover/caprover:VAR_CAPROVER_VERSION
