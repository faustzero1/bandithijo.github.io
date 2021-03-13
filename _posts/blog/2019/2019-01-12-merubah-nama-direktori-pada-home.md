---
layout: 'post'
title: 'Merubah Nama-nama Direktori pada Home'
date: 2019-01-12 08:40
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips']
pin:
hot:
contributors: []
description: "Apabila kamu merasa nama-nama direktori yang kamu miliki di Home terlalu panjang, seperti Documents, Desktop, Pictures, Vidoes, Sound, dll. Kita dapat merubahnya menjadi lebih singkat. Saya lebih senang dengan 3 huruf."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="#" onerror="imgError(this);" alt="banner"> -->

# Prakata

Mungkin teman-teman melihat struktur direktori home milik saya, yang hanya mengandung 3 huruf.

```
/home/bandithijo/
 tree -d -L 1
.
├── app
├── asp
├── bin -> .local/bin
├── box
├── dex
├── doc
├── dwn
├── git
├── mnt
├── nbp
├── pix
├── pkt
├── prj
├── pub
├── snd
├── thm
├── tpl
├── vbx
└── vid
```

Sepintas bentuk penamaan seperti di atas, hampir sama dengan penamaan pada direktori root.

Saya memang membuat penamaan pada direktori home ini menjadi lebih singkat. Minimal 3 huruf bahkan kalau bisa hanya 3 huruf.

Apabila sejak awal teman-teman sudah memiliki File Manager seperti Thunar, PCManFM, Nautilus, dll. Saya rasa nama dari direktori-direktori di Home akan tertulis secara lengkap. Kemudian apabila kita coba menggantinya (me-*rename*) maka akan terbuat direktori baru dengan nama awal.

Lantas bagaimana caranya untuk membuat *custom name* pada direktori-direktori ini?

# Caranya

Mudah sekali.

Tinggal buka Terminal, dan edit file `~/.config/user-dirs.dirs`.

{% shell_user %}
vim ~/.config/user-dirs.dirs
{% endshell_user %}

{% highlight_caption $HOME/.config/user-dirs.dirs %}
{% highlight sh linenos %}
# This file is written by xdg-user-dirs-update
# If you want to change or add directories, just edit the line you're
# interested in. All local changes will be retained on the next run
# Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
# homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
# absolute path. No other format is supported.
#
XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="$HOME/Download"
XDG_TEMPLATES_DIR="$HOME/Templates"
XDG_PUBLICSHARE_DIR="$HOME/Public"
XDG_DOCUMENTS_DIR="$HOME/Documents"
XDG_MUSIC_DIR="$HOME/Music"
XDG_PICTURES_DIR="$HOME/Pictures"
XDG_VIDEOS_DIR="$HOME/Videos"
{% endhighlight %}

Nah, tinggal ubah nama direktori sesuai dengan yang teman-teman inginkan.

Kalau punya saya seperti ini.

{% highlight_caption $HOME/.config/user-dirs.dirs %}
{% highlight sh linenos %}
# This file is written by xdg-user-dirs-update
# If you want to change or add directories, just edit the line you're
# interested in. All local changes will be retained on the next run
# Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
# homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
# absolute path. No other format is supported.
#
XDG_DESKTOP_DIR="$HOME/dex"
XDG_DOWNLOAD_DIR="$HOME/dwn"
XDG_TEMPLATES_DIR="$HOME/tpl"
XDG_PUBLICSHARE_DIR="$HOME/pub"
XDG_DOCUMENTS_DIR="$HOME/doc"
XDG_MUSIC_DIR="$HOME/snd"
XDG_PICTURES_DIR="$HOME/pic"
XDG_VIDEOS_DIR="$HOME/vid"
{% endhighlight %}

Setelah itu jalankan perintah.

{% shell_user %}
xdg-user-dirs-update
{% endshell_user %}

Kemudian jangan lupa untuk merubah <mark><b>Destination</b></mark> direktori dari semua aplikasi secara manual satu persatu. Kalau tidak, akan berantakan semuanya. Hahaha.


# Referensi

1. [wiki.archlinux.org/index.php/XDG_user_directories](https://wiki.archlinux.org/index.php/XDG_user_directories){:target="_blank"}
<br>Diakses tanggal: 2019/01/12

