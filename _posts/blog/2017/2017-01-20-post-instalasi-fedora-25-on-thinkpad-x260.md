---
layout: 'post'
title: 'Setelah Memasang Fedora 25 pada ThinkPad x260'
date: 2017-01-20
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags:
pin:
---

<p class="notif-post">Post ini sudah tidak up to date !</p>

<img class="post-body-img" src="https://2.bp.blogspot.com/-x_2guEqX7Gc/WINOrVRgocI/AAAAAAAAEI0/bWUuprh3yaI4c_Z755uTIfZqsMKnx-2XgCLcB/s1600/Default%2BHeader%2BTemplate%2BPost%2B22.png" alt="banner">

# Latar Belakang
Sudah banyak yang membuat artikel semacam ini, “Apa yang dilakukan setelah menginstal Ubuntu, Linux Mint, Fedora, Debian, Kali Linux, Arch Linux” di Internet. Pada artikel kali ini saya akan membuat hal yang sama. Sebenarnya artikel ini lebih baik saya sebut sebagai “dokumentasi”.

# Hal-hal Teknis
Saya melakukan instalasi sistem operasi Fedora 25 Workstation pada notebook Lenovo Thinkpad x260. Yang ternyata tidak ada kendala pada dukungan _hardware_. Berikut adalah tabel keterangannya.

| HARDWARE | KETERANGAN |
| --- | --- |
| **Buttons**  | |
| Keyboard Shortcut | Volume Control, Brightnes Control, Display Switch, semua **berfungsi dengan baik** tanpa perlu dikonfigurasi |
| Trackpoint | **Berfungsi dengan baik** tanpa perlu dikonfigurasi |
| Trackpad | **Berfungsi dengan baik** tanpa perlu dikonfigurasi |
| **Adapter** | |
| Wireless Adapter | **Berfungsi dengan baik** tanpa perlu dikonfigurasi |
| Bluetooth Adapter | **Berfungsi dengan baik** tanpa perlu dikonfigurasi |
| **Cards** | |
| Intel Graphic Card | **Berfungsi dengan baik** tanpa perlu dikonfigurasi |
| Sound Card | **Berfungsi dengan baik** tanpa perlu dikonfigurasi |
| **Ports** | |
| HDMI Port | **Berfungsi dengan baik** tanpa perlu dikonfigurasi |
| Mini Display Port | **Berfungsi dengan baik** tanpa perlu dikonfigurasi |
| 3x USB 3.0 | **Berfungsi dengan baik** tanpa perlu dikonfigurasi |
| **Others** | |
| Fingerprint Scanner | **Berfungsi dengan baik** tanpa perlu dikonfigurasi |

# Step by Step
## Konektifitas ke Internet
Seperti yang teman-teman ketahui, kita membutuhkan akses ke Internet agar dapat mengunduh aplikasi yang akan kita tambahkan ke dalam sistem operasi Fedora 25 Workstation dari repositori.

## Lakukan Update Keseluruhan Sistem Operasi
Setelah anda memastikan bahwa masalah konektifitas ke internet tidak terdapat kendala, langkah selanjutnya adalah melakukan _update_ keseluruhan sistem operasi. Karena sistem operasi yang telah kita _install_ menggunakan `.iso` _image_ tentu telah mengalami update sejak `.iso` itu dipasang di situs resminya. Oleh karenanya kita perlu untuk melakukan _update_ keseluruhan aplikasi pada sistem operasi menjadi versi terakhir. Dengan cara _copy paste_ kode perintah di bawah ke Terminal.
```
$ sudo dnf update
```
Saya menyarankan untuk `reboot` sistem setelah proses `update` ini selesai.

## Menambahkan Repository RPM Fussion
Kita membutuhkan tambahan repository dari pihak ketiga dengan tujuan memperkaya daftar aplikasi yang dapat kita gunakan pada sistem operasi kita.
```
$ su -c 'dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'
```
Sumber : [https://rpmfusion.org/Configuration](https://rpmfusion.org/Configuration){:target="_blank"}

Jangan lupa, _update_ sistem kembali setelah menambahkan RPM Fusion repositori.
```
$ sudo dnf update
```

## Instalasi Media Codec
Fedora tidak langsung dapat memutar musik berformat `.mp3`, `.wav` atau memutar video berformat `.mp4`, `.flv`, `.mkv`, dll, untuk itu kita perlu menginstal _plugin_ / _codec_ untuk multimedia agar dapat diputar pada multimedia _player_ di Fedora kita.

Buka Terminal dan _copy paste_ kode perintah di bawah.
```
$ su -c 'dnf install gstreamer1-plugins-ugly gstreamer1-plugins-bad-freeworld gstreamer1-libav gstreamer-plugin-crystalhd gstreamer1-vaapi gstreamer1-plugins-bad-free gstreamer1-plugins-good'
```

## Menambahkan Program Applikasi yang Saya Biasa Gunakan
Berikut ini adalah daftar program aplikasi yang biasa saya gunakan untuk mendukung pekerjaan dan aktifitas berkomputasi saya sehari-hari.

| APLIKASI | KETERANGAN |
| --- | --- |
| GIMP | GNU Image Manipulation Program, Photoshop alternative |
| Inkscape | Vector based drawing program, CorelDraw alternative |
| Thunderbird | Email Client from Mozilla |
| Blender | Professional free and open-source 3D software |
| Brasero | Free disc-burning program for Unix-like systems |
| GColor2 | Color selector to provide a quick and easy way to find colors |
| Geany | Fast and lightweight IDE using GTK+ |
| gThumb | Image viewer, editor, organizer |
| Shutter | Shutter is a GTK+2 based screenshot application written in Perl |
| HexChat | A popular and easy to use graphical IRC (Chat) client |
| Kdenlive | Non linear video editor |
| Alacarte | Menu editor for the GNOME desktop |
| SoundConverter | Simple sound converter for GNOME desktop |
| Audacity | Multitrack audio editor |
| SimpleScreenRecorder | Screen recorder for linux |
| Transmission | A lightweight GTK+ BitTorrent client |
| CoreBird | Native GTK Twitter client |
| VLC | The crossplatform open source multimedia player |
| Wine | A compatibility layer for Windows applications |
| Winetricks | Work around common problems in Wine |
| Yumex | Yum extender graphical package management tool |
| Zeal | Offline documentation browser inspired by Dash |
| Gnome Tweak Tool | A tool to customize advanced GNOME 3 options |
| Unar | Multi-format extractor |

Untuk memasangnya buka Terminal dan _copy paste_ kode perintah di bawah ini.
```
$ sudo dnf install gimp inkscape thunderbird blender brasero gcolor2 geany gthumb hexchat kdenlive alacarte soundconverter audacity simplescreenrecorder transmission-gtk corebird vlc wine winetricks yumex-dnf zeal gnome-tweak-tool unar
```
Catatan: silahkan hapus aplikasi yang sekiranya tidak begitu anda perlukan.

## Menambahkan Fedora Tweak, FEDY
Fedy adalah aplikasi GUI yang memberikan kemudahan untuk menginstal _multimedia codec_ dan _software_ tambahan yang tidak disertakan oleh repositori resmi Fedora. Seperti dukungan format .mp3, Adobe Flash, Oracle Java, and masih banyak lagi, cukup dengan hanya satu kali klik saja.

Untuk menginstal Fedy, buka Terminal dan _copy paste_ kode perintah di bawah ini.
```
$ sudo sh -c 'curl https://www.folkswithhats.org/installer | bash'
```
Source : [https://folkswithhats.org/](https://folkswithhats.org/){:target="_blank"}

Setelah Fedy berhasil diinstal, saatnya kita menginstal aplikasi-aplikasi yang sudah dikemas oleh Fedy, seperti :

| APLIKASI | KETERANGAN |
| --- | --- |
| **Apps** | |
| Google Chrome | Web browser from Google |
| Dropbox for Nautilus | Dropbox integration for GNOME file manager |
| HandBrake | The open source video transcoder |
| Hangouts plugin | plugin for Hangouts |
| Spotify | Digital music service that gives you access to million of songs |
| Telegram | A messaging app with a focus on speed and security |
| WPS Office | Simple, powerful office suite with a confortable interface |
| **Development Tools** | |
| Android Studio | Official IDE |
| Atom | A hackable text editor for the 21th century |
| Oracle JDK | DE for building application using Java Language |
| **Tweaks** | |
| Better Font Rendering | Improve the font rendering for better readbility |
| Disk I/O Scheduller | Boost performance for SSDs and HDDs |
| Touchpad tap | Enable systemwide touchpad tap to click |
| **Utilities** | |
| Adobe Flash | Browser plugin and rich internet application runtime |
| Archive formats | Utillized for file-roller |
| Microsoft TrueType Core Fonts | Microsoft core fonts |

## Install Aplikasi Pendukung Mesin
Karena saya menggunakan laptop / notebook, sehingga perlu rasanya untuk menambahkan aplikasi untuk mengatur secara otomatis tentang sumber daya energi di laptop. Untuk itu saya memasang aplikasi bernama TLP.

Apa itu TLP ?

_TLP brings you the benefits of advanced power management for Linux without the need to understand every technical detail. TLP comes with a default configuration already optimized for battery life. Also an optional install of the smartmontools package enables hard disk SMART data in tlp-stat_ (`smartctl`).
```
$ sudo dnf install tlp
```

# Kesimpulan
Kesan setelah melakukan instalasi Fedora 25 Workstation pada mesin Lenovo ThinkPad x260 menurut saya sangat-sangat mudah dan tidak ribet. Kompatibilitas hardware yang sudah terpenuhi semua, tidak perlu repot-repot setting seperti yang saya lakukan pada MacBook Pro 8.1 late 2011 saya sebelumnya.

# Daftar Referensi
1. [https://rpmfusion.org/Configuration](https://rpmfusion.org/Configuration){:target="_blank"}
<br>[dateaccessed : 2017/01/20]
2. [https://folkswithhats.org/](https://folkswithhats.org/){:target="_blank"}
<br>[dateaccessed : 2017/01/20]
