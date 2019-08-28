#!/usr/bin/env bash

# workaround for interactive prompt during install
export DEBIAN_FRONTEND=noninteractive

# system update
apt-get update -y -qq
sudo -E apt-get upgrade -y -qq

# basic dependencies
apt-get install -y -qq \
    git \
    make \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    build-essential \
    python-dev \
    libssl-dev \
    libffi-dev \
    gcc \
    zlib1g-dev \

# python
apt-get install -y \
    python3 \
    python3-pip

# sqlite
apt-get install -y \
    sglite3 \
    libsglite3-dev

# ruby
apt-get -y install \
    ruby \
    ruby-dev

# ruby gems
gem install hanami

# dotnet core 2.2
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb    
add-apt-repository universe
apt-get update
apt-get install -y \
    dotnet-sdk-2.2

# erlang / elixir
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
dpkg -i erlang-solutions_1.0_all.deb
apt-get update
apt-get install -y \
    esl-erlang \
    elixir

# nodejs / npm
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
apt install -y \
    nodejs

# ansible
apt-add-repository --yes --update ppa:ansible/ansible
apt install -y \
    ansible

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | sudo apt-key add -

add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

apt-get update
apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io

# docker-compose
curl \
    -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

systemctl enable docker.service

# docker container
docker volume create portainer_data
docker run -d --restart always -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer