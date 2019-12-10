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
```
$ vim ~/.config/user-dirs.dirs
```
<pre>
# This file is written by xdg-user-dirs-update
# If you want to change or add directories, just edit the line you're
# interested in. All local changes will be retained on the next run
# Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
# homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
# absolute path. No other format is supported.
#
XDG_DESKTOP_DIR="$HOME/<mark>Desktop</mark>"
XDG_DOWNLOAD_DIR="$HOME/<mark>Download</mark>"
XDG_TEMPLATES_DIR="$HOME/<mark>Templates</mark>"
XDG_PUBLICSHARE_DIR="$HOME/<mark>Public</mark>"
XDG_DOCUMENTS_DIR="$HOME/<mark>Documents</mark>"
XDG_MUSIC_DIR="$HOME/<mark>Music</mark>"
XDG_PICTURES_DIR="$HOME/<mark>Pictures</mark>"
XDG_VIDEOS_DIR="$HOME/<mark>Videos</mark>"
</pre>
Nah, tinggal ubah nama direktori sesuai dengan yang teman-teman inginkan.

Setelah itu jalankan perintah.
```
$ xdg-user-dirs-update
```

Kemudian jangan lupa untuk merubah <mark><b>Destination</b></mark> direktori dari semua aplikasi secara manual satu persatu. Kalau tidak, akan berantakan semuanya. Hahaha.


# Referensi

1. [wiki.archlinux.org/index.php/XDG_user_directories](https://wiki.archlinux.org/index.php/XDG_user_directories){:target="_blank"}
<br>Diakses tanggal: 2019/01/12

