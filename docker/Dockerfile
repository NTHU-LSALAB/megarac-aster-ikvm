# Pull base image
FROM jlesage/baseimage-gui:alpine-3.21-v4

# Install java & curl
RUN apk update && \
    apk add curl openjdk8-jre perl

# Create working directory
RUN mkdir /app && chmod 777 /app
WORKDIR /app

# Copy JViewer files
ADD libs libs
COPY JViewer.jar JViewer.jar

# Set App name
RUN set-cont-env APP_NAME "MegaRAC Aster iKVM"

# Copy the start script
COPY startapp.sh /startapp.sh
