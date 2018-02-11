#!/bin/sh
dirs=`find home -type d | sed 1d | sed 's/^home\///g'`
for dir in $dirs; do
    mkdir -p $HOME/.$dir
done
files=`find home -type f`
for file in $files; do
    src=`pwd`/$file
    dst=$HOME/.`echo $file | sed 's/^home\///g'`
    echo linking $src to $dst
    broken=`find $dst -type l -exec sh -c "file -b {} | grep -q ^broken" \; -print 2>/dev/null`
    if [ -n "$broken" ] ; then
        ln -sf $src $dst
    else
        ln -s $src $dst
    fi
done

if [ -d home.local ]; then
    dirs=`find home.local -type d | sed 1d | sed 's/^home\.local\///g'`
    for dir in $dirs; do
        mkdir -p $HOME/.$dir
    done
    files=`find home.local -type f`
    for file in $files; do
        src=`pwd`/$file
        dst=$HOME/.`echo $file | sed 's/^home\.local\///g'`
        echo linking $src to $dst
        broken=`find $dst -type l -exec sh -c "file -b {} | grep -q ^broken" \; -print 2>/dev/null`
        if [ -n "$broken" ] ; then
            ln -sf $src $dst
        else
            ln -s $src $dst
        fi
    done
fi
