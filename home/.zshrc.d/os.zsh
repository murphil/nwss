# $OSTYPE =~ [mac]^darwin, linux-gnu, [win]msys, FreeBSD, [termux]linux-android
# Darwin\ *64;Linux\ armv7*;Linux\ aarch64*;Linux\ *64;CYGWIN*\ *64;MINGW*\ *64;MSYS*\ *64

case $(uname -sm) in
  Darwin\ *64 )
    alias lns='ln -fs'
    function after { lsof -p $1 +r 1 &>/dev/null }
    alias osxattrd='xattr -r -d com.apple.quarantine'
    alias rmdss='find . -name ".DS_Store" -depth -exec rm {} \;'
    [[ -x $HOME/.iterm2_shell_integration.zsh ]]  && source $HOME/.iterm2_shell_integration.zsh
  ;;
  Linux\ *64 )
    alias lns='ln -fsr'
    function after { tail --pid=$1 -f /dev/null }
  ;;
  * )
    alias lns='ln -fsr'
  ;;
esac

function change_sources {
  case $(grep ^ID= /etc/os-release | sed 's/ID=\(.*\)/\1/') in
    debian | ubuntu )
      cp /etc/apt/sources.list /etc/apt/sources.list.$(date +%y%m%d%H%M%S)
      sed -i 's/\(.*\)\(security\|deb\).debian.org\(.*\)main/\1ftp2.cn.debian.org\3main contrib non-free/g' /etc/apt/sources.list
    ;;
    alpine )
      cp /etc/apk/repositories /etc/apk/repositories.$(date +%y%m%d%H%M%S)
      sed -i 's/dl-cdn.alpinelinux.org/mirror.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
    ;;
    * )
  esac
}