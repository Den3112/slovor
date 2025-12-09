#!/usr/bin/env bash

# Docker cleanup script
# Removes unused containers, images, volumes to keep Docker tidy

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

HARD_MODE=false

if [ "$1" = "--hard" ]; then
    HARD_MODE=true
fi

echo ""
echo -e "${CYAN}╔═══════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BLUE}Docker Cleanup${NC}                            ${CYAN}║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════╝${NC}"
echo ""

if [ "$HARD_MODE" = true ]; then
    echo -e "${RED}⚠️  HARD MODE - This will remove EVERYTHING!${NC}"
    echo -e "${RED}   Including all images, volumes, and networks${NC}"
    echo ""
    echo -e "${YELLOW}This will:${NC}"
    echo -e "  - Stop all Lando projects"
    echo -e "  - Remove ALL Docker containers"
    echo -e "  - Remove ALL Docker images"
    echo -e "  - Remove ALL Docker volumes"
    echo -e "  - Remove ALL Docker networks"
    echo ""
    echo -e "${RED}You will need to rebuild everything with 'lando rebuild'${NC}"
    echo ""
    read -p "Are you ABSOLUTELY sure? Type 'yes' to continue: " -r
    echo
    if [[ ! $REPLY = "yes" ]]; then
        echo -e "${GREEN}Cancelled. Nothing was deleted.${NC}"
        exit 0
    fi
    
    echo -e "${YELLOW}Stopping all Lando projects...${NC}"
    lando poweroff 2>/dev/null || true
    
    echo -e "${YELLOW}Removing all containers...${NC}"
    docker stop $(docker ps -aq) 2>/dev/null || true
    docker rm $(docker ps -aq) 2>/dev/null || true
    
    echo -e "${YELLOW}Removing all images...${NC}"
    docker rmi -f $(docker images -aq) 2>/dev/null || true
    
    echo -e "${YELLOW}Removing all volumes...${NC}"
    docker volume rm $(docker volume ls -q) 2>/dev/null || true
    
    echo -e "${YELLOW}Removing all networks...${NC}"
    docker network prune -f 2>/dev/null || true
    
    echo -e "${YELLOW}Running system prune...${NC}"
    docker system prune -af --volumes 2>/dev/null || true
    
    echo ""
    echo -e "${GREEN}✓${NC} Hard cleanup complete!"
    echo -e "${CYAN}Run 'lando start' to rebuild your environment${NC}"
    echo ""
    exit 0
fi

# Normal cleanup mode
echo -e "${BLUE}Running safe cleanup...${NC}"
echo ""

echo -e "${YELLOW}[1/5]${NC} Removing old Lando proxy containers..."
if docker ps -a | grep -q "landoproxy"; then
    docker stop $(docker ps -a | grep "landoproxy" | awk '{print $1}') 2>/dev/null || true
    docker rm $(docker ps -a | grep "landoproxy" | awk '{print $1}') 2>/dev/null || true
    echo -e "  ${GREEN}✓${NC} Removed old proxy containers"
else
    echo -e "  ${GREEN}✓${NC} No old proxy containers found"
fi

echo ""
echo -e "${YELLOW}[2/5]${NC} Removing stopped containers..."
CONTAINERS=$(docker container prune -f 2>&1 | grep -o 'Total reclaimed space: [^']*' || echo "0B")
echo -e "  ${GREEN}✓${NC} $CONTAINERS"

echo ""
echo -e "${YELLOW}[3/5]${NC} Removing unused images..."
IMAGES=$(docker image prune -f 2>&1 | grep -o 'Total reclaimed space: [^']*' || echo "0B")
echo -e "  ${GREEN}✓${NC} $IMAGES"

echo ""
echo -e "${YELLOW}[4/5]${NC} Removing unused volumes..."
VOLUMES=$(docker volume prune -f 2>&1 | grep -o 'Total reclaimed space: [^']*' || echo "0B")
echo -e "  ${GREEN}✓${NC} $VOLUMES"

echo ""
echo -e "${YELLOW}[5/5]${NC} Removing unused networks..."
docker network prune -f >/dev/null 2>&1 || true
echo -e "  ${GREEN}✓${NC} Networks cleaned"

echo ""
echo -e "${CYAN}───────────────────────────────────────────────${NC}"
echo -e "${BLUE}Current Docker Status${NC}"
echo -e "${CYAN}───────────────────────────────────────────────${NC}"
echo ""

echo -e "${GREEN}Running Containers:${NC}"
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}" 2>/dev/null || echo "  None"

echo ""
echo -e "${GREEN}Disk Usage:${NC}"
docker system df 2>/dev/null || echo "  Unable to get disk usage"

echo ""
echo -e "${GREEN}✓${NC} Cleanup complete!"
echo ""
echo -e "${YELLOW}💡 Tips:${NC}"
echo -e "  - Run ${CYAN}lando cleanup${NC} weekly to keep Docker tidy"
echo -e "  - Use ${CYAN}lando cleanup:hard${NC} for nuclear cleanup (removes everything)"
echo -e "  - Check Docker Desktop settings: limit CPU to 2-4 cores, RAM to 4-6GB"
echo ""
