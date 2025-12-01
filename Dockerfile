FROM eclipse-temurin:21-jre

WORKDIR /data

ENV EULA=${EULA:-TRUE}
ENV XMX=${XMX:-2G}
ENV XMS=${XMS:-1G}

COPY server.jar /data/server.jar

ENTRYPOINT bash -c 'echo "eula=${EULA}" > eula.txt && java -Xmx${XMX} -Xms${XMS} -jar server.jar nogui'
