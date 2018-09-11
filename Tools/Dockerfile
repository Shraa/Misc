FROM debian

LABEL \
    version="1.0"\
    author="Mikhail Velkin <twilight@solfoto.ru>" \
    maintainer="Mikhail Velkin <twilight@solfoto.ru>" \
    description="Diagnostic Tools" \
    source="https://github.com/Shraa/Misc"

ENV TZ=Europe/Moscow \
    GIT_DIR=/tmp \
    DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

RUN set -ex \
 && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
 && dpkg-reconfigure tzdata \
 && apt-get update -yqq \
 && apt-get upgrade -yqq \
 && apt-get install --no-install-recommends -yqq \
      apt-transport-https \
      ca-certificates \
      lsb-release \
      wget \
      unzip \
 && wget --quiet -O /tmp/mysql-apt-config_0.8.10-1_all.deb http://dev.mysql.com/get/mysql-apt-config_0.8.10-1_all.deb \
 && apt-get install -yqq /tmp/mysql-apt-config_0.8.10-1_all.deb \
 && apt-get update -yqq \
 && apt-get upgrade -yqq \
 && apt-get install --no-install-recommends -yqq \
      apache2-utils \
      dnsutils \
      git \
      libgdiplus \
      mysql-client \
      net-tools \
 && rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/* \
      /usr/share/man \
      /usr/share/doc \
      /usr/share/doc-base

COPY assets/entrypoint.sh /entrypoint.sh

CMD ["bash", "/entrypoint.sh"]
