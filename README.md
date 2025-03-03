# MegaRAC Aster BMC Java iKVM Viewer

This Docker image allows you to run the MegaRAC Aster BMC Java iKVM Viewer in a container, without messing with Java Web Start (jnlp).

The iKVM viewer could be accessed via the Web UI or VNC, with the help of [baseimage-gui](https://github.com/jlesage/docker-baseimage-gui).

## Usage

### Configuration

#### Environment Variables

- `BMC_IP`: The IP address of the BMC.
- `BMC_USER`: The username to log in to the BMC.
- `BMC_PASS`: The password to log in to the BMC.

#### Ports
- `5800`: The port for the Web UI.
- `5900`: The port for the VNC server.


### Example

```bash
docker run --rm \
    -e BMC_IP=<BMC IP> \
    -e BMC_USER=<BMC Username> \
    -e BMC_PASS=<BMC Password> \
    -p 5800:5800 \
    -p 5900:5900 \
    -v ./iso:/iso \
    ghcr.io/nthu-lsalab/megarac-aster-ikvm:latest
```

The Web UI will be available at `http://localhost:5800/`, and the VNC server will be available at `localhost:5900`.

### Helper Script

A helper script `start.sh` is provided to simplify running the container.

```bash
./start.sh [BMC IP] [BMC Username] [BMC Password] --iso [ISO Folder] --web [Web Port] --vnc [VNC Port]`
```

- `--iso` will mount the specified folder to `/iso` in the container. Defaults to none (does not mount an ISO folder).
- `--web` defaults to `5800`
- `--vnc` defaults to none (does not expose the VNC port)
