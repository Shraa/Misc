FROM microsoft/dotnet:sdk

LABEL \
    version="1.0"\
    maintainer="Aleksey Kondratyev <ronkajitsu@gmail.com>" \
    description="diagnistic toolset" \
    source="https://github.com/ScanEx/IdentityServer-WebAdm"

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
 && apt-get install /tmp/mysql-apt-config_0.8.10-1_all.deb \
 && curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
 && echo "deb https://deb.nodesource.com/node_9.x $(lsb_release -s -c) main" | tee /etc/apt/sources.list.d/nodesource.list \
 && apt-get update -yqq \
 && apt-get install --no-install-recommends -yqq \
      apache2-utils \
      git \
      libgdiplus \
      mysql-client \
      nodejs \
      npm \
 && update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 \
 && npm install -g bower \
 && rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/* \
      /usr/share/man \
      /usr/share/doc \
      /usr/share/doc-base

COPY assets/src /app
COPY assets/database /opt

WORKDIR /app/

RUN set -ex \
 && dotnet restore \
 && dotnet publish -c Debug -o out \
 && bower install --force --allow-root

EXPOSE 5000

# ENTRYPOINT ["bash", "start.sh"]
CMD ["bash", "start.sh"]