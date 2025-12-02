# Minecraft Docker Server

## Table of Contents
- [Description](#description)
- [Quickstart](#quickstart)
- [Usage](#usage)

---

## Description

This repository provides a fully containerized **Minecraft server** that can be used for multiplayer gaming.  
The server runs inside Docker, allowing easy setup, isolation, and portability.

**Key contents include:**
- Dockerfile for building the Minecraft server image
- `.env.template` for environment variable configuration
- Python scripts and utilities for testing and automation
- Instructions for running the server both quickly and with custom configurations

The main purpose of this repository is to provide a **ready-to-use, configurable Minecraft server** environment that can be run locally or deployed to a server without manual installation of Java or Minecraft server files.

---

## Quickstart

### Prerequisites
- [Docker](https://docs.docker.com/get-docker/) installed on your system
- [Python 3](https://www.python.org/downloads/) (for optional scripts/testing)

### Quick Setup

1. **Copy the environment template**
```bash
cp .env.template .env
```

2. **Fill out the .env file**  
   Update the necessary environment variables (e.g., server name, port, memory allocation).

3. **Build the Docker image**
```bash
docker build -t <image-name> -f Dockerfile .
```

4. **Run the Docker container**  
   Ignore any warnings during this step; environment variables will be loaded from `.env`.
```bash
docker run -p <PORT>:25565 --env-file .env <image-name>
```

The Minecraft server should now be running and accessible on the specified port.

5. **Optional: Set up a Python virtual environment for testing**
```bash
# Create virtual environment
python -m venv <env-name>

# Activate environment
# On Windows
<env-name>\Scripts\activate

# On Linux/macOS (Bash)
source <env-name>/bin/activate

# Install dependencies
pip install -r requirements.txt

# Test setup
python test.py
```

---

## Usage

This section explains how to configure, customize, and run the server in detail.

### Environment Configuration

The `.env` file controls the main server configuration. Key variables include:

- `SERVER_NAME`: The display name of your Minecraft server
- `SERVER_PORT`: Port to expose the server on your host machine
- `MAX_PLAYERS`: Maximum number of players allowed
- `MOTD`: Message of the day displayed in the server list
- `MEMORY`: Memory allocation for the server (e.g., 2G, 4G)

**To modify these values**, simply edit the `.env` file before running the container. 

Example configuration:
```env
SERVER_NAME=MyMinecraftServer
SERVER_PORT=25565
MAX_PLAYERS=20
MOTD=Welcome to my server!
MEMORY=2G
```

**How to achieve different results:**
- Change `SERVER_NAME` to customize the server name shown in the multiplayer list
- Adjust `MAX_PLAYERS` to allow more or fewer concurrent players
- Modify `MEMORY` to allocate more RAM (e.g., change from `2G` to `4G` for better performance)
- Update `MOTD` to display a custom welcome message

### Building and Running

You can rebuild the Docker image after changing `.env` or Dockerfile settings:
```bash
docker build -t <image-name> -f Dockerfile .
docker run -p <PORT>:25565 --env-file .env <image-name>
```

**To modify the port mapping**, change `<PORT>` in the command. For example, to use port 30000:
```bash
docker run -p 30000:25565 --env-file .env <image-name>
```

**If you want to persist world data**, mount a volume to the container:
```bash
docker run -p <PORT>:25565 --env-file .env -v $(pwd)/world:/minecraft/world <image-name>
```

This ensures your world data is saved on your host system and survives container restarts.

### Python Scripts & Testing

For testing or automation, you can use the included Python scripts:
```bash
python test.py
```

Prerequisites:
- Ensure the virtual environment is activated
- Dependencies are installed via `pip install -r requirements.txt`
- These scripts help verify server connectivity and configuration

**To modify testing behavior**, edit `test.py` to change connection parameters or add custom tests.

### Customization

**Plugins/Mods:**
- Place custom plugins in the `plugins/` directory
- Place mods in the `mods/` directory
- Rebuild the image after adding plugins or mods to include them in the container

**Backups:**
- Configure your own backup path or schedule using the `backups/` folder
- Modify backup scripts to change backup frequency or retention

**Server Options:**
- Advanced server options can be modified inside `server.properties`
- Edit properties like `difficulty`, `gamemode`, `pvp`, or `view-distance` to customize gameplay
- Rebuild the container after modifying `server.properties` for changes to take effect