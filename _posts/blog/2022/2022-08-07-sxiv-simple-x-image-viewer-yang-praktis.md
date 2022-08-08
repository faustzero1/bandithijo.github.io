---
layout: 'post'
title: "sxiv, Simple X Image Viewer (sxiv) yang Praktis namun Powerfull"
date: 2022-08-07 15:53
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Ulasan']
pin:
hot:
contributors: []
description: "Simple or Small or Suckless, X Image Viewer (sxiv), adalah aplikasi image viewer yang sudah saya pergunakan sejak sekitar Maret 2019. Catatan ini adalah tentang review singkat dari sxiv dan kenapa saya memutuskan untuk migrasi ke nsxiv."
---

# Pendahuluan

Simple or Small or Suckless, X Image Viewer (sxiv), adalah aplikasi image preview yang sudah saya pergunakan sejak sekitar Maret 2019. Catatan ini adalah tentang review singkat dari sxiv dan kenapa saya memutuskan untuk migrasi ke nsxiv.

# Sedikit tentang sxiv

sxiv adalah abreviasi dari Simple X Image Viewer. Penampil gambar yang dibangun dengan bahasa C. Ringan dan mudah untuk menambahkan fitur dengan menggunakan bahasa scripting seperti: bash.

## Fitur-fitur

Fitur-fitur yang dimiliki oleh sxiv, antara lain:
1. Operasi image dasar, sepert: *zooming*, *panning*, *rotating*
1. Customizable key and mouse button mappings (dengan file config.h)
1. Thumbnail mode, untuk menampilkan semua gambar di dalam direktori dalam bentuk thumbnail
1. Cache thumbnail, untuk mempercepat proses re-loading gambar
1. Basic support untuk gambar-gambar dengan multi-frame
1. Play GIF animations
1. Menampilkan image information di statusbar

## Kelebihan

Kalau kelebihan dari sxiv (subjektif menurut saya):
1. Tampilan yang simple. Tidak ada *kitchenset*, seperti: toolbar dan buttons. Cocok digunakan pengguna Window Manager
1. Pengoperasian yang simple, dengan menggunakan keyboard shortcut
1. Kecepatan saat dipanggil (*startup*) yang "fantastis"
1. Kecepatan saat menampilkan gambar-gambar di mode thumbnails yang "bombastis"

## Kekurangan

Kalau kekurangan dari sxiv (subjektif menurut saya):
1. Kurang yang menggunakan, jadi belum terkenal di kalangan umum. Hihihi 😋

# Screenshots

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/3NZg3CYc/gambar-01.png" onerror="imgerror(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - sxiv with image mode</p>

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/y6hhhBcy/gambar-02.png" onerror="imgerror(this);"}{:class="myImg"}
<p class="img-caption">Gambar 2 - sxiv with thumbnail mode</p>

# Demo

## Rotation

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/SK0jtYp2/gambar-03.gif" onerror="imgerror(this);"}{:class="myImg"}
<p class="img-caption">Gambar 3 - sxiv with rotate left & right</p>

## Flipping

![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/5twjc9xP/gambar-04.gif" onerror="imgerror(this);"}{:class="myImg"}
<p class="img-caption">Gambar 4 - sxiv with flip vertical & horizontal</p>

## Zooming & Panning

![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/gjrY0GWb/gambar-05.gif" onerror="imgerror(this);"}{:class="myImg"}
<p class="img-caption">Gambar 5 - sxiv with zoom in & out</p>

![gambar_6]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/mkqTzKLz/gambar-06.gif" onerror="imgerror(this);"}{:class="myImg"}
<p class="img-caption">Gambar 6 - sxiv with zoom in movement, zoom level 100%, fit image to window</p>

## Navigation

![gambar_7]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/2Sdfr1ZB/gambar-07.gif" onerror="imgerror(this);"}{:class="myImg"}
<p class="img-caption">Gambar 7 - sxiv with navibation next & previous</p>

![gambar_8]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/7Lxr6q3t/gambar-08.gif" onerror="imgerror(this);"}{:class="myImg"}
<p class="img-caption">Gambar 8 - sxiv with navigation on thumbnails mode</p>

# Rekomendasi

Karena **sxiv** sudah tidak lagi dilanjutkan proses maintain and developing nya, maka saya rekomendasikan teman-teman untuk bermigrasi ke **nsxiv** yang merupakan fork project dari sxiv.

# Tips & Tricks

## 1. Modifikasi color & font dengan X resources

Dari `man nsxiv` pada section **configuration**, ada beberapa color & font properties yang dapat kita gunakan.

{% pre_url %}
window.background
       Color of the window background

window.foreground
       Color of the window foreground

bar.font
       Name of Xft bar font

bar.background
       Color of the bar background. Defaults to window.background

bar.foreground
       Color of the bar foreground. Defaults to window.foreground

mark.foreground
       Color of the mark foreground. Defaults to window.foreground
{% endpre_url %}

Untuk dapat menggunakannya pada Xresources, tambahkan awalan `Nsxiv.` (window class name).

Contoh,

```
Nsxiv.bar.font:          JetBrainsMono Nerd Font Bandit:pixelsize=17
Nsxiv.bar.background:    #005F87
Nsxiv.bar.foreground:    #D4D4D4
```

## 2. Open all images inside directory on Ranger

*Sedang dalam proses penulisan...*

# Pesan Penulis

Penggunaan lebih lanjut saya serahkan pada imajinasi dan kreatifitas teman-teman.

Terima kasih sudah mampir yaa.

# Referensi

1. [https://github.com/muennich/sxiv](https://github.com/muennich/sxiv){:target="_blank"}
<br>Diakses tanggal: 2022/08/07

1. [https://github.com/nsxiv/nsxiv](https://github.com/nsxiv/nsxiv){:target="_blank"}
<br>Diakses tanggal: 2022/08/07

1. [https://codeberg.org/nsxiv/nsxiv](https://codeberg.org/nsxiv/nsxiv){:target="_blank"}
<br>Diakses tanggal: 2022/08/07

1. [https://wiki.archlinux.org/title/Sxiv](https://wiki.archlinux.org/title/Sxiv){:target="_blank"}
<br>Diakses tanggal: 2022/08/07
