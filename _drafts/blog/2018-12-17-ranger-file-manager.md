---
layout: 'post'
title: 'Ranger, File Manger CLI yang Ternyata Mudah dan Sangat Memudahkan'
date: 2018-12-17 09:18
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

Ranger adalah *text-based file manager* (aplikasi untuk memanajemen file bebasis teks) yang ditulis dengan bahasa Python.

Ranger menampilkan konten dalam bentuk kolom-kolom. Terdapat tiga buah kolom, yaitu: kolom direktori sebelumnya, direktori sekarang, dan file preview atau direktori selanjutnya.

<!-- IMAGE CAPTION -->
![gambar_1](https://i.postimg.cc/TY3F2Fbw/gambar-01.gif)
<p class="img-caption">Gambar 1 - Antar muka Ranger. (1) Direktori sebelumnya, (2) Direktori Sekarang, (3) Direktori Selanjutnya atau file preview</p>

<!-- IMAGE CAPTION -->
![gambar_2](https://i.postimg.cc/02X3znGC/gambar-02.png)
<p class="img-caption">Gambar 2 - Kolom ke-3 menampilkan konten dari file teks</p>

<!-- IMAGE CAPTION -->
![gambar_3](https://i.postimg.cc/y8wbPNbg/gambar-03.png)
<p class="img-caption">Gambar 3 - Kolom ke-3 menampilkan preview dari gambar</p>

<!-- IMAGE CAPTION -->
![gambar_4](https://i.postimg.cc/rwdHx4Q2/gambar-04.png)
<p class="img-caption">Gambar 4 - Kolom ke-3 menampilkan detail dari audio atau video file</p>

<br>
**Gimana keren yaa?**

Menurut saya sih keren. Kekerenan nomor satu, karena *file manager* ini sudah dapat menampilkan *preview* dari file yang sedang kita seleksi - bahasa kitanya, mengintip. Yang paling berguna dan sering saya manfaatkan adalah *preview* untuk file gambar dan teks.

Kekerenan nomor dua adalah, *Vi-style key bindings*, pencet-pencetan yang mirip dengan Vim. Dengan begini, tidak perlu lama beradaptasi. Setidaknya dalam hal navigasi, tinggal <kbd>H</kbd> <kbd>J</kbd> <kbd>K</kbd> <kbd>L</kbd>. Tinggal mempelajari fitur-fitur lain yang dimiliki oleh Ranger yang biasa saya gunakan pada *file manager* lain.

Sejauh ini, fitur-fitur yang saya pergunakan adalah:
1. Navigasi yang super efektif dengan pencet-pencetan ala Vim.
2. Selections
3. Copy dan paste dengan pencet-pencetan yang super.
4. Termasuk juga kemampuan membuat *symbolic link* dengan super mudah
5. Bookmarks
6. Tagging
7. Tabs
8. dll.

Kekerenan nomor tiga adalah, nama Ranger itu sendiri. Ini subjektif saya memang. Hahahaha. Tapi iya bukan? Keren kan? Ranger. Ndak malu-maulin lah kalo ditanya sama temen, "Kamu pake apa itu, Bro?" Dengan bangga kita persembahkan jawaban, "Ranger."

Masih banyak fitur-fitur dari Ranger yang belum saya manfaatkan. Tapi saya tidak khawatir dan terburu-buru, biarlah proses belajar yang akan menuntun saya mencoba fitur-fitur lain yang dimiliki oleh Ranger.

Jadi, apa kalian mau ikut?

Tiga bulan, enam bulan, satu tahun dari sekarang mungkin kemampuan saya dalam menggunakan Ranger akan bertambah. Siapa yang tahu.

Tentukan pilihanmu, Bro.

*I hate to say,"I told you so."*

# Instalasi

Proses instalasi Ranger, saya rasa sudah pasti sangat mudah. Hanya tinggal menggunakan paket manajer dari distribusi sistem operasi teman-teman.
```
$ sudo pacman -S ranger
```

# Membuat App Launcher

Seperti biasa kita perlu membuat `.desktop` agar mudah dipaggil dengan *application launcher* seperti dmenu dan rofi sehingga tidak perlu membuka Terminal terlebih dahulu.
```
$ vim ~/.local/share/applications/ranger.desktop
```
```
[Desktop Entry]
Type=Application
Name=ranger
Comment=Launches the ranger file manager
Icon=ranger
Terminal=false
Exec=termite -e ranger
#Exec=xfce4-terminal -x ranger
Categories=ConsoleOnly;System;FileTools;FileManager
MimeType=inode/directory;
```
Pada bagian `Exec=`, sesuaikan dengan Terminal emulator yang teman-teman pergunakan




# Referensi

1. [https://github.com/ranger/ranger](https://github.com/ranger/ranger){:target="_blank"}
<br>Diakses tanggal: 2018/12/17:

2. [https://wiki.archlinux.org/index.php/Ranger](https://wiki.archlinux.org/index.php/Ranger){:target="_blank"}
<br>Diakses tanggal: 2018/12/17:

