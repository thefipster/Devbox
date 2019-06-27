#!/usr/bin/env bash

# System update
apt-get update
apt-get upgrade -y

# Install basic dependencies
apt-get install -y \
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
    libssl-dev \
    libffi-dev \
    gcc \
    zlib1g-dev \

# python
sudo apt-get install -y \
    python-dev \
    python3 \
    python3-pip

# sqlite
sudo apt-get install -y \
    sglite3 \
    libsglite3-dev

# ruby
apt-get -y install \
    ruby \
    ruby-dev

    # gems
    gem install hanami

# dotnet core 2.2
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb    
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get install -y \
    dotnet-sdk-2.2

# erlang / elixir
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt-get update
sudo apt-get install -y \
    esl-erlang \
    elixir

# nodejs / npm
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt install -y \
    nodejs

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | sudo apt-key add -

sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

apt-get update
apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io

sudo curl \
    -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

systemctl enable docker.service

# run portainer for docker management
docker volume create portainer_data
docker run -d --restart always -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

# ansible
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible