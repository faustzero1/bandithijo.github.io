---
layout: 'post'
title: 'Kesenangan Dalam Menggunakan Arch Linux Pt. 1 <span class="new">BARU</span>'
date: 2019-01-27 08:56
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc:
category: 'blog'
tags: ['Arch Linux', 'Ulasan']
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

<hr>
Arch Linux, distribusi sistem operasi GNU/Linux yang sudah saya pergunakan sejak pertengahan 2016 hingga hari ini.

Salah satu kesenangan menggunakan distribusi Arch adalah kemudahan dalam hal menelusuri paket di repository.

Beberapa waktu lalu 'dunstify' masih terdapat di AUR, namun begitu sudah di merge dari upstream, repo 'dunst' official pun ikut membawa 'dunstify'.

<!-- IMAGE CAPTION -->
![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/Jn5zQgJW/gambar-01.png"}
<p class="img-caption">Gambar 1 - Kemudahan mengecek paket pada archlinux.org</p>

<hr>
Untuk mengecek apakah `dunstify` sudah terdapat pada paket `dunst`, kita dapat menggunakan perintah.
```
$ sudo pacman -Ql dunst
```
<!-- IMAGE CAPTION -->
![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/ydHNcBDP/gambar-02.png"}
<p class="img-caption">Gambar 2 - Kemduahan mengecek paket pada pacman</p>

Karena `dunstify` sudah terdapat pada paket `dunst`, saya harus menguninstal paket `dunstify` yang saya pasang melalui AUR.
```
$ sudo pacman -R dunsitfy
```
Lalu melakukan instalasi kembali paket `dunst` untuk memperbaharui `dunst`, gunanya agar perintah `/bin/dunstify` dibuat kembali.
```
$ sudo pacman -S dunst
```

<hr>
Saya menggunakan 'dunstify' untuk keperluan menampilkan 'HELP' dari daftar keyboard shortcut pada masing-masing aplikasi yang saya pergunakan.
<!-- IMAGE CAPTION -->
![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/gjcktDqL/gambar-03.gif"}
<p class="img-caption">Gambar 3 - Salah satu pemanfaatan dunstify</p>


# Referensi

1. [twitter.com/bandithijo/status/1088634885286199296](https://twitter.com/bandithijo/status/1088634885286199296){:target="_blank"}
<br>Diakses tanggal: 2019/01/27

2. [twitter.com/bandithijo/status/1088636816498905088](https://twitter.com/bandithijo/status/1088636816498905088){:target="_blank"}
<br>Diakses tanggal: 2019/01/27

3. [twitter.com/bandithijo/status/1088639007368474624](https://twitter.com/bandithijo/status/1088639007368474624){:target="_blank"}
<br>Diakses tanggal: 2019/01/27

4. [wiki.archlinux.org/index.php/Dunst](https://wiki.archlinux.org/index.php/Dunst){:target="_blank"}
<br>Diakses tanggal: 2019/01/27

