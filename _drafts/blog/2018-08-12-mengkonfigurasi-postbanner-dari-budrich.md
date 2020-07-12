---
layout: 'post'
title: 'Mengkonfigurasi postbanner dari budRich'
date: 2018-08-12 10:43
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags:
pin:
hot:
contributors: []
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="#" onerror="imgError(this);" alt="banner">

# Permasalahan
Tulisan kali ini sebenarnya bukan konfigurasi secara langsung terkait dengan `postbanner`, namun lebih ke konfigurasi **Figlet Font** sebagai salah satu unsur yang diperlukan oleh `postbanner` dalam memproduksi tulisan.

# Instalasi

## Dependensi

Instal paket-paket di bawah yang menjadi dependensi `postbanner`.
1. `lolcat`
2. `toilet`
3. `ansi2html`

Apabila menggunakan distribusi Arch Linux,
```
$ sudo pacman -S lolcat python-ansi2html
```
```
$ aurman -S toilet
```

## Postbanner

Script dari `postbanner` dapat diunduh langsung dari [GitHub milik budRich](https://github.com/budRich/scripts/tree/master/budlabs/postbanner).
```
$ cd
$ wget -v https://raw.githubusercontent.com/budRich/scripts/master/budlabs/postbanner/postbanner
$ chmod +x postbanner
$ sudo mv postbanner /usr/bin/postbanner
```

# Referensi

1. [https://budrich.github.io/scripts/budlabs/postbanner/](https://budrich.github.io/scripts/budlabs/postbanner/)
<br>Diakses tanggal: 18/09/12

2. [https://github.com/xero/figlet-fonts](https://github.com/xero/figlet-fonts)
<br>Diakses tanggal: 18/09/12

