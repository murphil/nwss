alias d="docker"
alias di="docker images"
alias drmi="docker rmi"
alias dt="docker tag"
alias dp="docker ps"
alias dpa="docker ps -a"
alias dl="docker logs -ft"
alias dpl="docker pull"
alias dps="docker push"
alias dr="docker run -i -t --rm -v \$(pwd):/world"
alias drr="docker run --rm -v \$(pwd):/world"
alias dcs="docker container stop"
alias dcr="docker container rm"
alias dcp="docker cp"
alias dsp="docker system prune -f"
alias dspa="docker system prune --all --force --volumes"
alias dvi="docker volume inspect"
alias dvr="docker volume rm"
#alias dvp="docker volume prune"
alias dvp="docker volume rm \$(docker volume ls -q | awk -F, 'length(\$0) == 64 { print }')"
alias dvl="docker volume ls"
alias dvc="docker volume create"
alias dsv="docker save"
alias dld="docker load"
alias dh="docker history"
alias dhl="docker history --no-trunc"
alias dis="docker inspect"
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcud="docker-compose up -d"
alias dcd="docker-compose down"

function da {
    if [ $# -gt 1 ]; then
        docker exec -it $@
    else
        docker exec -it $1 /bin/sh -c "[ -e /bin/zsh ] && /bin/zsh || [ -e /bin/bash ] && /bin/bash || /bin/sh"
    fi
}

function dcsr {
    local i
    for i in $*
        docker container stop $i && docker container rm $i
}

_dgcn () {
    local dsc=()
    while read -r line; do
        local rest=$(echo $line | awk '{$1="";$2=""; print $0;}')
        local id=$(echo $line | awk '{print $1;}')
        local name=$(echo $line | awk '{print $2;}')
        dsc+="$name:$rest"
        dsc+="$id:$rest"
    done <<< $(docker container ls --format '{{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}\t')
    _describe containers dsc
}
compdef _dgcn da dcsr

function dvbk {
    for i in $*
        docker run --rm        \
            -v $(pwd):/backup  \
            -v ${i}:/data      \
            alpine             \
            tar zcvf /backup/vol_${i}_`date +%Y%m%d%H%M%S`.tar.gz -C /data .
}

_dvlq () {
    _alternative "docker volumes:volume:($(docker volume ls -q | awk -F, 'length($0) != 64 { print }'))"
}
compdef _dvlq dvbk

function dvrs {
    docker volume create $2
    docker run --rm            \
            -v $(pwd):/backup  \
            -v $2:/data        \
            alpine             \
            tar zxvf /backup/$1 -C /data
}

_dvrs () {
    _arguments '1:backup file:_files' '2:volume:_dvlq'
}
compdef _dvrs dvrs
