---
layout: 'post'
title: 'Unified Remote, Mengontrol Mouse Cursor GNU/Linux dari Android <span class="new">BARU</span>'
date: 2019-01-14 19:35
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

# Prakata

Setelah pada postingan sebelumnya, saya menuliskan tentang "[Bagaimana Mengrontrol Android Device dari Komputer]({{ site.url }}/blog/scrcpy-menampilkan-dan-mengontrol-android-dari-komputer){:target="_blank"}". Sekarang saya akan mereview aplikasi yang mempunyai fungsi kebalikan dari **scrcpy**, yaitu mengontrol komputer dari Android.

**Unified Remote**, adalah aplikasi yang saya gunakan untuk membuat Android *smartphone* saya menjadi *remote control*. Seperti tagline dari Unified Remote, "*Turn your smartphone into a universal remote control*".

Unified Remote pada Google PlayStore memiliki dua versi, yaitu:
1. **Free** - dengan *fungsi-fungsi yang terbatas*
2. **Full** - dengan fungsi-fungsi yang sudah sudah dibuka, untuk mendapatkan versi Full, kita hanya perlu melakukan pembayaran sekali saja (bukan sistem *subscribe* per bulan atau per tahun)

Untuk perbedaan fungsi-fungsi (fitur) antara versi Free dan Full, dapat di lihat [di sini - Features](https://www.unifiedremote.com/features){:target="_blank"}.

Hal lain yang perlu diperhatikan dari aplikasi remote seperti ini adalah "**konektifitas**". Unified Remote mendukung 2 tipe konektifitas, **Wifi/Data** dan **Bluetooth**.

Apabila di rumah, saya menggunakan konektifitas wifi karena berada dalam satu network. Sedangkan di luar rumah, saya menggunakan konektifitas bluetooth. Nah karena konektifitas bluetooth inilah yang menyebabkan saya sebaiknya menuliskan dokumentasi pribadi, karena cara untuk menghubungkannya terbilang tidak biasa (baca: ~~ribet~~).

# Instalasi

Sebelum memasuki proses instalasi, ada hal yang harus saya jelaskan terlebih dahulu.

Karena aplikasi ini bersifat *remote*, tentunya akan ada 2 hal yang akan kita bahas, yaitu: *client* dan *server*.

Dalam hal ini,
1. Komputer/laptop akan bertindak sebagai server, yang nanti akan kita jalankan aplikasi **Unified Remote Server** yang kita unduh dari website.
2. Android *smartphone* akan bertindak sebagai client, yang akan kita pasangkan aplikasi **Unified Remote** dari Google PlayStore.

Oke, sekarang proses instalasi.

## Instalasi Unified Remote Server

1. Dari komputer/laptop, buka browser favorit dan pergi ke *official* website Unified Remote pada halaman ini: [unifiedremote.com/download](https://www.unifiedremote.com/download){:target="_blank"}
2. Pilih untuk Desktop GNU/Linux
3. Pilih **Other distros**, pilih yang **Portable Archive (64-bit)**, atau langsung saja saya berikan link nya: [Portable Archive (64-bit)](https://www.unifiedremote.com/download/linux-x64-portable){:target="_blank"}
    <!-- PERTANYAAN -->
    <div class="blockquote-yellow">
    <div class="blockquote-yellow-title">Distro saya ada di dalam tipe paket yang di sediakan. Sebaiknya saya pilih yang mana ?</div>
    <p>Kalau saya, tentu saja akan tetap memilih <b>Portable Archive</b>. Mumpung ada yang menunjukkan cara instalasinya. Kenapa tidak sekalian dimanfaatkan untuk belajar.</p>
    </div>
4. Pindahkan ke direktori khusus tempat kalian menyimpan aplikasi-aplikasi. Misalnya seperti saya, selalu mengumpulkan aplikasi yang saya build sendiri pada direktori `~/app/` dan buat direktori khusus untuk Unified Remote.
    Contohnya seperti ini,
    <pre>
~/app/
    └── unifiedremote
        └── <mark>urserver-3.6.0.745.tar.gz</mark></pre>
5. Selanjutnya ekstraksi isi dari paket `urserver-x.x.x.xxx.tar.gz` tersebut
```
$ tar -xvf urserver-3.6.0.745.tar.gz
```
Nanti akan terbuat sebuah direktori dengan nama `urserver-3.6.0.745`
    <pre>
~/app/
    └── unifiedremote
        ├── <mark>urserver-3.6.0.745</mark>
        └── urserver-3.6.0.745.tar.gz</pre>
Nah, Unified Remote server sudah ada di dalam direktori `urserver-3.6.0.745` tersebut dengan nama `urserver`, namun jangan dulu dijalankan, karena kita perlu melakukan beberapa konfigurasi koneksi untuk Wifi dan Bluetooth.

## Konfigurasi Koneksi

Konfigurasi Koneksi akan terbagi menjadi 2 bagian, Wifi/Data dan Bluetooth.

### Koneksi dengan Wifi/Data

Untuk konfigurasi menggunakan Wifi/Data pada komputer/laptop kita tidak diperlukan konfigurasi apapun. Asalkan komputer/laptop dan Android *smartphone* kita berada pada satu network yang sama (LAN), maka tidak akan terjadi masalah.

Saya mencurigai bahwa Unified Remote ini juga dapat digunakan jarak jauh di luar LAN, namun belum saya pelajari lebih lanjut.

### Koneksi dengan Bluetooth

Bagian konektifitas menggunakan bluetooth adalah bagian yang menjadi alasan saya menuliskan dokumentasi ini.

Ada beberapa hal yang perlu dipersiapkan sebelum kita dapat menggunakan konektifitas bluetooth dengan Unified Remote.

1. Edit file `/etc/systemd/system/dbus-org.bluez.service`
```
$ sudo vim /etc/systemd/system/dbus-org.bluez.service
```
    <pre>
[Unit]
...
...
[Service]
Type=dbus
BusName=org.bluez
ExecStart=/usr/lib/bluetooth/bluetoothd <mark>--compat</mark>
...
...
[Install]
...
...</pre>
Pada `ExecStart=` tambahkan `--compat` seperti contoh di atas.


# Referensi

1. [unifiedremote.com/tutorials](https://www.unifiedremote.com/tutorials){:target="_blank"}
<br>Diakses tanggal: 2019/01/14

2. [unifiedremote.com/features](https://www.unifiedremote.com/features){:target="_blank"}
<br>Diakses tanggal: 2019/01/14
