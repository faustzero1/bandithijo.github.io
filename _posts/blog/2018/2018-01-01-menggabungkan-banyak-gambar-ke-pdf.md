---
layout: 'post'
title: 'Menggabungkan Banyak Gambar Menjadi Satu PDF dengan ImageMagick'
date: 2018-01-01 03:20:58 +0800
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tools', 'Tips']
pin:
---

<img class="post-body-img" src="https://4.bp.blogspot.com/-vjyMAweQN0s/WmK8err6iRI/AAAAAAAAG6c/xqNj-dLuKkUFH9eJnVNnMQ-fRPneyYxJACLcBGAs/s1600/Default%2BHeader%2BTemplate%2BPost%2B2X.png" alt="banner">

# Latar Belakang
_Scanning_ berlembar-lembar dokumen dalam bentuk gambar dan harus menggabungkannya menjadi satu _bundle file_ PDF, apakah bisa dilakukan GNU/Linux ?

Tentu saja bisa, bahkan sangat mudah, hanya dengan satu baris _command line_. Gak perlu pakai GUI, udah jadul. Loh Hahahaha

# Prasyarat
Kita memerlukan paket bernama [ImageMagick](https://www.archlinux.org/packages/extra/x86_64/imagemagick/){:target="_blank"}, untuk teman-teman yang menggunakan distribusi selain Arch Linux, dapat mencarinya pada _official distro_ masing-masing. Namun, saya rasa, paket `imagemagick` biasanya sudah terpasang secara default pada distro-distro modern, karena paket ini biasanya juga merupakan dependensi dari paket-paket yang lain.

# Penerapan
Langkah pertama adalah mengumpulkan gambar-gambar hasil scan yang akan di bundle ke dalam satu buah folder / direktori. Buat saja satu folder / direktori baru dan beri nama apa saja.

Selanjutnya, buka Terminal dan masuk ke dalam direktori yang sudah kita buat dan berisi gambar-gambar hasil _scan_.

Langkah selajutnya tinggal menjalankan perintah `convert`,

```
$ convert * namafile.pdf
```

Ganti namafile dengan nama file yang kamu inginkan

Arti dari tanda bintang (`*`) adalah semua file yang ada di dalam direktori tersebut, kemudian diikuti nama file. Tunggu prosesnya hingga selesai.

# Referensi
1. [archlinux.org/packages/extra/x86_64/imagemagick/](https://www.archlinux.org/packages/extra/x86_64/imagemagick/){:target="_blank"}
<br>Diakses tanggal: 2018/01/20
