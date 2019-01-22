---
layout: 'post'
title: 'Upgrade Fedora 21 ke Fedora 22 dengan Fedup'
date: 2015-06-15
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Fedora']
pin:
---

<p class="notif-post">Post ini sudah tidak up to date !</p>

<img class="post-body-img" src="/assets/img/logo/logo_blank_banner.png" data-echo="https://4.bp.blogspot.com/-YjUgk-I-xV8/VXstgLAFV_I/AAAAAAAABpk/YFOiY8VCCt0/s1600/Default%2BHeader%2BTemplate%2BPost%2B19.jpg" alt="banner">

# Pendahuluan
Mei 26, 2015. Fedora 22 telah resmi dirilis. Ini pertama kali bagi saya melakukan _upgrade_ sistem operasi Fedora dengan menggunakan tool. Karena sebelumnya saya adalah pengguna Ubuntu. Dan _upgrade_ sistem operasi pada lingkungan Ubuntu benar-benar sangat mudah. Karena developer sudah menyediakan aplikasi GUI (_Graphic User Interface_).

Lain halnya dengan Fedora yang hanya menyediakan aplikasi berupa CLI (_Com-
mand Language Interface_), berupa `fedup`. Namun disinlah letak kelebihan Fedora dalam melakukan _upgrade_ sistem operasinya. Penggunaan _source_ RAM _memory_ menjadi lebih sedikit.

# Tujuan
_Upgrade_ Fedora 21 ke Fedora 22 dengan menggunakan aplikasi fedup.
Langkah ini saya nilai yang paling mudah karena tidak membutuhkan banyak pengaturan.

# Requirement
1. Fedora 21 yang telah terinstal pada sistem komputer anda
2. Koneksi internet yang memadai, karena kita akan melakukan _upgrade_ sistem ke Fedora 22 dengan mengambil _source_ dari _server_ Fedora di internet.
3. Terminal (sudah terdapat pada Fedora 21 secara default)
4. `fedup`, aplikasi yang disediakan oleh Fedora untuk memudahkan user dalam

# Batasan Tutorial
Tutorial ini ditujukan bagi user produk Apple atau dapat juga digunakan (apabila dimungkinkan) oleh user lain yang telah memiliki sistem operasi Fedora 21.
Untuk user sistem operasi Fedora 18/19/20, saya tidak dapat memberikan
rekomendasi karena saya belum menguji coba secara langsung di lapangan apakah tutorial ini dapat digunakan dengan baik.

# Langkah meng-Upgrade

## Update Sistem Fedora 21
Update sistem Fedora 21 dengan menggunakan Terminal dan ketik

```
$ sudo dnf update
$ sudo dnf distro-sync
```

Disarankan sebelum meng-upgrade OS ke Fedora 22, anda telah menggunakan versi kernel terbaru.
Kemudian setelah proses update selesai, silahkan restart komputer anda dan kembali ke desktop.

## Install fedup
Buka Terminal dan ketik
```
$ sudo dnf install fedup
```
Tunggu proses instalasi fedup hingga selesai.

## Hapus Repositori yang Bukan Resmi
Disarankan oleh wiki Fedora untuk menghapus repositori yang bukan resmi terlebih dahulu sebelum meng-upgrade. Namun pengalaman pribadi saya, repositori seperti rpmfusion tidak begitu menggangu. Dari sekian banyak repositori unofficial yang saya gunakan, repositori yang mengalami masalah saat proses upgrade berlangsung hanya fedy. Untuk itu saya perlu menghapus fedy.repo terlebih dahulu dari daftar repositori saya.

Untuk menghapus fedy.repo. Buka Terminal dan ketik
```
$ sudo rm /etc/yum.repos.d/fedy.repo
```

Untuk membackup sementara fedy.repo. Buka Terminal dan ketik
```
$ sudo mv /etc/yum.repos.d/fedy.repo /etc/yum.repos.d/fedy.repo.bak
```

## Upgrade Sistem ke Fedora 22
1. Pastikan koneksi internet anda aman dan lancar untuk meng-upgrade sistem operasi Fedora 22 untuk beberapa waktu kedepan. Karena proses upgrade ini memakan waktu lumayan lama untuk men-download dan meng-upgrade paket-paket yang telah ada dalam sistem Fedora 21 anda dari mirror Fedora.
2. Buka Terminal dan ketik
```
$ sudo fedup --network 22
```
tunggu proses download paket hingga selesai. Paket yang di-download bisa ribuan jumlahnya, milik saya hampir 2500 paket yang perlu saya download.
3. Apabila proses download paket telah selesai maka lanjutkan dengan restart atau reboot sistem anda.
```
$ reboot
```
pada tahap ini sistem anda akan restart / rebootdan akan terdapat progress bar proses instalasi paket-paket yang tadi sudah di-downloadsebelumnya. Ini akan memakan waktu cukup lama. Tunggu saja hingga proses selesai.
4. Setelah proses instalasi selesai, maka anda akan disuguhkan halaman login yang sudah berubah menjadi versi Fedora 22. Silahkan login ke account anda.
5. Selesai. Maka proses upgrade sistem operasi Fedora 22 pun telah berhasil.
