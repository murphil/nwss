function entf {
    local title
    local content=""
    eval set -- $(getopt -o t:c: -- "$@")
    while true; do
        case "$1" in
        -t)
            shift
            title=$1
            ;;
        -c)
            shift
            content=$1
            ;;
        --)
            shift
            break
            ;;
        esac
        shift
    done

    curl -# --ssl \
        --url "smtp://${EMAIL_SERVER:-smtp.qq.com}" \
        --user "${EMAIL_ACCOUNT}:${EMAIL_TOKEN}" \
        --mail-from $EMAIL_ACCOUNT \
        --mail-rcpt $1 \
        --upload-file <(echo -e "From: \"$EMAIL_ACCOUNT\" <$EMAIL_ACCOUNT>\nTo: \"$1\" <$1>\nSubject: ${title}\nDate: $(date)\n\n${content}")
}

function _comp_entf_recipients {
    local -a recipients
    for i in ${(ps:\n:)EMAIL_RECIPIENTS}; do
        recipients+=($i)
    done
    _describe 'recipients' recipients
}

function _comp_entf {
    _arguments '-t[title]' '-c[content]' '1:recipient:_comp_entf_recipients'
}

compdef _comp_entf entf

function wstun {
    local listen="127.0.0.1:2288"
    local url
    local cmd
    local protocol="ws"
    eval set -- $(getopt -o l:s -- "$@")
    while true; do
        case "$1" in
        -l)
            shift
            listen=$1
            ;;
        -s)
            protocol="wss"
            ;;
        --)
            shift
            break
            ;;
        esac
        shift
    done

    if [ -z $2 ]; then
        url=$1
    else
        url="$1/$2"
    fi
    cmd="websocat -E -b tcp-l:${listen} $protocol://$url"

    echo $cmd
    eval $cmd
}
