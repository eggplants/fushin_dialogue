#!/bin/bash
function main() {
    ls dialogue_page > /dev/null 2>&1 || {
        echo "Err: pagedir doesn't exist." 1>&2 && return 1
    }
    local save
    save='dialogue_all.csv'
    if [ -f "${save}" ]; then
        rm "${save}"
    else
        touch "${save}"
    fi
    for file in dialogue_page/*
    do
        echo "Now: ${file}"
        sed -r '1,/セリフ部分をタップすると記事ページに移動します。/d
                s/\t//g' "${file}"     | tr -d \\n |
        grep -oP '(?<=>)[^<]+(?=<)' | sed \$\ d | grep -v '該当する不審者情報は未登録です' |
        ruby -e'
        f = []
        `dd`.split(?\n).each{if scan(/「|\//)}
        ' > "${save}"
    done
}
main
exit $?
