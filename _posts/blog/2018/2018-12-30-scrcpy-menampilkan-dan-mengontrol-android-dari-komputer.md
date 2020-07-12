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
tags: ['Tools', 'Tips', 'Ulasan']
pin:
hot: true
contributors: []
---

<!-- BANNER OF THE POST -->
<!-- <img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="#" onerror="imgError(this);" alt="banner"> -->

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

Lebih keren lagi, **Gratis** dan ***Open Sources***.

[**SCRCPY**](https://github.com/Genymobile/scrcpy){:target="_blank"}, adalah akronim dari *screen copy*, sebuah aplikasi yang dikembangkan oleh [**Genymobile**](https://www.genymobile.com){:target="_blank"} yang berfungsi untuk menampilkan dan mengontrol Android *device*. Dibangun menggunakan bahasa C, Java dan Meson. Berlisensi Apache 2.0.

Saat tulisan ini dibuat, Scrcpy sudah memasuki versi 1.5 di GitHub repository mereka.

Scrcpy menggunakan **adb** sebagai *backend* untuk dapat berkomunikasi dengan Android *smartphone* kita. Artinya kita memerlukan paket `adb` pada sistem kita.

# Proses Instalasi

Sejauh yang saya baca dari **README.md** yang ada pada repository GitHub dari Scrcpy, terdapat dua cara untuk memasang Scrcpy pada sistem kita.

1. Arch User Repository untuk Arch Linux
2. *Build* sendiri

## Arch Linux
Beruntung untuk teman-teman yang menggunakan distribusi Arch Linux karena sudah terdapat *user* yang memaintain paket Scrcpy di repository. Untuk Arch Linux terdapat pada [AUR/scrcpy](https://aur.archlinux.org/packages/scrcpy/){:target="_blank"}.

Tinggal pasang menggunakan AUR Helper favorit kalian.
```
$ yay scrcpy
```

## Build Sendiri

Silahkan dibuild sendiri mengikuti petunjuk yang ditulis langsung oleh developer pada halaman repository Scrcpy, [di sini](https://github.com/Genymobile/scrcpy/blob/master/BUILD.md){:target="_blank"}.


# Cara Penggunaan

Scrcpy dapat kita hubungkan dengan *smartphone* Android kita dengan dua cara, yaitu:
1. Kabel data
2. Wifi (*only on the same network*)

Praktis bukan?

Kita tidak perlu menambahkan aplikasi pada *smartphone* Android kita.

## Menggunakan Kabel Data

1. Hubungkan *smartphone* Android dengan laptop/komputer menggunakan kabel data.
2. Buka Terminal dan pastikan *smartphone* sudah terhubung dengan laptop/komputer.
```
$ lsusb
```
    <pre>
    Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
    Bus 001 Device 003: ID 04f2:b52c Chicony Electronics Co., Ltd
    <mark>Bus 001 Device 004: ID 05c6:9025 Qualcomm, Inc. Qualcomm HSUSB Device</mark>
    Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub</pre>
Dapat dilihat pada *output* dari `lsusb` di atas, *smartphone* saya sudah terdeteksi.
3. Buka Terminal dan jalankan perintah sederhana seperti di bawah.
```
$ scrcpy
```
```
* daemon not running; starting now at tcp:5037
* daemon started successfully
/usr/share/scrcpy/scrcpy-server.jar: 1 file pushed. 2.1 MB/s (19178 bytes in 0.009s)
INFO: Initial texture: 1080x1920
```
Apabila `adb` belum pernah di jalankan maka perintah di atas akan memanggil dan menjalankan `adb` sekaligus menjalankan `scrcpy`.

    Pada saat ini, akan muncul *window* baru yang akan menampilkan tampilan dari layar *smartphone* Andorid kita.
    <!-- IMAGE CAPTION -->
    ![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/Ls6GBwK5/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}
    <p class="img-caption">Gambar 1 - Scrcpy saat dijalankan</p>

## Menggunakan Wifi

Untuk menghubungkan *smartphone* Android dengan laptop/komputer menggukanan konektifitas Wifi, syaratnya adalah <mark><i>smartphone</i> kita harus berada pada <i>network</i>/jaringan yang sama dengan laptop/komputer kita</mark>.

1. Langkah pertama, kita harus mengetahui **IP address** yang dimilii oleh *smartphone* kita. Langkah paling mudah menurut saya, buka menu **Settings → About Phone → Status**.
    <!-- IMAGE CAPTION -->
    ![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/wxZHxqKV/gambar-02.jpg" onerror="imgError(this);"}{:class="myImg"}
    <p class="img-caption">Gambar 2 - Melihat IP address dari smartphone</p>
    Dapat dilihat pada gambar di atas, area yang saya kotak merah adalah IP address yang dimiliki oleh *smartphone*.

    Untuk memeriksa apakah *smartphone* dan laptop kita berada pada *network* yang sama, periksa juga IP address dari laptop.
    ```
    $ ip a s
    ```
    <pre>
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
        valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host
        valid_lft forever preferred_lft forever
    2: enp0s31f6: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN group default qlen 1000
        link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
    3: wlp4s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
        link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
        inet <mark>192.168.1.4</mark>/24 brd 192.168.1.255 scope global dynamic noprefixroute wlp4s0
        valid_lft 81406sec preferred_lft 81406sec
        inet6 fxxx::xxxx:fxxx:xxxx:xxxx/64 scope link noprefixroute
        valid_lft forever preferred_lft forever
    </pre>
    Hasil:
    ```
    Smartphone: 192.168.1.2
    Laptop    : 192.168.1.4
    ```
    Kesimpulannya, laptop dan *smartphone* berada pada *network* yang sama, yaitu *network* `192.168.1.0/24`.
2. Buka Terminal dan jalankan perintah di bawah untuk mengaktifkan `adb` over TCP/IP pada *smartphone* kita.
```
$ adb tcpip 5555
```
3. Lepaskan kabel data.
4. Sekarang, coba hubungkan laptop dengan *smartphone* Android kita dengan perintah di bawah.
    <pre>
    $ adb connect <mark>192.168.1.2</mark>:5555</pre>
    Ganti IP address dengan yang IP address dari *smartphone* yang kalian miliki.

    Apabila berhasil,
    ```
    connected to 192.168.1.2:5555
    ```
5. Jalankan Scrcpy seperti biasa.
```
$ scrcpy
```

    <!-- PERHATIAN -->
    <div class="blockquote-red">
    <div class="blockquote-red-title">[ ! ] Perhatian</div>
    <p>Sangat diperlukan untuk <b>melepaskan kabel data</b> terlebih dahulu sebelum menjalankan perintah <code>scrcpy</code>.</p>
    <p>Apabila tidak dilepas, akan muncul pesan <i>error</i> seperti di bawah.</p>
    <pre>
    adb: error: failed to get feature set: more than one device/emulator
    ERROR: "adb push" returned with value 1</pre>
    </div>

    <!-- INFORMATION -->
    <div class="blockquote-blue">
    <div class="blockquote-blue-title">[ i ] Informasi</div>
    <p>Untuk <i>option</i> dan <i>properties</i> lebih tambahan seperti menurunkan <i>bit-rate</i> dan <i>definition</i>, dapat dilihat pada file <a href="https://github.com/Genymobile/scrcpy" target="_blank"><b>README.md</b></a> pada <i>resource</i> GitHub dari Scrcpy.</p>
    </div>

# Keyboard Shortcuts

*Tabel di bawah saya sunting langsung dari file README.md yang ada di repository GitHub dari Scrcpy, [di sini](https://github.com/Genymobile/scrcpy#shortcuts){:target="_blank"}*.

 | Action                                 |   Shortcut                    |
 | -------------------------------------- |:----------------------------  |
 | switch fullscreen mode                 | <kbd>Ctrl</kbd>+<kbd>f</kbd>                    |
 | resize window to 1:1 (pixel-perfect)   | <kbd>Ctrl</kbd>+<kbd>g</kbd>                    |
 | resize window to remove black borders  | <kbd>Ctrl</kbd>+<kbd>x</kbd> \| _Double-click¹_ |
 | click on <kbd>HOME</kbd>               | <kbd>Ctrl</kbd>+<kbd>h</kbd> \| _Middle-click_  |
 | click on <kbd>BACK</kbd>               | <kbd>Ctrl</kbd>+<kbd>b</kbd> \| _Right-click²_  |
 | click on <kbd>APP_SWITCH</kbd>         | <kbd>Ctrl</kbd>+<kbd>s</kbd>                    |
 | click on <kbd>MENU</kbd>               | <kbd>Ctrl</kbd>+<kbd>m</kbd>                    |
 | click on <kbd>VOLUME_UP</kbd>          | <kbd>Ctrl</kbd>+<kbd>↑</kbd>  (<kbd>Cmd</kbd>+<kbd>↑</kbd> on MacOS) |
 | click on <kbd>VOLUME_DOWN</kbd>        | <kbd>Ctrl</kbd>+<kbd>↓</kbd>  (<kbd>Cmd</kbd>+<kbd>↓</kbd> on MacOS) |
 | click on <kbd>POWER</kbd>              | <kbd>Ctrl</kbd>+<kbd>p</kbd>                    |
 | turn screen on                         | _Right-click²_                |
 | paste computer clipboard to device     | <kbd>Ctrl</kbd>+<kbd>v</kbd>                    |
 | enable/disable FPS counter (on stdout) | <kbd>Ctrl</kbd>+<kbd>i</kbd>                    |

*¹Double-click on black borders to remove them.*

*²Right-click turns the screen on if it was off, presses BACK otherwise.*

# Sekilas Penggunaan

{% youtube Pn_YhMWnZVE %}

# Pesan Penulis

Masih banyak fitur-fitur dari Scrcpy yang belum sempat saya tuliskan di sini. Silahkan bereksplorasi lebih dalam dan lebih jauh, merujuk pada daftar referensi yang saya sertakan di bawah.


# Referensi

1. [github.com/Genymobile/scrcpy](https://github.com/Genymobile/scrcpy){:target="_blank"}
<br>Diakses tanggal: 2018/12/30

2. [blog.rom1v.com/2018/03/introducing-scrcpy/](https://blog.rom1v.com/2018/03/introducing-scrcpy/){:target="_blank"}
<br>Diakses tanggal: 2018/12/30

3. [www.genymotion.com/blog/open-source-project-scrcpy-now-works-wirelessly/](https://www.genymotion.com/blog/open-source-project-scrcpy-now-works-wirelessly/){:target="_blank"}
<br>Diakses tanggal: 2018/12/30

4. [wiki.archlinux.org/index.php/Android_Debug_Bridge](https://wiki.archlinux.org/index.php/Android_Debug_Bridge){:target="_blank"}
<br>Diakses tanggal: 2018/12/30

