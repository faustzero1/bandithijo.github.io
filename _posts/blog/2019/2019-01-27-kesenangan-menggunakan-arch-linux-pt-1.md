---
layout: 'post'
title: 'Kesenangan Dalam Menggunakan Arch Linux Pt. 1'
date: 2019-01-27 08:56
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc:
category: 'blog'
tags: ['Arch Linux', 'Ulasan']
pin:
hot:
contributors: []
resume: "Pada catatan ini saya sedikit bercerita kemudahan dalam menelusuri sebuah paket di repositori Arch Linux."
---

<!-- banner of the post -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

<hr>
Arch Linux, distribusi sistem operasi GNU/Linux yang sudah saya pergunakan sejak pertengahan 2016 hingga hari ini.

Salah satu kesenangan menggunakan distribusi Arch adalah kemudahan dalam hal menelusuri paket di repository.

Beberapa waktu lalu `dunstify` masih terdapat di AUR, namun begitu sudah di merge dari upstream, repo `dunst` official pun ikut membawa `dunstify`.

<!-- IMAGE CAPTION -->
![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/Jn5zQgJW/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Kemudahan mengecek paket pada archlinux.org</p>

<hr>
Untuk mengecek apakah `dunstify` sudah terdapat pada paket `dunst`, kita dapat menggunakan perintah.

{% shell_user %}
sudo pacman -Ql dunst
{% endshell_user %}

<!-- IMAGE CAPTION -->
![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/ydHNcBDP/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 2 - Kemduahan mengecek paket pada pacman</p>

Karena `dunstify` sudah terdapat pada paket `dunst`, saya harus menghapus paket `dunstify` yang saya pasang melalui AUR.

{% shell_user %}
sudo pacman -R dunsitfy
{% endshell_user %}
Lalu melakukan instalasi kembali paket `dunst` untuk memperbaharui `dunst`, gunanya agar perintah `/bin/dunstify` dibuat kembali.

{% shell_user %}
sudo pacman -S dunst
{% endshell_user %}

<hr>
Saya menggunakan `dunstify` untuk keperluan menampilkan **HELP** dari daftar keyboard shortcut pada masing-masing aplikasi yang saya pergunakan.
<!-- IMAGE CAPTION -->
![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/gjcktDqL/gambar-03.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 3 - Salah satu pemanfaatan dunstify</p>

Kapan-kapan akan saya tuliskan mengenai "Pemanfaatan **dunstify** untuk menjadi fitur **HELP**" seperti yang saya pergunakan ini.
<!-- text-align:center -->

<hr>
Sesuai janji, saya sudah menuliskan catatan mengenai hal ini, [di sini]({{ site.url }}/blog/dunst-sebagai-notifikasi-bantuan-pengingat-shortcut).

# Referensi

1. [twitter.com/bandithijo/status/1088634885286199296](https://twitter.com/bandithijo/status/1088634885286199296){:target="_blank"}
<br>Diakses tanggal: 2019/01/27

2. [twitter.com/bandithijo/status/1088636816498905088](https://twitter.com/bandithijo/status/1088636816498905088){:target="_blank"}
<br>Diakses tanggal: 2019/01/27

3. [twitter.com/bandithijo/status/1088639007368474624](https://twitter.com/bandithijo/status/1088639007368474624){:target="_blank"}
<br>Diakses tanggal: 2019/01/27

4. [wiki.archlinux.org/index.php/Dunst](https://wiki.archlinux.org/index.php/Dunst){:target="_blank"}
<br>Diakses tanggal: 2019/01/27

