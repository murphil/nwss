build:
    docker build . -t nnurphy/nwss \
        --build-arg s6url=http://d.d/s6-overlay-amd64.tar.gz \
        --build-arg websocat_url=http://d.d/websocat_amd64-linux-static%2Budp

build-apk:
    docker build . -t nnurphy/nwss:alpine \
        -f Dockerfile-apk \
        --build-arg s6url=http://172.178.1.204:2015/s6-overlay-amd64.tar.gz \
        --build-arg websocat_url=http://172.178.1.204:2015/tools/websocat_amd64-linux-static%2Budp

build-node:
    docker build . -t nnurphy/nwss:node \
        -f Dockerfile-node

#-v $(pwd)/location:/etc/nginx/location \
test tag="latest":
    docker run --rm \
        --name=test \
        -p 8090:80 \
        -p 8022:22 \
        -v $(pwd):/app \
        -v vscode-server:/root/.vscode-server \
        -e WEB_ROOT=/app \
        -v $PWD/id_ed25519.pub:/etc/authorized_keys/root \
        nnurphy/nwss

client url token:
    websocat -E -b tcp-l:127.0.0.1:2288 ws://{{url}}/websocat-{{token}}


tunnel url token:
    websocat -E -b \
        tcp-l:127.0.0.1:8080 \
        ws://{{url}}/websocat-{{token}}

# Host websocat
#     HostName localhost
#     User root
#     IdentitiesOnly yes
#     IdentityFile ~/.ssh/id_ecdsa
#     Port 2288
#     StrictHostKeyChecking no
#     UserKnownHostsFile /dev/null