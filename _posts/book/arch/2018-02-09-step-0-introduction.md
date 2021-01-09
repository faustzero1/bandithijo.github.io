---
layout: 'post'
title: 'Step 0: Introduction'
date: 2018-02-09 01:00
permalink: '/arch/:title'
author: 'BanditHijo'
license: true
comments: false
toc: true
category: 'arch'
tags:
pin:
---

# Disclaimer

Perlu diingat bahwa saya sebagai penulis tidak bertanggung jawab atas kerusakan atapun kehilangan data maupun perangkat keras yang disebabkan karena proses instalasi yang merujuk pada dokumentasi ini.

Untuk itu, saya sangat merekomendasikan untuk terlebih dahulu mem-*backup* data-data pada _hard disk_ kalian.

# Limitation

Proses instalasi ini ditujukan untuk _**single boot**_ atau hanya satu sistem operasi yang disimpan oleh _hard disk_. Untuk konfigurasi _dual boot_, silahkan mencari dokumentasi yang lain dan dapat mengkombinasikan prosesnya dengan dokumentasi yang saya tulis.

Pada dokumentasi ini, penulis tidak menjelaskan bagaimana cara membuat _Bootable Flash Drive_ yang berisi Arch Linux _installer_. Proses ini dapat kalian cari sendiri pada dokumentasi-dokumentasi _online_ yang tersebar di Internet.

Proses dokumentasi ini juga penulis kerjakan pada mode _bios_ **UEFI**. Untuk teman-teman yang masih menggunakan mode _bios_ **Legacy**, sebaiknya mengubah konfigurasi _bios_ terlebih dahulu pada komputer/laptop masing-masing.

Keterbatasan lain akan saya jabarkan pada STEP 0 : Introduction.


# Step 0: Introduction

Hello mas Bro, nama saya **Rizqi Nur Assyaufi**. Beberapa dari teman-teman mungkin sudah mengetahui bahwa saya adalah seorang Archer \(mungkin sebutan keren untuk pengguna Arch Linux\).

Sedikit cerita, saya sudah menggunakan sistem operasi GNU/Linux secara aktif baru dimulai sejak tahun 2014. Sebelumnya, sejak tahun 2009 saya menggunakan sistem operasi besutan Apple, yang dikenal dengan nama OS X, namun kini disebut dengan nama macOS \(denger-denger supaya lebih konvergen dengan iOS\).

Pertama kali mengenal sistem operasi GNU/Linux sejak tahun 2004 melalui sahabat saya yang juga teman berdiskusi soal teknologi \(**Yudo D. Baskoro**\). Beliaulah yang memperkenalkan saya mengenai distribusi sistem operasi GNU/Linux yang bernama Ubuntu dari Canonical. Dari situlah awal mula tanpa saya sadari sedikit demi sedikit saya mulai belajar bermigrasi dari satu sistem operasi ke sistem operasi yang lain.

Tujuan awal saya menulis petunjuk manual instalasi Arch Linux ini adalah untuk mempermudah saya dalam melakukan _reinstall_ \(instalasi kembali\) apabila sewaktu-waktu saya mengalami kendala atau kegagalan pada sistem yang saya pergunakan saat ini.

Belajar dari pengalaman menggunakan distribusi sistem operasi yang saya gunakan sebelumnya, yaitu Fedora Linux. Proses _reinstall_ menjadi lebih cepat dan lebih terarah apabila saya mengikuti dokumentasi yang telah saya buat sebelumnya. Karena proses _research_ \(mencari informasi\) yang valid sudah dipangkas. Bayangkan untuk memasang sebuah sistem operasi, kita harus mencari informasi mengenai apa saja paket-paket yang kita perlukan dan yang sistem operasi perlukan. Mulai dari sumber-sumber _official_, sampai tulisan-tulisan dokumentasi pribadi Arch *user* yang lain. Benar0benar menyita waktu.

Berdasarkan latar belakang kasus saya di atas, saya kembali mengumpulkan niat, tenaga, dan menyisihkan waktu luang untuk kembali menulis dokumentasi proses instalasi ini.

Dokumentasi ini saya tulis berdasarkan Arch Wiki dan catatan kaki hasil proses instalasi berulang-ulang yang saya lakukan sebelumnya. Saya menambahkan langkah-langkah untuk melindungi data-data yang ada di dalam partisi `root` dan direktori `home` user dengan proses enkripsi agar tidak sembarangan orang dapat mengaksesnya.

Keterbatasan dari dokumentasi ini dapat dilihat pada tabel di bawah.

Spesifikasi mesin yang saya gunakan :

| <center>No.</center> | <center>Hardware</center> | <center>Details</center> |
| :--- | :--- | :--- |
| 1 | CPU | Intel\(R\) Core\(TM\) i5-6300U CPU @ 2.40GHz |
| 2 | GPU | Intel HD Graphics 520 |
| 3 | Wireless Interface | Intel Corporation Wireless 8260 |
| ... | dst... | dst... |

Yang ingin saya informasikan dari tabel spesifikasi di atas adalah, saya tidak menggunakan GPU Nvidia maupun Radeon. Bahkan belum pernah sama sekali melakukan _setup_ pada mesin dengan GPU Nvidia maupun Radeon. Dan inilah keterbatasan dari dokumentasi yang saya tulis. Saya tidak dapat menyertakan proses instalasi _driver_ untuk kedua GPU tersebut. Dan juga untuk _processor_ dengan _brand_ AMD.

Selain itu, saya juga tidak menggunakan Arch Linux berdampingan dengan Microsoft Windows (*dual boot*). Sehingga proses manajemen partisi untuk *dual boot* tidak terdapat pada dokumentasi ini.

Hal lain yang sering dihadapi oleh GNU/Linux _user_ adalah kompatibilitas _wifi adapter_. Permasalahan ini paling sering saya temukan baik di forum maupun di chat group, karena beberapa _brand_ membutuhkan konfigurasi _driver_ yang belum terkonfigurasi atau bahkan belum tersedia pada _base_ sistem. Beberapa distribusi sistem operasi GNU/Linux mungkin sudah ada yang menyertakan pada _base_ sistem mereka, namun lain halnya dengan Arch Linux, dimana user yang harus mencari sendiri bagaimana mengkonfigurasi _network adapter_ yang tidak tersedia pada _base_ sistem Arch. Ini salah satu alasan kenapa Arch Linux tidak ditujukan untuk _user_ yang baru mengenal GNU/Linux.

**Gimana, Bro ? Masih berani untuk lanjut ?**

~~Mungkin~~ di sinilah yang menjadi _level_ awal dimana calon Archer diseleksi. Yaitu pada proses instalasi yang tidak semudah distribusi sistem operasi GNU/Linux yang lain.

Bagi teman-teman yang sudah menggunakan distribusi sistem operasi GNU/Linux selain Arch Linux, saya rasa tidak akan begitu kesulitan. Namun, bagi teman-teman yang baru bermigrasi dari sistem operasi Microsoft Windows, saya lebih merekomendasikan untuk menggunakan distribusi turunan dari Arch Linux dan memang lebih mudah proses instalasinya karena menggunakan GUI \(_Graphical User Interface_\) yaitu **Manjaro Linux**.

Kalo boleh saya gambarkan, proses instalasi distribusi sistem operasi Arch Linux ini seperti merakit kapal. Kita bebas menentukan apa saja yang kita perlukan, bagaimana proses pembuatan dan seperti apa bentuk kapal yang kita inginkan, agar kapal yang kita rakit, dapat berlayar. Ya, meskipun saya juga belum pernah merakit kapal sebelumnya, biar terlihat keren saja pakai kata “kapal”. Hehehe

Target yang akan kita capai dari dokumentasi ini adalah :

| <center>Items</center> | <center>Details</center> |
| :--- | :--- |
| **Sistem Operasi** | Arch Linux |
| **Dual Boot** | No \(Single Boot\) |
| **Desktop Environment** | GNOME |
| **Partition Table** | /dev/sda1 → ESP \(EFI System Partition\) |
|  | /dev/sda2 → Linux LVM with LUKS encryption |
| **Bootloader** | systemd-boot |
| **Encryption** | /dev/sda =&gt; root & /home |


<!-- NEXT PREV BUTTON -->
{% assign btn-next = "" %}
{% assign btn-menu = "/arch/" %}
{% assign btn-prev = "/arch/step-1-connecting-to-the-internet" %}
<div class="post-nav">
<a class="btn-blue-l disabled" href="{{ btn-next }}"><img class="btn-img" src="/assets/img/logo/logo_ap.png"></a>
<a class="btn-blue-c" href="{{ btn-menu }}"><img class="btn-img" src="/assets/img/logo/logo_menu.svg"></a>
<a class="btn-blue-r" href="{{ btn-prev }}"><img class="btn-img" src="/assets/img/logo/logo_an.png"></a>
</div>
