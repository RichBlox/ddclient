FROM alpine:3.21
LABEL org.opencontainers.image.authors="Robin Rijkeboer robin@richblox.nl" \
    org.opencontainers.image.source=https://github.com/RichBlox/ddclient \
    org.label-schema.license=GPL-2.0 \
    org.label-schema.name=ddclient

ARG DDCLIENT_VERSION=3.11.2-r0
ENV HOST= \
    INTERVAL=60 \
    IPLOOKUP_URI=https://checkipv4.dedyn.io \
    SERVER=update.dedyn.io \
    SERVICE_TYPE=dyndns2 \
    USER_LOGIN= \
    USER_SECRETNAME=ddclient-user

RUN apk add --no-cache --update curl ddclient=$DDCLIENT_VERSION \
      su-exec && \
    chown ddclient /var/cache/ddclient \
    && rm /etc/ddclient/ddclient.conf

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
