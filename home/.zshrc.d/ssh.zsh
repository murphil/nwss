alias sa='ssh-agent $SHELL'
alias sad='ssh-add'
alias rs="rsync -avP"

function s {
    local password="-o IdentitiesOnly=yes "
    local ignore_host_check=""
    local cmd="ssh "
    local show=""
    eval set -- $(getopt -o VPIi:p:R:L:D: -- "$@")
    while true; do
        case "$1" in
        -V)
            show="1"
            ;;
        -I)
            ignore_host_check="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "
            ;;
        -P)
            password=""
            ;;
        -i)
            shift
            cmd+="-i $1 "
            ;;
        -p)
            shift
            cmd+="-p $1 "
            ;;
        -R)
            shift
            cmd+="-NTvR $1 "
            ;;
        -L)
            shift
            cmd+="-NTvL $1 "
            ;;
        -D)
            shift
            cmd+="-NTvD $1 "
            ;;
        --)
            shift
            break
            ;;
        esac
        shift
    done

    cmd+="${password}${ignore_host_check}$1"
    if [ ! -z $2 ]; then
        shift
        cmd+=" $SHELL -ic '$@'"
    fi

    if [ ! -z $show ]; then
        ssh -V
        echo
        echo $cmd
        return
    fi

    eval $cmd
}

compdef s=ssh