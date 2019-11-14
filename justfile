build:
    docker build . -t nnurphy/nwss \
        --build-arg s6url=http://172.178.1.204:2015/s6-overlay-amd64.tar.gz \
        --build-arg websocat_url=http://172.178.1.204:2015/tools/websocat_amd64-linux-static%2Budp

test:
    docker run --rm \
        --name=test \
        -p 8090:80 \
        -v $(pwd):/app \
        -v vscode-server:/root/.vscode-server \
        -e WEB_ROOT=/app \
        -e WEB_SERVERNAME=srv.1 \
        -e WS_FIXED=1 \
        -v $(pwd)/id_ecdsa.pub:/root/.ssh/authorized_keys \
        nnurphy/nwss

client url token:
    websocat -E -b tcp-l:127.0.0.1:2288 ws://{{url}}/websocat-{{token}}


tunnel url token:
    docker run --rm \
        --name=nwss \
        -p 2288:8080 \
        nnurphy/websocat -E -b \
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