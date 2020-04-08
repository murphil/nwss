alias kdcc="kind create cluster --image kindest/node:v1.16.2"
alias kdli="kind load docker-image"

# kind completion zsh
_comp_kind () {
    _arguments \
      '1: :->level1' \
      '2: :->level2' \
      '3: :_files'
    case $state in
      level1)
        case $words[1] in
          kind)
            _arguments '1: :(build completion create delete export get help load version)'
          ;;
          *)
            _arguments '*: :_files'
          ;;
        esac
      ;;
      level2)
        case $words[2] in
          create)
            _arguments '2: :(cluster)'
          ;;
          delete)
            _arguments '2: :(cluster)'
          ;;
          export)
            _arguments '2: :(logs)'
          ;;
          get)
            _arguments '2: :(clusters kubeconfig kubeconfig-path nodes)'
          ;;
          load)
            _arguments '2: :(docker-image image-archive)'
          ;;
          build)
            _arguments '2: :(base-image node-image)'
          ;;
          completion)
            _arguments '2: :(bash zsh)'
          ;;
          *)
            _arguments '*: :_files'
          ;;
        esac
      ;;
      *)
        _arguments '*: :_files'
      ;;
    esac
}

compdef _comp_kind kind

