#!/bin/bash
function main() {
    ls serif_page > /dev/null 2>&1 || {
        echo "Err: pagedir doesn't exist." 1>&2 && return 1
    }
    local save
    save='serif_all.csv'
    if [ -f "${save}" ]; then
        rm "${save}"
    else
        touch "${save}"
    fi
    for file in serif_page/*
    do
        echo "Now: ${file}"
        sed -r '1,/セリフ部分をタップすると記事ページに移動します。/d
                s/\t//g' "${file}"     | tr -d \\n |
        grep -oP '(?<=>)[^<]+(?=<)' | sed \$\ d | grep -v '該当する不審者情報は未登録です' |
        while true
        do
        read -r description
        read -r serif
        read -r place behave date
        [ -z "${description}" ] && break
        echo "${file},${description},${serif},${place},${behave},${date}" >> "${save}"
        done 
    done
}
main
exit $?
