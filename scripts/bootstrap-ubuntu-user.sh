#!/bin/bash
declare -A TO_INSTALL=(
["tpm"]="tmux"
["oh-my-zsh"]="zsh"
["vundle"]="vim"
)

# cli parser
PACKAGES=()
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -d|--dry-run)
            DRY_RUN="true"
            shift # past argument
            ;;
        -h|--help)
            HELP="true"
            shift ;;
        *)    # unknown option
            PACKAGES+=("$1") # save it in an array for later
            shift ;;
    esac
done

if [[ -n "$HELP" ]]; then
    echo "Usage: $0 [-d | --dry-run] [-h | --help] [PACKAGES ...]"; exit
fi

containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

if (( ${#PACKAGES[@]} )); then
    for key in "${!TO_INSTALL[@]}"; do
        if ! containsElement "$key" "${PACKAGES[@]}"; then
            unset 'TO_INSTALL["$key"]'
        fi
    done
fi

DEPEND_OK=()
DEPEND_FAIL=()
for prog in "${!TO_INSTALL[@]}"; do
    if command -v ${TO_INSTALL[$prog]} 2>&1 >/dev/null; then
        DEPEND_OK+=($prog)
    else
        DEPEND_FAIL+=($prog)
    fi
done
printf "%-16s: %s\n" "dependency ok" "${DEPEND_OK[*]}"
printf "%-16s: %s\n" "dependency fail" "${DEPEND_FAIL[*]}"

install_tpm() {
    echo installing tpm, see https://github.com/tmux-plugins/tpm
    if [[ -n "$DRY_RUN" ]]; then return 0; fi
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ./install.sh home/tmux*
    tmux start-server && tmux new-session -d && sleep 1 && ~/.tmux/plugins/tpm/scripts/install_plugins.sh
    tmux kill-server
}
install_oh_my_zsh() {
    echo installing on-my-zsh, run \`chsh\` later manually, see https://github.com/robbyrussell/oh-my-zsh/
    if [[ -n "$DRY_RUN" ]]; then return 0; fi
    CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    mv ~/.zshrc ~/.zshrc.bak
    [ -n "$ZSH_CUSTOM" ] || ZSH_CUSTOM=~/.oh-my-zsh/custom
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
}
install_vundle() {
    echo installing vundle, see https://github.com/VundleVim/Vundle.vim
    if [[ -n "$DRY_RUN" ]]; then return 0; fi
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    ./install.sh home/vim
    vim +PluginInstall +qall
}
if (( ${#DEPEND_OK[@]} )); then
    for prog in "${DEPEND_OK[@]}"; do
        case $prog in
            tpm)
                install_tpm ;;
            oh-my-zsh)
                install_oh_my_zsh ;;
            vundle)
                install_vundle ;;
            *)
                echo unknown package ;;
        esac
    done
fi
