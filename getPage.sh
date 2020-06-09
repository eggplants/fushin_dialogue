#!/bin/bash

function main() {
    local url d_name
    url='https://fushinsha-joho.co.jp/serif.cgi'
    d_name='serif_page'

    mkdir -p "${d_name}"
    echo "Now: ${d_name}"
    for i in $(
        curl -s "${url}" |
        grep -oP '(?<=<option value=")\d{6}(?=" )'
    )
    do
        echo "Now: ${i}"
        curl -s "${url}?ym=${i}" > "${d_name}/${i}.html" || {
            echo "Err: ${i}" 1>&2
            return 1
        }
    done
    return 0
}

main
exit $?
