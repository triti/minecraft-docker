FROM jeanblanchard/java:serverjre-8

MAINTAINER Tyler Riti <me@tylerriti.org>

ENV MC_VERSION latest

COPY start start_minecraft server_download /

RUN apk add --update \
        curl \
        jq && \
    adduser -D -H -s /bin/false -u 1000 minecraft && \
    mkdir -p /minecraft && \
    /server_download && \
    chown -R minecraft:minecraft /minecraft /start_minecraft && \
    apk del curl jq && \
    rm -rf /server_download /var/cache/apk/*

EXPOSE 25565

USER minecraft

VOLUME /minecraft
WORKDIR /minecraft

ENTRYPOINT ["/start"]

CMD ["/start_minecraft"]

ENV JVM_OPTS -Xmx1024M -Xms1024M
