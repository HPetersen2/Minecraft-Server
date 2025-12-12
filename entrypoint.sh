#!/bin/bash
set -e

# Server JAR kopieren, falls noch nicht vorhanden
if [ ! -f /data/server.jar ]; then
    cp /tmp/server.jar /data/server.jar
fi

# EULA akzeptieren
echo "eula=$EULA" > /data/eula.txt

# server.properties anpassen
if [ -f /data/server.properties ]; then
    sed -i "s/enable-query=.*/enable-query=${ENABLE_QUERY}/" /data/server.properties
    sed -i "s/query.port=.*/query.port=${QUERY_PORT}/" /data/server.properties
else
    echo "enable-query=${ENABLE_QUERY}" >> /data/server.properties
    echo "query.port=${QUERY_PORT}" >> /data/server.properties
fi

# Minecraft Server starten
exec java -Xmx${XMX} -Xms${XMS} -jar /data/server.jar nogui
