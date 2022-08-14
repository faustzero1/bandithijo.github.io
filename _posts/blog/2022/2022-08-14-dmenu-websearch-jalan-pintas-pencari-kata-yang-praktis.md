---
layout: 'post'
title: "dmenu-websearch, Jalan Pintas Pencari Kata yang Praktis"
date: 2022-08-14 08:47
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Script']
pin:
hot:
contributors: []
description: "dmenu-websearch ini saya buat karena kemalasan saya dalam melakukan pencarian kata/frasa tertentu namun harus membuka website terkait. Tidak praktis. Saya ingin kata/frasa tersebut cukup saya inputkan dari menu di desktop kemudian browser akan menuntun saya ke halaman hasil pencarian di website terkait."
---

# Pendahuluan

dmenu-websearch ini saya buat karena kemalasan saya dalam melakukan pencarian kata/frasa tertentu namun harus membuka website terkait. Tidak praktis. Saya ingin kata/frasa tersebut cukup saya inputkan dari menu di desktop kemudian browser akan menuntun saya ke halaman hasil pencarian di website terkait.

# Fitur-fitur

dmenu-websearch ini memiliki fitur:
1. mencari kata/frasa dari target website yang sudah didefinisikan di dalam file urlquery
1. menambahkan target urlquery baru
1. menghapus target urlquery yang ada (konfirmasi sebelum dihapus)

# Snippet Code

## dmenu-websearch script (Bash)

Simpan file `dmenu-websearch` di PATH direktori.

{% highlight_caption ~/.local/bin/dmenu-websearch %}
{% highlight shell linenos %}
#!/bin/bash

# Released under MIT License

# Copyright (C) 2021 Rizqi Nur Assyaufi <bandithijo@gmail.com>

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Deps:
# - dmenu
# - jq

MENU="dmenu"

FILE="$HOME/.urlquery"

if [ ! -f $FILE ]; then
    cp urlquery.example $HOME/.urlquery
fi

FILEOPT=$(cat $FILE)

OPTIONS="
[
${FILEOPT}
[ \"Add:New:Query\", \"\" ],
[ \"Delete:Query\",  \"\" ]
]
"

OBJ_LENGTH=$(echo $OPTIONS | jq length)
OBJ_MENU=$(echo $OPTIONS | jq -r ".[][0]" | $MENU -i -p " WebSearch:")
OBJ_SELECTED=$(echo $OBJ_MENU | cut -d' ' -f1)
OBJ_KEYWORDS=$(echo $OBJ_MENU | cut -d' ' -f2- | tr " " "+")

add_query() {
    PREFIXMENU=$(echo "" | dmenu -p "Add prefix menu:" <&-)
    if [ ! -z $PREFIXMENU ]; then
        URLQUERY=$(echo "" | dmenu -p "Add url query:" <&-)
        echo "[ \"$PREFIXMENU\", \"$URLQUERY\" ]," >> $FILE
    fi
    exit
}

delete_query() {
    OBJ_MENU=$(echo $OPTIONS | jq -r ".[][0]" | head -n -2 | $MENU -i -p "Delete Menu:")
    OBJ_SELECTED=$OBJ_MENU
    if [ ! -z $OBJ_SELECTED ]; then
        CONFIRM_DELETE=$(echo -e "no\nyes" | dmenu -p "Do you want to delete this url?")
        if [ $CONFIRM_DELETE = "yes" ]; then
            sed -i "/$OBJ_SELECTED/d" $FILE
        fi
    fi
    exit
}

main() {
    for i in $(seq 0 $((OBJ_LENGTH - 1))); do
        if [ $OBJ_SELECTED = "Add:New:Query" ]; then
            add_query
        fi

        if [ $OBJ_SELECTED = "Delete:Query" ]; then
            delete_query
        fi

        if [ $OBJ_SELECTED = $(echo $OPTIONS | jq -r --arg i $i '.[($i|tonumber)][0]') ]; then
            URLQUERY=$(echo $OPTIONS | jq -r --arg i $i '.[($i|tonumber)][1]')
            KEYWORDS=$(echo $OBJ_KEYWORDS)
            xdg-open "${URLQUERY}${KEYWORDS}" 2> /dev/null
        fi
    done
}

main
{% endhighlight %}

## urlquery (plaintext)

Simpan file `.urlquery` di HOME direktori.

{% highlight_caption ~/.urlquery %}
{% highlight shell linenos %}
[ "Arch:Manpage", "https://man.archlinux.org/search?q=" ],
[ "Arch:Wiki", "https://wiki.archlinux.org/index.php?search=" ],
[ "Arch:Packages", "https://archlinux.org/packages/?q=" ],
[ "Arch:Packages:AUR", "https://aur.archlinux.org/packages/?K=" ],
[ "DuckDuckGo:Search", "https://duckduckgo.com/?q=" ],
[ "GitHub:Search", "https://github.com/search?q=" ],
[ "Google:Search", "https://duckduckgo.com/?q=!g+" ],
[ "Google:Search:Image", "https://duckduckgo.com/?q=!gi+" ],
[ "Google:Translate", "https://translate.google.com/?sl=auto&tl=id&text=" ],
[ "Ruby:Gems", "https://rubygems.org/search?query=" ],
[ "Ruby:Toolbox", "https://www.ruby-toolbox.com/search?q=" ],
[ "Ruby:LibHunt", "https://ruby.libhunt.com/search?query=" ],
[ "Twitter:Search", "https://twitter.com/search?q=" ],
[ "Youtube:Search", "https://www.youtube.com/results?search_query=" ],
[ "Twitch:Search", "https://www.twitch.tv/search?term=" ],
[ "NPM:Search", "https://www.npmjs.com/search?q=" ],
{% endhighlight %}

# Pesan Penulis

Penggunaan lebih lanjut saya serahkan pada imajinasi dan kreatifitas teman-teman.

Terima kasih sudah mampir yaa.

# Referensi

1. [http://kb.mozillazine.org/Using_keyword_searches](http://kb.mozillazine.org/Using_keyword_searches){:target="_blank"}
<br>Diakses tanggal: 2022/08/14

1. [https://github.com/bandithijo/dmenu-websearch](https://github.com/bandithijo/dmenu-websearch){:target="_blank"}
<br>Diakses tanggal: 2022/08/14
