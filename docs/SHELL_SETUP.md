# Shell Configuration Guide

**Auto-navigation and shortcuts for Slovor development**

---

## Quick Setup

```bash
cd ~/slovor_dev
bash scripts/setup-shell.sh
```

Reopen terminal → automatically in `slovor_dev`!

---

## What It Does

### Auto-Navigation

Terminal always opens in `~/slovor_dev` instead of `~`

### Aliases Added

**Project navigation:**
```bash
slovor      # cd ~/slovor_dev
```

**Development:**
```bash
sdev        # cd ~/slovor_dev && lando dev
sstart      # cd ~/slovor_dev && lando start
sstop       # cd ~/slovor_dev && lando stop
sdoctor     # cd ~/slovor_dev && lando doctor
shealth     # cd ~/slovor_dev && lando health
slogs       # cd ~/slovor_dev && lando logs
```

**Lando shortcuts:**
```bash
l           # lando
ld          # lando dev
ls          # lando start (conflicts with 'ls' - use 'sstart' instead)
lst         # lando stop
lr          # lando restart
lb          # lando rebuild -y
li          # lando info
```

**Git shortcuts:**
```bash
sgit        # cd ~/slovor_dev && git
spull       # cd ~/slovor_dev && git pull origin main
spush       # cd ~/slovor_dev && git push origin main
sstatus     # cd ~/slovor_dev && git status
```

---

## Manual Setup

### For Bash

Edit `~/.bashrc`:

```bash
nano ~/.bashrc
```

Add at the end:

```bash
# Slovor Project
export SLOVOR_DIR="$HOME/slovor_dev"

# Auto-navigate
if [ "$PWD" = "$HOME" ] && [ -d "$SLOVOR_DIR" ]; then
    cd "$SLOVOR_DIR"
    echo "📂 Switched to Slovor project"
fi

# Aliases
alias slovor="cd $SLOVOR_DIR"
alias sdev="cd $SLOVOR_DIR && lando dev"
alias sstart="cd $SLOVOR_DIR && lando start"
```

Save: `Ctrl+O`, `Enter`, `Ctrl+X`

Reload:
```bash
source ~/.bashrc
```

### For Zsh

Same as above but edit `~/.zshrc` instead.

---

## Windows Terminal Setup

### Set WSL Starting Directory

**Option 1: Windows Terminal Settings (GUI)**

1. Open Windows Terminal
2. Settings (`Ctrl+,`)
3. Profiles → Ubuntu (or your WSL distro)
4. Starting directory: `\\wsl$\Ubuntu\home\ubuntu2404\slovor_dev`
5. Save

**Option 2: settings.json (Direct)**

Edit `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_*\LocalState\settings.json`:

```json
{
    "profiles": {
        "list": [
            {
                "guid": "{your-ubuntu-guid}",
                "name": "Ubuntu",
                "source": "Windows.Terminal.Wsl",
                "startingDirectory": "//wsl$/Ubuntu/home/ubuntu2404/slovor_dev"
            }
        ]
    }
}
```

---

## VS Code Terminal Setup

**For Windsurf/VS Code:**

Settings (`Ctrl+,`) → Search "terminal.integrated.cwd":

```json
{
    "terminal.integrated.cwd": "${workspaceFolder}"
}
```

Or in `.vscode/settings.json`:

```json
{
    "terminal.integrated.cwd": "${workspaceFolder}",
    "terminal.integrated.defaultProfile.linux": "bash",
    "terminal.integrated.profiles.linux": {
        "bash": {
            "path": "/bin/bash",
            "args": ["-l"],
            "icon": "terminal-bash"
        }
    }
}
```

---

## Disable Auto-Navigation

### Temporarily

```bash
export SLOVOR_AUTO_CD=0
```

### Permanently

Edit `~/.bashrc` and remove/comment out the auto-cd section:

```bash
# if [ "$PWD" = "$HOME" ] && [ -d "$SLOVOR_DIR" ]; then
#     cd "$SLOVOR_DIR"
#     echo "📂 Switched to Slovor project"
# fi
```

Reload: `source ~/.bashrc`

---

## Troubleshooting

### Aliases not working

```bash
# Reload shell config
source ~/.bashrc

# Or restart terminal
```

### Auto-cd not working

```bash
# Check if directory exists
ls -la ~/slovor_dev

# Check .bashrc loaded
echo $SLOVOR_DIR

# Manually source
source ~/.bashrc
```

### Conflicts with existing aliases

Edit `~/.bashrc` and rename conflicting aliases.

---

## Advanced: Custom Prompt

Show current project in prompt:

```bash
# Add to ~/.bashrc
if [ -d "$SLOVOR_DIR" ] && [[ $PWD == $SLOVOR_DIR* ]]; then
    PS1="[Slovor] $PS1"
fi
```

---

## Quick Reference

```bash
# Setup
bash scripts/setup-shell.sh

# Reload config
source ~/.bashrc

# Test
cd ~         # Go home
# Should auto-cd to slovor_dev

# Use aliases
sdev         # Start dev server
sdoctor      # Run diagnostics
```

---

**Questions?** Run setup script or check `.bashrc`