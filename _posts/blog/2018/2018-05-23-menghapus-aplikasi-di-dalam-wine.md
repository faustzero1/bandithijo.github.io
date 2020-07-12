---
layout: 'post'
title: 'Menghapus Aplikasi di dalam Wine'
date: 2018-05-23 09:59
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Wine', 'Tips']
pin:
hot:
contributors: []
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://s20.postimg.cc/7t1qi5utp/banner_post_14.png" onerror="imgError(this);" alt="banner">

# Pendahuluan

Saya termasuk tipe pengguna GNU/Linux yang sering mencoba memasang aplikasi Microsoft Windows di sistem GNU/Linux menggunakan Wine.

Sejauh ini aplikasi Microsoft Windows yang berhasil saya pasang dan saya masih gunakan untuk produktifitas saya sehari-hari adalah,

1. Line Messenger (Naver Line)
2. WinBox (MikroTik)
3. Macromedia Flash 8 Pro (Macromedia)

Line, terpaksa saya pasang karena teman-teman kuliah saya masih menggunakan aplikasi ini. Winbox saya gunakan untuk konfigurasi MikroTik. Macromedia Flash 8, belum saya gunakan untuk apa-apa, baru saya gunakan sekali untuk mengerjakan tugas "[Design Challenge](https://bandithijo.com/blog/menjalankan-macromedia-flash-8-linux){:target="_blank"}".

# Permasalahan

Terkadang kita ingin mengujicoba apakah aplikasi yang kita maksud dapat berjalan dengan lancar di sistem operasi GNU/Linux yang kita miliki saat ini. Namun, setelah dipasang, kita bingung bagaimana cara menghapusnya. Apakah cukup menghapus direktori program tersebut yang terdapat pada "Program Files" atau harus menjalankan *tool* **Uninstall Program** seperti yang terdapat pada Microsoft Windows.

# Solusi

Caranya sangat mudah, kita dapat menggunakan aplikasi GUI bantuan untuk meng-uninstall aplikasi-aplikasi yang kita pasang di Wine.

Buka Terminal dan ketikkan,
```
$ wine uninstaller
```

Berikut saya sertakan ilustrasinya.

![gambar1]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/b3uovt4zx/gambar_01.gif" onerror="imgError(this);"}{:class="myImg"}

Gimana? Sangat mudah sekali bukan?

# Referensi

1. [wiki.winehq.org/Uninstaller](https://wiki.winehq.org/Uninstaller){:target="_blank"}
<br>Diakses tanggal: 2018/05/23
