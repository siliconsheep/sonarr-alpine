FROM frolvlad/alpine-mono

MAINTAINER Dieter Bocklandt <dieterbocklandt@gmail.com>

ARG SONARR_VERSION=2.0.0.5252

ENV MEDIA_GID 666
ENV SONARR_UID 666

ADD sonarr.sh /sonarr.sh
RUN chmod 755 /sonarr.sh

RUN \
  addgroup -S media -g ${MEDIA_GID} && \
  adduser -S sonarr -G media -u ${SONARR_UID} -h /config -s /bin/sh && \
  apk add --update libmediainfo sqlite curl && \
  curl -SL -o /tmp/sonarr.tar.gz http://download.sonarr.tv/v2/master/mono/NzbDrone.master.${SONARR_VERSION}.mono.tar.gz && \
  mkdir -p /opt && \
  tar xzf /tmp/sonarr.tar.gz -C /opt && \
  chown -R sonarr:media /opt/NzbDrone && \
  apk del make gcc g++ curl && \
  rm -rf /var/cache/apk/* /tmp/sonarr.tar.gz

EXPOSE 8989

WORKDIR /opt/NzbDrone

CMD ["/sonarr.sh"]