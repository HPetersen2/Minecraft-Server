# Minecraft Docker Server

## Description

This repository provides a fully containerized **Minecraft server** for multiplayer gaming. The server runs inside Docker, allowing easy setup, isolation, and portability.

---

## Table of Contents
- [Description](#description)
- [Quickstart](#quickstart)
- [Usage](#usage)

**Key contents:**
- Dockerfile for building the Minecraft server image
- `.env.template` for environment variable configuration
- Python test script to verify server connectivity

**Purpose:** Provide a ready-to-use, configurable Minecraft server environment that can be run locally or deployed to a server without manual installation of Java or Minecraft server files.

---

## Quickstart

### Prerequisites
- [Docker](https://docs.docker.com/get-docker/) installed and running on your system
- [Python 3](https://www.python.org/downloads/) (optional, for server status testing)

### Quick Setup

1. **Download the Minecraft Server JAR**

   Download the server JAR from the official Minecraft website:  
   [https://www.minecraft.net/de-de/download/server](https://www.minecraft.net/de-de/download/server)

   For V-Server deployments, download directly using curl:
   ```bash
   curl -o minecraft_server.1.21.10.jar https://piston-data.mojang.com/v1/objects/95495a7f485eedd84ce928cef5e223b757d2f764/server.jar
   ```

   > [!IMPORTANT]
   > The file must be named exactly `server.jar` (not `Server.jar` or any other name). 
   > After downloading, rename the file to `server.jar` and place it in the repository root. 
   > The downloaded file typically has a version-specific name like `minecraft_server.1.21.10.jar`, which you need to change to `server.> jar`.

2. **Configure environment variables**
   ```bash
   cp .env.template .env
   ```
   
   Edit the `.env` file with your preferred settings:
   - `PORT`: Host port for the server (default: 8888)
   - `EULA`: Must be TRUE to accept Minecraft EULA
   - `XMX`: Maximum memory allocation (e.g., 2G, 4G)
   - `XMS`: Initial memory allocation (e.g., 1G, 2G)
   - `ENABLE_QUERY`: Enable query protocol (TRUE/FALSE)
   - `QUERY_PORT`: Query port (default: 25565)
   - `HOST`: Host address (default: 127.0.0.1)

3. **Build and run the Docker container**
   ```bash
   docker build -t mc-server -f Dockerfile .
   docker run -p 8888:25565 --env-file .env mc-server
   ```

   The server is now running and accessible on the configured port.

---

## Usage

This section explains configuration options and customization in detail.

### Environment Variables

The `.env` file controls all server configuration. Modify these variables to achieve different results:

**PORT** (default: 8888)
- Controls which port the server is exposed on your host machine
- Example: Change to `30000` to run on port 30000
- Update the docker run command accordingly: `-p 30000:25565`

**XMX and XMS** (default: XMX=2G, XMS=1G)
- `XMX`: Maximum RAM allocated to the server
- `XMS`: Initial RAM allocation
- Example: Set `XMX=4G` and `XMS=2G` for better performance with more players
- Higher values improve performance but require more system resources

**ENABLE_QUERY and QUERY_PORT** (default: TRUE, 25565)
- `ENABLE_QUERY`: Enables server status queries
- `QUERY_PORT`: Port used for status queries
- Set `ENABLE_QUERY=FALSE` to disable query protocol
- Change `QUERY_PORT` if the default conflicts with other services

**HOST** (default: 127.0.0.1)
- Binding address for the server
- Use `127.0.0.1` for local testing
- Use `0.0.0.0` to allow external connections
- Use a specific IP to bind to a particular network interface

**EULA** (must be TRUE)
- Accepts the Minecraft End User License Agreement
- Server will not start if set to FALSE

### Building and Running

After modifying `.env` or Dockerfile, rebuild the image:
```bash
docker build -t mc-server -f Dockerfile .
```

**For local testing:**
```bash
docker run -p <YOUR_PORT>:25565 --env-file .env mc-server
```

**For V-Server deployment (recommended):**

Use Docker Compose to ensure the server runs continuously in the background:
```bash
docker compose up -d --build
```

This starts the container in detached mode, keeping it running even after you disconnect from the server.

### Persisting World Data

To save your world data and survive container restarts, mount a volume:
```bash
docker run -p 8888:25565 --env-file .env -v $(pwd)/world:/minecraft/world mcserver
```

This maps the container's world directory to your host system, ensuring all world data is preserved.

### Server Properties

Advanced server settings can be modified in `server.properties`:
- `difficulty`: peaceful, easy, normal, hard
- `gamemode`: survival, creative, adventure, spectator
- `pvp`: true/false
- `view-distance`: Number of chunks visible (default: 10)
- `max-players`: Maximum concurrent players

After modifying `server.properties`, rebuild the container for changes to take effect.

### Optional: Testing Server Status

The `test.py` script verifies server connectivity:

Set up a Python virtual environment to run `test.py`, which checks if the server is online using the `HOST`, `PORT`, and `QUERY_PORT` values from `.env`:

```bash
# Create and activate virtual environment
python -m venv venv

# On Windows
venv\Scripts\activate

# On Linux/macOS
source venv/bin/activate

# Install dependencies and test
pip install -r requirements.txt
python test.py
```

The script automatically reads `HOST`, `PORT`, and `QUERY_PORT` from your `.env` file. Ensure your virtual environment is activated and dependencies are installed before running.