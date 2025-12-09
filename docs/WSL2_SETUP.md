# WSL2 + Docker Setup Guide

**Complete guide** for Slovor development in WSL2

---

## Prerequisites

- Windows 10 version 2004+ or Windows 11
- Admin access
- ~10GB free disk space
- Virtualization enabled in BIOS

---

## Quick Start

### Option 1: Automated Setup (Recommended)

```bash
# In WSL2 Ubuntu
cd slovor_dev
bash scripts/wsl2-setup.sh
```

Done! Everything installs automatically.

### Option 2: Manual Setup

Follow steps below.

---

## Step 1: Install WSL2

**PowerShell as Administrator:**

```powershell
wsl --install
```

Restart computer.

**Verify:**

```powershell
wsl --list --verbose
```

Should show Ubuntu with VERSION 2.

---

## Step 2: Install Docker

**In WSL2 Ubuntu:**

```bash
# Update
sudo apt update && sudo apt upgrade -y

# Install Docker
sudo apt install -y docker.io

# Start Docker
sudo service docker start

# Add user to docker group
sudo usermod -aG docker $USER
newgrp docker

# Test
docker run hello-world
```

---

## Step 3: Install Lando

```bash
cd ~
wget https://files.lando.dev/installer/lando-x64-stable.deb
sudo dpkg -i lando-x64-stable.deb
sudo apt install -f -y
rm lando-x64-stable.deb
lando version
```

---

## Step 4: Optimize WSL2

**Create `C:\Users\YourName\.wslconfig`:**

```ini
[wsl2]
memory=4GB
processors=4
swap=2GB
pageReporting=false
localhostForwarding=true
```

**Apply:**

```powershell
wsl --shutdown
# Wait 8 seconds
wsl
```

---

## Step 5: Start Slovor

```bash
git clone https://github.com/Den3112/slovor.git slovor_dev
cd slovor_dev
lando start
lando dev
```

---

## Troubleshooting

### Docker won't start

```bash
sudo service docker start
```

### Permission denied

```bash
sudo usermod -aG docker $USER
newgrp docker
```

### Lando hangs

```bash
lando poweroff
sudo service docker restart
lando start
```

### Port already in use

```bash
sudo lsof -i:3000
sudo kill -9 <PID>
```

---

## Performance Tips

1. **Use WSL2 filesystem** (not `/mnt/c/`)
2. **Increase .wslconfig limits**
3. **Exclude from Windows Defender**
4. **Enable Docker Desktop WSL2 integration**

---

## Health Check

```bash
lando doctor
```

---

## Quick Reference

```bash
# WSL
wsl --shutdown              # Stop WSL
wsl --list --verbose        # List distros

# Docker
sudo service docker start   # Start Docker
docker ps                   # List containers

# Lando
lando start                 # Start project
lando doctor                # Health check
lando dev                   # Dev server
lando logs                  # View logs
```

---

**Questions?** Run `lando doctor` or check GitHub Issues.