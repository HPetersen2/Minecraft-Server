FROM eclipse-temurin:21-jre

ARG EULA=TRUE
ARG XMX=2G
ARG XMS=1G
ARG ENABLE_QUERY=FALSE
ARG QUERY_PORT=25565

WORKDIR /data

COPY server.jar /tmp/server.jar
COPY entrypoint.sh /data/entrypoint.sh

RUN chmod +x /data/entrypoint.sh

ENV QUERY_PORT=${QUERY_PORT:-25565}
ENV EULA=${EULA:-TRUE}
ENV XMX=${XMX:-2G}
ENV XMS=${XMS:-1G}
ENV ENABLE_QUERY=${ENABLE_QUERY:-FALSE}

ENTRYPOINT ["./entrypoint.sh"]