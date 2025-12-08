FROM node:18-bullseye

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Install global npm packages
RUN npm install -g \
    supabase \
    typescript \
    ts-node

# Create non-root user
RUN useradd -m -s /bin/bash node

USER node
WORKDIR /workspace