FROM debian:10-slim

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 TIMEZONE=Asia/Shanghai
ENV websocat_version=1.5.0
ARG websocat_url=https://github.com/vi/websocat/releases/download/v${websocat_version}/websocat_amd64-linux-static+udp
ARG s6url=https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-amd64.tar.gz
ENV DEV_DEPS \
        openssh-server \
        curl \
        nginx \
        vim \
        socat \
        rsync \
        iproute2 \
        gpg gpg-agent

RUN set -eux \
  ; sed -i 's/\(.*\)\(security\|deb\).debian.org\(.*\)main/\1ftp.cn.debian.org\3main contrib non-free/g' /etc/apt/sources.list \
  ; apt-get update \
  ; apt-get install -y --no-install-recommends \
 		apt-transport-https \
		ca-certificates \
    tzdata \
		xz-utils \
		$DEV_DEPS \
  ; apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
  ; curl --fail --silent -L ${s6url} | \
    tar xzvf - -C / \
  \
  ; ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
  ; echo "$TIMEZONE" > /etc/timezone \
  \
  ; mkdir -p /var/run/sshd \
  \
  ; sed -i '1i\daemon off;' /etc/nginx/nginx.conf \
  ; rm -rf /etc/nginx/sites-available/* \
  ; rm -rf /etc/nginx/sites-enabled/* \
  \
  ; curl ${websocat_url} > /usr/local/bin/websocat \
    ; chmod a+x /usr/local/bin/websocat

COPY services.d /etc/services.d
COPY nginx.default.conf /etc/nginx/conf.d/default.conf
WORKDIR /srv

VOLUME [ "/srv", "/root/.vscode-server" ]
EXPOSE 80

ENTRYPOINT [ "/init" ]
