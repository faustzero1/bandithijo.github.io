---
layout: 'post'
title: 'Instal dan Konfigurasi WinBox pada GNU/Linux'
date: 2018-04-24 00:59
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tools', 'Wine']
pin:
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="https://s20.postimg.cc/402x64szx/banner_post_05.png" alt="banner">

# Latar Belakang

Semester ini saya mengikuti mata kuliah **Sekuriti Jaringan**. Pada salah satu pembahasan, terdapat praktik membuat dan mengkonfigurasi VPN (*Virtual Private Network*). Perangkat yang digunakan adalah perangkat dari **MikroTik** yang membutuhkan aplikasi **WinBox** untuk mempermudah proses konfigurasi. Dapat lebih memudahkan karena konfigurasi dilakukan dengan menggunakan GUI (*Graphical User Interface*).

![gambar1](https://s20.postimg.cc/54wzb42hp/gambar_01.png)
<p class="img-caption">Gambar 1 - User Interface dari WinBox</p>

# Permasalahan

**Mikrotik** hanya menyediakan **WinBox** untuk sistem operasi Microsoft Windows -- yaa, sudah dapat ditebak dari namanya.

Saya sendiri mengenal Mikrotik dan WinBox baru sejak tahun 2015, di awal masa perkuliahan saya. Saat artikel ini ditulis WinBox sudah mencapai versi **3.13** dan masih belum terdapat versi GNU/Linux -- kalaupun ada mungkin akan bernama LinBox.

Tapi jangan khawatir, file **.exe** WinBox dapat dengan mudah kita pasang pada distribusi sistem operasi GNU/Linux apa saja.

# Prasyarat

Kita membutuhkan bantuan aplikasi [**Wine**](https://www.archlinux.org/packages/multilib/x86_64/wine/){:target="_blank"} untuk menjalankan aplikasi WinBox.

Proses instalasi Wine dapat merujuk pada distribusi sistem operasi GNU/Linux masing-masing. Atau cari saja di Google, sudah banyak teman-teman blogger yang mendokumentasikannya. Sangat mudah dan tidak ribet.

# Penerapan

## Instalasi Wine

Untuk distribusi Arch Linux.
```
$ sudo pacman -S wine wine_gecko wine-mono
```

`wine_gecko` dan `wine-mono` diperlukan untuk aplikasi yang membutuhkan Internet Explorer dan .NET. Sebenarnya paket ini tidak benar-benar harus dipasang karena Wine secara pintar akan mengunduh paket-paket yang relevan sesuai dengan kebutuhan. Namun apabila kamu memasangnya lebih dulu akan lebih menguntungkan apabila nantinya kamu tidak mendapatkan akses internet saat proses instalasi aplikasi Microsoft Windows di atas Wine.

Untuk kebutuhan dokumentasi ini (instalasi WinBox), hanya sejauh ini saja yang diperlukan. Namun untuk konfigurasi lebih lanjut tentang Wine dapat merujuk pada Arch Wiki, [di sini](https://wiki.archlinux.org/index.php/wine){:target="_blank"}.

## Instalasi WinBox

Terlebih dahulu kalian harus mengunduh WinBox installer pada situs *official* MikroTik [di sini](https://mikrotik.com/download){:target="_blank"}.

![gambar2](https://s20.postimg.cc/h82aymvjh/gambar_02.png)

Klik tombol **WinBox** untuk mengunduh file **.exe** pada versi paling baru. Setelah proses unduh selesai, letakkan WinBox pada direktori dimana kamu mudah untuk mengaksesnya. Saya biasa mengelompokkan file instalasi pada direktori tersendiri. Sebagai contoh seperti ini `~/app/winbox/`.
```
home
└── bandithijo
    └── app
        └── winbox
            └── winbox.exe
```

Nah, file `winbox.exe` ini bukan merupakan file paket instalasi, namun merupakan file launcher untuk menjalan WinBox. Sehingga tidak diperlukan proses instalasi. Saya kurang begitu mengerti istilahnya, mudah-mudahan kalian mengerti yang saya maksudkan. Hoho.

Lakukan pengetesan untuk menguji apakah WinBox dapat berjalan di atas Wine.

Buka **Terminal** dan pergi ke direktori tempat dimana file `winbox.exe` kalian simpan. Kemudian jalankan *command* di bawah.
```
$ wine winbox.exe
```
Apabila berhasil, akan menampilkan jendela WinBox seperti di bawah.

![gambar3](https://s20.postimg.cc/5ms4r57jx/gambar_03.png)

Untuk pertama kali, karena belum pernah digunakan, *text input* **Connect To:** belum akan terisi MAC address apapun.

Selanjutnya tinggal membuat *launcher* atau *shortcut* untuk memanggil WinBox dari menu aplikasi.

Buat file `winbox.desktop` pada direktori `~/.local/share/applications/`

```
$ touch ~/.local/share/applications/winbox.desktop
```

Kemudian, buka dengan text editor favorit kalian, dan isikan seperti contoh di bawah.

```
#!/usr/bin/env xdg-open
[Desktop Entry]
Name=Linbox
Exec=wine /home/bandithijo/app/winbox/winbox.exe
Type=Application
StartupNotify=true
Icon=winbox
Comment=Mikrotik RouterOS GUI Configurator (wine)
```

Perhatikan pada bagian `Exec=`. Kalian perlu mengganti lokasi dari `winbox.exe` sesuai dengan direktori dimana kalian menyimpan file `winbox.exe`.

Dengan demikian proses instalasi dan konfigurasi WinBox pada GNU/Linux saya rasa cukup seperti ini saja.

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Apabila kita akan melakukan konfigurasi Router MikroTik yang sudah di <b>Reset Configuration</b>, biasanya akan <b>sangat lama sekali</b> untuk mendapatkan MAC Address.</p>
<br>
<p><b>Solusi 1</b>:</p>
<p>Sementara hanya melakukan scan Mac Address berulang-ulang sampai WinBox mendapatkan MAC Address. Hahahaha sedih =(</p>
<br>
<p><b>Solusi 2</b>:</p>
<p>Meminjam laptop teman yang memiliki sistem operasi Windows dan melakukan konfigurasi kecil, atau meload file konfigurasi kita. Setelah file konfigurasi berhasil di *load* baru kita cabut dan kita pindahkan ke laptop kita. Hahaha sedih =(</p>
<br>
<p><b>Solusi 3</b>:</p>
<p><img src="/assets/img/logo/logo_blank.png" data-echo="https://i.postimg.cc/zf8KN0zy/komentar-01.png"></p>
</div>

# Video Sample

{% youtube 2DVKiNiCiI8 %}

# Referensi

1. [https://wiki.archlinux.org/index.php/wine](https://wiki.archlinux.org/index.php/wine){:target="_blank"}
<br>Diakses tanggal: 2018/04/24

