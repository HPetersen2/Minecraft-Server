FROM eclipse-temurin:17-jre

WORKDIR /minecraft-server

COPY server.jar .
COPY eula.txt .

EXPOSE 8888

CMD ["java", "-Xmx2G", "-Xms1G", "-jar", "server.jar", "nogui"]
