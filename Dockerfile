FROM eclipse-temurin:21-jre

RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

ARG EULA=TRUE
ARG XMX=2G
ARG XMS=1G
ARG ENABLE_QUERY=FALSE
ARG QUERY_PORT=25565

WORKDIR /data

COPY server.jar /tmp/server.jar
COPY requirements.txt /tmp/requirements.txt

RUN python3 -m venv /opt/venv
RUN /opt/venv/bin/pip install --no-cache-dir -r /tmp/requirements.txt

ENV QUERY_PORT=${QUERY_PORT:-25565}
ENV EULA=${EULA:-TRUE}
ENV XMX=${XMX:-2G}
ENV XMS=${XMS:-1G}
ENV ENABLE_QUERY=${ENABLE_QUERY:-FALSE}

ENTRYPOINT ["bash", "-c", "\
if [ ! -f /data/server.jar ]; then cp /tmp/server.jar /data/server.jar; fi && \
echo \"eula=$EULA\" > eula.txt && \
sed -i \"s/enable-query=.*/enable-query=${ENABLE_QUERY}/\" server.properties 2>/dev/null || echo \"enable-query=${ENABLE_QUERY}\" >> server.properties && \
sed -i \"s/query.port=.*/query.port=${QUERY_PORT}/\" server.properties 2>/dev/null || echo \"query.port=${QUERY_PORT}\" >> server.properties && \
java -Xmx${XMX} -Xms${XMS} -jar server.jar nogui"]