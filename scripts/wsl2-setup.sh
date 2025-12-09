#!/usr/bin/env bash

# Automated WSL2 + Docker + Lando setup for Slovor

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo "═══════════════════════════════════════════════════"
echo "🐧 WSL2 + Docker + Lando Setup for Slovor"
echo "═══════════════════════════════════════════════════"
echo ""

echo "📦 Step 1: Update system"
sudo apt update
sudo apt upgrade -y

echo ""
echo "🐳 Step 2: Install Docker"
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    
    sudo apt remove docker docker-engine docker.io containerd runc 2>/dev/null || true
    
    sudo apt install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    echo -e "${GREEN}✅ Docker installed${NC}"
else
    echo -e "${GREEN}✅ Docker already installed${NC}"
fi

echo ""
echo "⚙️  Step 3: Configure Docker"

if ! sudo service docker status &> /dev/null; then
    sudo service docker start
    echo -e "${GREEN}✅ Docker started${NC}"
fi

if ! groups $USER | grep -q docker; then
    sudo usermod -aG docker $USER
    echo -e "${YELLOW}⚠️  User added to docker group${NC}"
    echo "   Run: newgrp docker"
else
    echo -e "${GREEN}✅ User in docker group${NC}"
fi

DOCKER_CONFIG="/etc/docker/daemon.json"
if [ ! -f "$DOCKER_CONFIG" ]; then
    sudo mkdir -p /etc/docker
    sudo tee /etc/docker/daemon.json > /dev/null <<EOF
{
  "dns": ["8.8.8.8", "8.8.4.4"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "storage-driver": "overlay2"
}
EOF
    sudo service docker restart
    echo -e "${GREEN}✅ Docker configured${NC}"
fi

echo ""
echo "🚀 Step 4: Install Lando"
if ! command -v lando &> /dev/null; then
    cd ~
    wget -q https://files.lando.dev/installer/lando-x64-stable.deb
    sudo dpkg -i lando-x64-stable.deb
    sudo apt install -f -y
    rm lando-x64-stable.deb
    echo -e "${GREEN}✅ Lando installed${NC}"
else
    echo -e "${GREEN}✅ Lando already installed${NC}"
fi

echo ""
echo "🔧 Step 5: Install dev tools"
sudo apt install -y \
    git \
    build-essential \
    curl \
    wget \
    unzip \
    vim \
    jq \
    htop

echo ""
echo "📝 Step 6: Create .wslconfig"
WSLCONFIG="/mnt/c/Users/$USER/.wslconfig"
if [ ! -f "$WSLCONFIG" ]; then
    cat > "$WSLCONFIG" <<EOF
# WSL2 Configuration for Slovor
[wsl2]
memory=4GB
processors=4
swap=2GB
pageReporting=false
localhostForwarding=true
EOF
    echo -e "${YELLOW}⚠️  .wslconfig created - restart WSL: wsl --shutdown${NC}"
fi

echo ""
echo "✅ Step 7: Verify"
docker run --rm hello-world &> /dev/null && echo -e "${GREEN}✅ Docker working${NC}"
lando version &> /dev/null && echo -e "${GREEN}✅ Lando working${NC}"

echo ""
echo "═══════════════════════════════════════════════════"
echo -e "${GREEN}🎉 Setup Complete!${NC}"
echo "═══════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo "   1. If added to docker group: newgrp docker"
echo "   2. Clone: git clone https://github.com/Den3112/slovor.git slovor_dev"
echo "   3. Navigate: cd slovor_dev"
echo "   4. Start: lando start"
echo ""