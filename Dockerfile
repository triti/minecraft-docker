FROM jeanblanchard/java:serverjre-8

MAINTAINER Tyler Riti <me@tylerriti.org>

ENV MC_VERSION 1.8.8

COPY start-minecraft.sh /start-minecraft

RUN apk add --update curl && \
    adduser -D -H -s /bin/false -u 1000 minecraft && \
    mkdir -p /minecraft && \
    curl -Lso /minecraft/minecraft.jar \
        https://s3.amazonaws.com/Minecraft.Download/versions/${MC_VERSION}/minecraft_server.${MC_VERSION}.jar && \
    chown -R minecraft:minecraft /minecraft /start-minecraft && \
    apk del curl && \
    rm -rf /var/cache/apk/*

EXPOSE 25565

VOLUME /minecraft
WORKDIR /minecraft

USER minecraft

CMD ["/start-minecraft"]

ENV JVM_OPTS -Xmx1024M -Xms1024M
