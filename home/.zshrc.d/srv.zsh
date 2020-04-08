function re-zsh {
    source ~/.zshrc
}

function make-swapfile {
    local file="/root/swapfile"
    local size="16"
    local options=$(getopt -o f:s: -- "$@")
    eval set -- "$options"
    while true; do
        case "$1" in
        -f)
            shift
            file=$1
            ;;
        -s)
            shift
            size=$1
            ;;
        --)
            shift
            break
            ;;
        esac
        shift
    done

    dd if=/dev/zero of=$file bs=1M count=$((1024*${size})) # GB
    chmod 0600 $file
    mkswap $file
    swapon $file
    echo "$file swap swap defaults 0 2" >> /etc/fstab
}

alias ssc='systemctl'


function iptables---- {
    iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
    iptables -A INPUT -p tcp -m multiport --dport 22,80,443 -j ACCEPT
    iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
    iptables -A INPUT -p tcp --dport 55555 -j ACCEPT
    iptables -A INPUT -p tcp --dport 2222 -j ACCEPT
    iptables -A INPUT -i lo -j ACCEPT
    iptables -A INPUT -i wg0 -j ACCEPT
    iptables -P INPUT DROP
}

function iptables-allow-address {
    iptables -A INPUT -s $1 -j ACCEPT
}

function iptables-clean-input {
    iptables -P INPUT ACCEPT
    iptables -F
}

alias iptables-list-input="iptables -L INPUT --line-num -n"
