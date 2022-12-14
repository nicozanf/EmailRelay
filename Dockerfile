# see https://github.com/nicozanf/EmailRelay
# Modified from https://github.com/NMichas/EmailRelay
# Modified from https://github.com/drdaeman/docker-emailrelay

FROM alpine:latest

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=2.3

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="E-MailRelay Docker container" \
      org.label-schema.description="" \
      org.label-schema.url="https://github.com/nicozanf/EmailRelay" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/nicozanf/EmailRelay" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0" \
      maintainer="nicozanf@gmail.com"

RUN apk add --no-cache libstdc++ openssl ca-certificates \
 && update-ca-certificates

RUN apk add --no-cache --virtual .deps curl g++ make autoconf automake openssl-dev \
 && mkdir -p /tmp/build && cd /tmp/build \
 && curl -o emailrelay.tar.gz -L "https://downloads.sourceforge.net/project/emailrelay/emailrelay/${VERSION}/emailrelay-${VERSION}-src.tar.gz" \
 && tar xzf emailrelay.tar.gz \
 && cd emailrelay-${VERSION} \
 && ./configure --prefix=/usr --with-openssl \
 && make \
 && make install \
 && apk --no-cache del .deps g++ make autoconf automake \
 && cd / \
 && rm -rf /tmp/build /var/tmp/* /var/cache/apk/* /var/cache/distfiles/* \
 && mkdir -p /var/spool/emailrelay \
 && mkdir /config

CMD emailrelay --help --verbose
