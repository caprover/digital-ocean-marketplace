#!/bin/bash

# From: https://github.com/digitalocean/droplet-1-clicks/tree/master/common/scripts

# DOCKER
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

cat >/etc/apt/sources.list.d/docker.list <<EOM
deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -c -s) stable
EOM

apt-get -y update
apt-get -y install docker-ce

systemctl enable docker
systemctl start docker

# DOCKER COMPOSE
#!/bin/sh

mkdir -p ~/.docker/cli-plugins/
if [ -z "${docker_compose_version}" ]; then
    docker_compose_version=$(curl -sSL "https://api.github.com/repos/docker/compose/releases/latest" | jq -r '.tag_name')
fi
curl -SL https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose

# GRUB OPTS
sed -e 's|GRUB_CMDLINE_LINUX="|GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1|g' \
    -i /etc/default/grub

update-grub

# DOCKER DNS
sed -e 's|#DOCKER_OPTS|DOCKER_OPTS|g' \
    -i /etc/default/docker

# Application Tag
################################
## PART: Write the application tag
##
## vi: syntax=sh expandtab ts=4

build_date=$(date +%Y-%m-%d)
distro="$(lsb_release -s -i)"
distro_release="$(lsb_release -s -r)"
distro_codename="$(lsb_release -s -c)"
distro_arch="$(uname -m)"

cat >>/var/lib/digitalocean/application.info <<EOM
application_name="${application_name}"
build_date="${build_date}"
distro="${distro}"
distro_release="${distro_release}"
distro_codename="${distro_codename}"
distro_arch="${distro_arch}"
application_version="${application_version}"
EOM

#UFW

ufw limit ssh
ufw allow 80,443,3000,996,7946,4789,2377/tcp
ufw allow 7946,4789,2377/udp
ufw --force enable

## cleanup do-agent: https://github.com/digitalocean/marketplace-partners/issues/166
apt-get purge droplet-agent* -y || echo "No DO Agent Found"

### CapRover
docker pull caprover/caprover:VAR_CAPROVER_VERSION
