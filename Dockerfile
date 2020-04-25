FROM ubuntu:focal

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 TIMEZONE=Asia/Shanghai
ENV websocat_version=1.5.0
ARG websocat_url=https://github.com/vi/websocat/releases/download/v${websocat_version}/websocat_amd64-linux-static+udp
ARG s6url=https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-amd64.tar.gz
ENV DEV_DEPS \
        openssh-server \
        curl \
        nginx \
        neovim \
        rsync \
        iproute2 \
        wget \
        gpg \
        gpg-agent

RUN set -eux \
  ; apt-get update \
  ; apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    tzdata \
    locales \
    xz-utils \
    $DEV_DEPS \
  \
  ; ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
  ; echo "$TIMEZONE" > /etc/timezone \
  ; sed -i /etc/locale.gen \
    -e 's/# \(en_US.UTF-8 UTF-8\)/\1/' \
    -e 's/# \(zh_CN.UTF-8 UTF-8\)/\1/' \
  ; locale-gen \
  \
  ; mkdir -p /var/run/sshd \
  ; sed -i /etc/ssh/sshd_config \
        -e 's!.*\(AuthorizedKeysFile\).*!\1 /etc/authorized_keys/%u!' \
        -e 's!.*\(GatewayPorts\).*!\1 yes!' \
        -e 's!.*\(PasswordAuthentication\).*yes!\1 no!' \
  \
  ; sed -i '1i\daemon off;' /etc/nginx/nginx.conf \
  ; rm -rf /etc/nginx/sites-available/* \
  ; rm -rf /etc/nginx/sites-enabled/* \
  \
  ; wget -q -O /usr/local/bin/websocat ${websocat_url} \
    ; chmod a+x /usr/local/bin/websocat \
  \
  ; curl --fail --silent -L ${s6url} | \
    tar xzvf - -C / \
  ; chmod go-w /etc \
  \
  ; apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

COPY services.d /etc/services.d
COPY nginx.default.conf /etc/nginx/conf.d/default.conf
WORKDIR /srv

VOLUME [ "/srv", "/root/.vscode-server" ]
EXPOSE 80

ENTRYPOINT [ "/init" ]

ENV WEB_SERVERNAME=
ENV WEB_ROOT=
ENV WS_FIXED=