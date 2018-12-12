---
layout: 'post'
title: 'Mendapatkan Info Update Artikel Terbaru Website/Blog dengan Newsboat'
date: 2018-12-12 06:44
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags:
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="" alt="banner"> -->

# Prakata

Setelah sejak 2015, di rumah saya sudah di pasang akses internet, saya mulai konstan untuk menjelajah berbagai macam informasi. Terkadang ada beberapa website menarik yang selalu saya ikuti. Saya selalu kunjungi setiap hari. Terntu saja saya memanfaatkan fitur **bookmark** yang ada pada *browser*.

Semakin lama, jumlah website yang saya kunjungi semakin banyak, dan sangat melelahkan membuka website tersebut satu-persatu. Terkadang saya datang, namun tidak terdapat informasi terbaru (biasanya pada blog/news). Misalkan ada 10 saja website favorit yang ingin kita kunjungi satu per satu, namun sayangnya tidak dari semuanya sudah memiliki artikel baru. Tidak efisien bukan? Bayangkan bila 10, 20, 50 website favorite yang harus kita kunjungi.

# Pemecahan Masalah

Kita dapat menggunakan fitur **RSS** (*RDF Site Summary*/*Rich Site Summary*/*Really Simple Syndication*). RSS adalah salah satu tipe dari web feed yang memungkinkan pengguna untuk mendapatkan akses dari update konten online. Dengan menggunakan RSS reader kita akan dengan mudah mendapatkan artikel terbaru dari website yang kita *list*.

# Instalasi

Kita membutuhkan aplikasi RSS feed reader untuk mengumpulkan semua daftar RSS dari website yang kita favoritkan.

Aplikasi yang saya rekomendasikan adalah [`newsboat`](){:target="_blank"}. Newsboat adalah aplikasi yang berjalan di atas Terminal.

1. Pasang aplikasi `newsboat`.
```
$ sudo pacman -S newsboat
```
Sesuaikan dengan distribusi sistem operasi GNU/Linux masing-masing.

2. Karena aplikasi ini berjalan di atas Terminal dan belum tersedia aplikasi pemanggilnya, kita perlu membuatnya secara manual.
```
$ vim .local/share/applications/newsboat.desktop
```
```
[Desktop Entry]
Name=newsboat
Comment=Newsbeuter is an open-source RSS/Atom feed reader for text terminals.
Exec=urxvt -e newsboat
Icon=liferea
Terminal=false
Type=Application
StartupNotify=true
Categories=Network;News;
Keywords=news;feed;aggregator;blog;podcast;
```
Pada bagian `Exec=`, (harus) dapat menggati `urxvt` dengan Terminal emulator yang teman-teman gunakan, misal: `gnome-terminal`, `xfce4-terminal`, `termite`, `konsole`, dan lain sebagainya.


# Mengapa Memilih Newsboat?

**Kenapa saya memilih menggunakan Newsboat?**

*Resource* yang kecil. Meskipun laptop saya i5, 8 GB of RAM, 480 GB of SSD, tapi menggunakan aplikasi di atas Terminal apabila semua tujuan kita sudah tercapai, maka sudah lebih dari cukup.

Saya sudah pernah menggunakan RSS feed reader tipe web apps, yaitu **Commafeed**. Sudah juga menggunakan GTK+ apps yaitu **Liferea**. Sehingga saat menemukan newsboat, saya suda mengetahui apa-apa kebutuhan yang saya perlukan dari sebuah RSS feed reader.


# Referensi

1. [https://en.wikipedia.org/wiki/RSS](https://en.wikipedia.org/wiki/RSS){:target="_blank"}
<br>Diakses tanggal: 2018/12/12

2. [](){:target="_blank"}
<br>Diakses tanggal: 2018/12/12

3. [](){:target="_blank"}
<br>Diakses tanggal: 2018/12/11
