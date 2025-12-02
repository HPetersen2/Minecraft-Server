FROM eclipse-temurin:21-jre

WORKDIR /data

ENV EULA=${EULA:-TRUE}
ENV XMX=${XMX:-2G}
ENV XMS=${XMS:-1G}

COPY server.jar /data/server.jar

ENTRYPOINT ["bash", "-c", "\
echo \"eula=$EULA\" > eula.txt && \
sed -i 's/enable-query=.*/enable-query=true/' server.properties || echo 'enable-query=true' >> server.properties && \
sed -i 's/query.port=.*/query.port=$QUERY_PORT/' server.properties || echo 'query.port=$QUERY_PORT' >> server.properties && \
java -Xmx$XMX -Xms$XMS -jar server.jar nogui"]
