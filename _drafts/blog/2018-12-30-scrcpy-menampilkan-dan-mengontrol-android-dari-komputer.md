---
layout: 'post'
title: 'Scrcpy, Menampilkan dan Mengontrol Android Device dari Komputer'
date: 2018-12-30 10:41
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
<!-- <img class="post&#45;body&#45;img" src="#" alt="banner"> -->

# Latar Belakang Masalah

Mungkin pernah terlintas akan sangat praktis apabila kita dapat mengakses Android *smartphone* kita dari komputer/laptop?

Saya sudah merinci beberapa keperluan yang saya perlukan apabila terdapat aplikasi yang dapat menghubungkan kita dengan *smartphone*. Berikut ini adalah daftar rinciannya:

1. Melihat layar *smartphone* langsung dari laptop dan dapat berinteraksi, seperti menggerak-gerakkan menu dan mengetik
2. Terhubung dengan WiFi tanpa perlu kabel data
3. Tidak perlu menginstall aplikasi tambahan di *smartphone*
4. Tidak memerlukan akes root.
5. Transfer data *drag and drop*

Apakah ada aplikasi yang dapat melakukan hal seperti itu di GNU/Linux? Kalaupun ada pasti harganya mahal.

# Pemecahan Masalah

Jawabannya, **ada**.

Lebih keren lagi, **Gratis dan *Open Sources***.

[**SCRCPY**](https://github.com/Genymobile/scrcpy){:target="_blank"}, adalah aplikasi yang dikembangkan oleh [**Genymobile**](https://www.genymobile.com){:target="_blank"} yang berfungsi untuk menampilkan dan mengontrol Android *device*. Dibangun menggunakan bahasa C. Berlisensi Apache 2.0.

Saat tulisan ini dibuat, scrcpy sudah memasuki versi 1.5 di GitHub repository mereka.

Scrcpy menggunakan **adb** sebagai *backend* untuk dapat berkomunikasi dengan Android *smartphone* kita. Artinya kita memerlukan paket `adb` pada sistem kita.

# Proses Instalasi

Sejauh yang saya baca dari **README.md** yang ada pada repository GitHub dari scrcpy, terdapat dua cara untuk memasang scrcpy pada sistem kita.

1. Arch User Repository untuk Arch Linux
2. *Build* sendiri

## Arch Linux
Beruntung untuk teman-teman yang menggunakan distribusi Arch Linux karena sudah terdapat *user* yang memaintain paket scrcpy di repository. Untuk Arch Linux terdapat pada [AUR/scrcpy](https://aur.archlinux.org/packages/scrcpy/){:target="_blank"}.

Tinggal pasang menggunakan AUR Helper favorit kalian.
```
$ yay scrcpy
```

## Build Sendiri

<span class="font-latin">Sedang dalam proses penulisan...</span>

Atau,

Silahkan dibuild sendiri mengikuti petunjuk yang ditulis langsung oleh developer pada halaman repository Scrcpy, [di sini](https://github.com/Genymobile/scrcpy/blob/master/BUILD.md){:target="_blank"}.


# Referensi

1. [https://github.com/Genymobile/scrcpy](https://github.com/Genymobile/scrcpy){:target="_blank"}
<br>Diakses tanggal: 2018/12/30

2. [https://blog.rom1v.com/2018/03/introducing-scrcpy/](https://blog.rom1v.com/2018/03/introducing-scrcpy/){:target="_blank"}
<br>Diakses tanggal: 2018/12/30

3. [https://www.genymotion.com/blog/open-source-project-scrcpy-now-works-wirelessly/](https://www.genymotion.com/blog/open-source-project-scrcpy-now-works-wirelessly/){:target="_blank"}
<br>Diakses tanggal: 2018/12/30

4. [https://wiki.archlinux.org/index.php/Android_Debug_Bridge](https://wiki.archlinux.org/index.php/Android_Debug_Bridge){:target="_blank"}
<br>Diakses tanggal: 2018/12/30

