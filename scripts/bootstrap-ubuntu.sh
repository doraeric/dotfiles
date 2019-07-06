#!/bin/bash
# Required by bootstrap-ubuntu-user.sh
TO_INSTALL=(zsh tmux xsel git curl)

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

if (( ${#PACKAGES[@]} )); then
    TO_INSTALL=("${PACKAGES[@]}")
fi

INSTALLED=()
NOT_INSTALLED=()
for prog in "${TO_INSTALL[@]}"; do
    if command -v $prog 2>&1 >/dev/null; then
        INSTALLED+=($prog)
    else
        NOT_INSTALLED+=($prog)
    fi
done

printf "%-16s: %s\n" "installed" "${INSTALLED[*]}"
printf "%-16s: %s\n" "not installed" "${NOT_INSTALLED[*]}"
if (( ${#NOT_INSTALLED[@]} )); then
    cmd="sudo apt-get update; sudo apt-get install -y ${NOT_INSTALLED[*]}"
    printf "%-16s: %s\n" "running command" "$cmd"
    if [[ -z "${DRY_RUN}" ]]; then
        sh -c "$cmd"
    fi
fi
