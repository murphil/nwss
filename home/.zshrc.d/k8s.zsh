if (( $+commands[kubectl] )); then
    export KUBECTL_CMD=kubectl
elif (( $+commands[k3s] )); then
    export KUBECTL_CMD="k3s kubectl"
elif (( $+commands[microk8s.kubectl] )); then
    export KUBECTL_CMD=microk8s.kubectl
fi


if [ ! -z $KUBECTL_CMD ]; then
    source $CFG/.zshrc.d/k8s/kubectl.zsh
    source $CFG/.zshrc.d/k8s/kube-ps1.zsh

    export KUBE_EDITOR=vim

    if (( $+commands[k3d] )); then
        export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-default')"
    elif (( $+commands[k3s] )); then
        export KUBECONFIG=~/.local/etc/rancher/k3s/k3s.yaml
        # sudo k3s server --docker --no-deploy traefik
    elif (( $+commands[kind] )); then
        export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"
        source $CFG/.zshrc.d/k8s/kind.zsh
    fi

    if [[ ! "$PATH" == */opt/cni/bin* && -d /opt/cni/bin ]]; then
        export PATH=/opt/cni/bin:$PATH
    fi

    function clean-evicted-pod {
        kubectl get pods --all-namespaces -ojson | jq -r '.items[] | select(.status.reason!=null) | select(.status.reason | contains("Evicted")) | .metadata.name + " " + .metadata.namespace' | xargs -n2 -l bash -c 'kubectl delete pods $0 --namespace=$1'
    }

    function dplm {
        if [[ $1 =~ '.*@sha256.*' ]]; then
            tag=$(echo $1 | awk -F'@sha256:' '{print $1}')
        # elif [[ $1 =~ '^nnurphy/' ]]; then
        #     tag=$(echo $1 | sed 's!^nnurphy/!!')
        else
            tag=$1
        fi

        if [[ $1 =~ '^gcr.io/' ]]; then
            img=$(echo $1 | sed 's!^gcr.io/!gcr.azk8s.cn/!')
        elif [[ $1 =~ '^k8s.gcr.io/' ]]; then
            img=$(echo $1 | sed 's!^k8s.gcr.io/!gcr.azk8s.cn/google-containers/!')
        elif [[ $1 =~ '^quay.io/'  ]]; then
            img=$(echo $1 | sed 's!^quay.io/!quay.azk8s.cn/!')
        elif [[ ! $1 =~ '/' ]]; then
            img=$(echo "library/$1")
        else
            img=$1
        fi

        echo "pull ==> $img"
        docker pull $img
        echo "tag ==> $tag"
        docker tag $img $tag
        docker rmi $img
    }
fi
