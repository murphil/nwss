if (( $+commands[kubectl] )); then
    __KUBECTL_COMPLETION_FILE="${HOME}/.zsh_cache/kubectl_completion"

    if [[ ! -f $__KUBECTL_COMPLETION_FILE ]]; then
        mkdir -p ${HOME}/.zsh_cache
        kubectl completion zsh >! $__KUBECTL_COMPLETION_FILE
    fi

    [[ -f $__KUBECTL_COMPLETION_FILE ]] && source $__KUBECTL_COMPLETION_FILE

    unset __KUBECTL_COMPLETION_FILE
fi

# This command is used a LOT both below and in daily life
alias k=$KUBECTL_CMD
alias kg="$KUBECTL_CMD get"
alias kd="$KUBECTL_CMD describe"
alias ke="$KUBECTL_CMD edit"
alias kc="$KUBECTL_CMD create"

# Execute a $KUBECTL_CMD command against all namespaces
alias kca="f(){ $KUBECTL_CMD \"\$@\" --all-namespaces;  unset -f f; }; f"

# Apply a YML file
alias kaf="$KUBECTL_CMD apply -f"
# Apply resources from a directory containing kustomization.yaml
alias kak="$KUBECTL_CMD apply -k"

# Drop into an interactive terminal on a container
alias keti="$KUBECTL_CMD exec -ti"
alias kat="$KUBECTL_CMD exec -ti"

# Manage configuration quickly to switch contexts between local, dev ad staging.
alias kcuc="$KUBECTL_CMD config use-context"
alias kcsc="$KUBECTL_CMD config set-context"
alias kcdc="$KUBECTL_CMD config delete-context"
alias kccc="$KUBECTL_CMD config current-context"

# List all contexts
alias kcgc="$KUBECTL_CMD config get-contexts"

# General aliases
alias kdel="$KUBECTL_CMD delete"
alias kdelf="$KUBECTL_CMD delete -f"
alias kdelk="$KUBECTL_CMD delete -k"

# Pod management.
alias kgp="$KUBECTL_CMD get pods"
alias kgpw="kgp --watch"
alias kgpwide="kgp -o wide"
alias kep="$KUBECTL_CMD edit pods"
alias kdp="$KUBECTL_CMD describe pods"
alias kdelp="$KUBECTL_CMD delete pods"

# get pod by label: kgpl "app=myapp" -n myns
alias kgpl="kgp -l"

# Service management.
alias kgs="$KUBECTL_CMD get svc"
alias kgsw="kgs --watch"
alias kgswide="kgs -o wide"
alias kes="$KUBECTL_CMD edit svc"
alias kds="$KUBECTL_CMD describe svc"
alias kdels="$KUBECTL_CMD delete svc"

# Ingress management
alias kgi="$KUBECTL_CMD get ingress"
alias kei="$KUBECTL_CMD edit ingress"
alias kdi="$KUBECTL_CMD describe ingress"
alias kdeli="$KUBECTL_CMD delete ingress"

# Namespace management
alias kgns="$KUBECTL_CMD get namespaces"
alias kens="$KUBECTL_CMD edit namespace"
alias kdns="$KUBECTL_CMD describe namespace"
alias kcns="$KUBECTL_CMD create namespace"
alias kdelns="$KUBECTL_CMD delete namespace"
alias kcn="$KUBECTL_CMD config set-context \$(\$KUBECTL_CMD config current-context) --namespace"

# ConfigMap management
alias kgcm="$KUBECTL_CMD get configmaps"
alias kecm="$KUBECTL_CMD edit configmap"
alias kdcm="$KUBECTL_CMD describe configmap"
alias kdelcm="$KUBECTL_CMD delete configmap"

# Secret management
alias kgsec="$KUBECTL_CMD get secret"
alias kdsec="$KUBECTL_CMD describe secret"
alias kdelsec="$KUBECTL_CMD delete secret"

# Deployment management.
alias kgd="$KUBECTL_CMD get deployment"
alias kgdw="kgd --watch"
alias kgdwide="kgd -o wide"
alias ked="$KUBECTL_CMD edit deployment"
alias kdd="$KUBECTL_CMD describe deployment"
alias kdeld="$KUBECTL_CMD delete deployment"
alias ksd="$KUBECTL_CMD scale deployment"
alias krsd="$KUBECTL_CMD rollout status deployment"
kres(){
    $KUBECTL_CMD set env $@ REFRESHED_AT=$(date +%Y%m%d%H%M%S)
}

# Rollout management.
alias kgrs="$KUBECTL_CMD get rs"
alias krh="$KUBECTL_CMD rollout history"
alias kru="$KUBECTL_CMD rollout undo"

# Statefulset management.
alias kgss="$KUBECTL_CMD get statefulset"
alias kgssw="kgss --watch"
alias kgsswide="kgss -o wide"
alias kess="$KUBECTL_CMD edit statefulset"
alias kdss="$KUBECTL_CMD describe statefulset"
alias kdelss="$KUBECTL_CMD delete statefulset"
alias ksss="$KUBECTL_CMD scale statefulset"
alias krsss="$KUBECTL_CMD rollout status statefulset"

# Port forwarding
alias kpf="$KUBECTL_CMD port-forward"

# Tools for accessing all information
alias kga="$KUBECTL_CMD get all"
alias kgaa="$KUBECTL_CMD get all --all-namespaces"

# Logs
alias kl="$KUBECTL_CMD logs"
alias klf="$KUBECTL_CMD logs -f"

# File copy
alias kcp="$KUBECTL_CMD cp"

# Node Management
alias kgno="$KUBECTL_CMD get nodes"
alias keno="$KUBECTL_CMD edit node"
alias kdno="$KUBECTL_CMD describe node"
alias kdelno="$KUBECTL_CMD delete node"

# PVC management.
alias kgpvc="$KUBECTL_CMD get pvc"
alias kgpvcw="kgpvc --watch"
alias kepvc="$KUBECTL_CMD edit pvc"
alias kdpvc="$KUBECTL_CMD describe pvc"
alias kdelpvc="$KUBECTL_CMD delete pvc"

# top
alias ktn="$KUBECTL_CMD top node"
alias ktp="$KUBECTL_CMD top pod"

if (( $+commands[helm] )); then
    __HELM_COMPLETION_FILE="${HOME}/.zsh_cache/helm_completion"

    if [[ ! -f $__HELM_COMPLETION_FILE ]]; then
        helm completion zsh >! $__HELM_COMPLETION_FILE
    fi

    [[ -f $__HELM_COMPLETION_FILE ]] && source $__HELM_COMPLETION_FILE

    unset __HELM_COMPLETION_FILE
fi
