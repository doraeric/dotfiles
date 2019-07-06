#!/bin/bash

CONFS=()
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -d|--dry-run)
            DRY_RUN="true"
            shift # past argument
            ;;
        -h|--help)
            HELP=YES
            shift ;;
        *)    # unknown option
            CONFS+=("$1") # save it in an array for later
            shift ;;
    esac
done
set -- "${CONFS[@]}" # restore positional parameters

if [[ -n "$HELP" ]]; then
    echo "Usage: $0 [-d | --dry-run] [-h | --help] [CONFS ...]"; exit
fi

# default
if (( ! ${#CONFS[@]} )); then
    while IFS= read -d $'\0' -r file ; do
        CONFS+=("$file")
    done < <(find home -maxdepth 1 -mindepth 1 -print0)
    if [ -d home.local ]; then
        while IFS= read -d $'\0' -r file ; do
            CONFS+=("$file")
        done < <(find home.local -maxdepth 1 -mindepth 1 -a \! \( -type d -a -name \.git \) -print0)
    fi
fi
echo installing: ${CONFS[*]}

link() {
    src="$1"
    dst="$2"
    type="unkown"
    if [[ -L "$dst" ]]; then
        if [[ -e "$dst" ]]; then
            type="link-good"
        else
            type="link-broken"
        fi
    elif [[ -d "$dst" ]]; then
        type="dir"
    elif [[ -f "$dst" ]]; then
        type="file"
    elif [[ ! -e "$dst" ]]; then
        type="noexist"
    fi
    if [[ "$type" = dir ]]; then
        echo "    [x] dont't link directory $dst"
    elif [[ "$type" = file ]]; then
        echo "    [x] $dst exist, please backup manually"
    elif [[ "$type" = "link-broken" ]]; then
        echo "    [v] linking $src to $dst"
        if [[ -z "$DRY_RUN" ]]; then
            ln -srf $src $dst
        fi
    elif [[ "$type" = "link-good" ]]; then
        if [[ `readlink -f "$dst"` = $src ]]; then
            # echo "    [.] pass $dst"
            :
        else
            echo "    [x] $dst links to others, not ${src}, please fix manually"
        fi
    elif [[ "$type" = noexist ]]; then
        echo "    [v] linking $src to $dst"
        if [[ -z "$DRY_RUN" ]]; then
            ln -sr $src $dst
        fi
    else
        echo unknown error
    fi
}

dirs=()
for conf in "${CONFS[@]}"; do
    while IFS= read -d $'\0' -r dir ; do
        dir=$(sed "s+^home\.local+home+g" <<< $dir)
        dir=$(sed "s+^home/+${HOME}/.+g" <<< $dir)
        if [[ ${#dirs[@]} -ge 1 && "$dir" =~ "${dirs[${#dirs[@]}-1]}" ]]; then
            unset 'dirs[${#dirs[@]}-1]'
        fi
        dirs+=($dir)
    done < <(find "$conf" -type d -print0)
done

files_src=()
files_dst=()
for conf in "${CONFS[@]}"; do
    while IFS= read -d $'\0' -r file ; do
        files_src+=($(realpath "$file"))
        file=$(sed "s+^home\.local+home+g" <<< $file)
        file=$(sed "s+^home/+${HOME}/.+g" <<< $file)
        files_dst+=($file)
    done < <(find "$conf" -type f -print0)
done

echo creating dir:
for dir in "${dirs[@]}"; do
    if [[ -d "${dir}" ]]; then
        echo "    [.] ${dir}"
    else
        if [[ -z "$DRY_RUN" ]]; then
            mkdir -p "${dir}"
        fi
        if [[ -d "${dir}" ]]; then
            echo "    [v] ${dir}"
        else
            echo "    [x] ${dir}"
        fi
    fi
done

echo linking:
for index in ${!files_src[*]}; do
    link "${files_src[$index]}" "${files_dst[$index]}"
done
