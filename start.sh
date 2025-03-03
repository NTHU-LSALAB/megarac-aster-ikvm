#!/bin/bash

if [ $# -lt 3 ]; then
    echo "Usage: $0 [BMC IP] [BMC Username] [BMC Password] --iso [ISO Folder] --web [Web Port] --vnc [VNC Port]"
    exit 1
fi

BMC_IP="$1"
BMC_USER="$2"
BMC_PASS="$3"
shift 3

ISO_FOLDER=""
WEB_PORT="5800"
VNC_PORT=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --iso)
            ISO_FOLDER="$2"
            shift 2
            ;;
        --web)
            WEB_PORT="$2"
            shift 2
            ;;
        --vnc)
            VNC_PORT="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done


MOUNT_ARG=""
if [ -n "${ISO_FOLDER}" ]; then
    MOUNT_ARG="${MOUNT_ARG} -v ${ISO_FOLDER}:/iso"
fi

PORT_ARG=""
if [ -n "${WEB_PORT}" ]; then
    PORT_ARG="${PORT_ARG} -p ${WEB_PORT}:5800"
fi

if [ -n "${VNC_PORT}" ]; then
    PORT_ARG="${PORT_ARG} -p ${VNC_PORT}:5900"
fi

docker run --rm \
    -e BMC_IP=${BMC_IP} \
    -e BMC_USER=${BMC_USER} \
    -e BMC_PASS=${BMC_PASS} \
    ${MOUNT_ARG} \
    ${PORT_ARG} \
    ghcr.io/nthu-lsalab/megarac-aster-ikvm:latest

