#!/bin/bash
function main() {
    ls dialogue_page > /dev/null 2>&1 || {
        echo "Err: pagedir doesn't exist." 1>&2 && return 1
    }
    local save
    save='dialogue_all.csv'
    echo 'Filename,Description,Dialogue,Place,Category,Date' > "${save}"
    for file in dialogue_page/*
    do
        echo "Now: ${file}"
        sed -r '1,/セリフ部分をタップすると記事ページに移動します。/d
                s/\t//g' "${file}"     | tr -d \\n |
        grep -oP '(?<=>)[^<]+(?=<)' | sed \$\ d | grep -v '該当する不審者情報は未登録です' |
        ruby -e'
        n = $*[0]
        f = ["", "", ""]
        `dd`.split(?\n).each{
            f[0] = _1 unless _1 =~ /[\/「」]/
            f[1] = _1 if _1 =~ /[「」]/
            f[2] = _1.split.join(?,) if _1 =~ /\d{4}\/\d{2}\/\d{2}/
            unless f[2].empty?
                puts n + ?, + f.join(?,)
                f = ["", "", ""]
            end
        }
        ' "$(basename ${file})" >> "${save}"
    done
}
main
exit $?
