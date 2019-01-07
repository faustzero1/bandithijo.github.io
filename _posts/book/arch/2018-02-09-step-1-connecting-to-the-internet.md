---
layout: 'post'
title: 'Step 1: Connecting to the Internet'
date: 2018-02-09 02:00
permalink: '/arch/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'arch'
tags:
pin:
---


# STEP 1 : Connecting to the Internet

## 1.1 Pilih Network Adapter

Meskipun instalasi Arch Linux ini berupa _command line_, namun kita tetap dapat menggunakan _wifi adapter_ untuk terhubung dengan jaringan. \(apabila _wifi adapter_ kalian terdeteksi\). Lakukan pengecekan dengan perintah di bawah.

```
# wifi-menu
```

Apabila keluar menu interaktif berupa daftar SSID yang tersedia, maka pilih SSID milik kalian dan masukkan _password_ dari SSID. Apabila hanya keluar pesan berupa `--help`,
```
*output dari wifi-menu
```
menandakan _wifi adapter_ kalian belum terdeteksi oleh _kernel driver_ Arch _Installer_. Pada kasus ini kita masih dapat menggunakan koneksi dari kabel LAN ataupun dengan menggunakan _USB tethering smarpthone_.

Untuk penggunaan _USB tethering smartphone_, hubungkan _smartphone_ dengan laptop menggunakan kabel _USB_, lakukan pengecekan apakah sudah terhubung atau belum.

```
# lsusb
```

```
Bus 001 Device 004: ID 138a:0017 Validity Sensors, Inc.
Bus 001 Device 003: ID 04f2:b52c Chicony Electronics Co., Ltd
```

```
# dhcpcd
```

Setelah itu akan muncul pemberitahuan seperti di bawah.

```
dev: loaded udev
no interfaces have a carrier
forked to background, child pid 342
```

Lakukan pengetesan apakah kita telah terhubung ke Internet,

```
# ping google.com
```

Dalam langkah ini, kalian mungkin perlu menunggu beberapa saat hingga `ping` dapat berhasil, mungkin sekitar 1 - 2 menit.
Apabila telah berhasil, kalian dapat bergerak ke _step_ selanjutnya.

Apabila masih belum dapat terhubung dengan Internet, maka proses instalasi akan terkendala pada saat akan men-_download_ paket-paket dari _mirror server_.

## 1.2 Memilih Mirrorlist

Karena _base package_ yang diperlukan untuk menjadikan sistem operasi seutuhnya harus kita unduh dari _server_ repositori, maka kita perlu memilih daftar _mirror server_. Tujuannya untuk mempercepat proses pengunduhan paket-paket aplikasi dari _server_ repositori.

> **Mengapa tidak menggunakan _mirror-mirror_ lokal Indonesia ?**
>
> Karena belum tentu apabila kita memilih _server_ repositori di Indonesia sudah pasti akan mendapatkan kecepatan yang maksimal. Maka biarkan program yang memilihkan untuk kita.

Buat _backup_ `mirrorlist` terlebih dahulu.

```
# cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
```

Kemudian kita akan menggunakan `rankmirrors` untuk memilih alamat _mirror_ mana yang paling cepat.

```
# rankmirrors -n 5 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
```

Proses ini akan memakan waktu ~~sebentar~~. Karena `rankmirrors` akan melakukan filter pada ratusan alamat _mirror server_ yang ada pada daftar _file_ `mirrorlist`.

Setelah selesai, maka daftar _server_ repositori yang tadinya ada banyak sekali, hanya akan terseleksi dan tersisa menjadi 5 _server_ paling cepat saja. Kalian dapat melihatnya dengan mengetikkan `$ cat /etc/pacman.d/mirrorlist`.

```
*output cat /etc/pacman.d/mirrorlis
```

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
Penggunaan <code>rankmirrors</code> sudah tidak direkomendasikan lagi oleh Arch Wiki.<br>
Saat ini sudah menggunakan <code>reflector</code>.
<br><br>
<pre>
# pacman -S reflector
# reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist</pre>
</div>


<!-- NEXT PREV BUTTON -->
<div class="post-nav">
<a class="btn-blue-l" href="/arch/step-0-introduction"><img style="width:20px;" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="/arch/"><img style="width:20px;" src="/assets/img/logo/logo_menu.png"></a>
<a class="btn-blue-r" href="/arch/step-2-disk-partitioning"><img style="width:20px;" src="/assets/img/logo/logo_an.png"></a>
</div>
