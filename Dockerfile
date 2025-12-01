FROM eclipse-temurin:21-jre

WORKDIR /data

COPY server.jar /data/server.jar

ENTRYPOINT bash -c 'echo "eula=$EULA" > eula.txt && java -Xmx2G -Xms1G -jar server.jar nogui'