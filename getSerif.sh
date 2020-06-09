#!/bin/bash
function main() {
    ls serif_page > /dev/null 2>&1 || {
        echo "Err: pagedir doesn't exist." 1>&2 && return 1
    }
    for i in serif_page/*
    do
        echo "Now: ${i}"
        sed -r '1,/セリフ部分をタップすると記事ページに移動します。/d
                s/\t//g' "${i}"     | tr -d \\n |
        grep -oP '(?<=>)[^<]+(?=<)' | sed \$\ d | grep -v '該当する不審者情報は未登録です'
    done
}
main
exit $?