---
layout: 'post'
title: 'St, Simple Terminal yang Sudah Lama Saya Dambakan <span class="new">BARU</span>'
date: 2019-02-08 17:08
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Tools', 'Terminal']
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Tidak saya pungkiri bahwa [Kai Hendry](https://github.com/kaihendry){:target="_blank"} yang memperkenalkan saya dengan [suckless.org](https://suckless.org/){:target="_blank"} melalui [video-video log-nya di YouTube](https://www.youtube.com/user/kaihendry){:target="_blank"} banyak memberikan saya pengaruh dalam menggunakan sistem operasi GNU/Linux, terkhusus Arch Linux.

Ditambah lagi [Donovan Nagel](https://www.i-bsd.com/){:target="_blank"} melalui [video-video log-nya](https://www.youtube.com/c/iBSDTV){:target="_blank"} yang memperkenalkan BSD family dengan menggunakan beberapa aplikasi Suckless juga. Rasa-rasanya sayang kalau saya tidak ikut-ikutan mencoba aplikasi-aplikasi dari Suckless.

Selama ini saya hanya memanfaatkan **dmenu**, itu pun tidak benar-benar menggunakan dmenu karena saya kombinasikan dengan **Rofi** sebagai application launcher dan banyak hal lainnya.

Saya tertarik menggunakan **dwm**, *Dynamic Window Manager*, sebuah window manager yang dikelola oleh Suckless. Karena kedua orang di atas menggunakan window manager ini. Namun, saya masih menyukai **i3wm** dan belum menemukan jalan buntu.

# Permasalahan

Malam tadi, **Termite** salah satu Terminal emulator yang saya gunakan dan saya andalkan tiba-tiba saja salah dalam menampilkan glyph font untuk simbol-simbol bawaan dari **Devicons**. Saya mendapati kesalahan ini pada **NERDTree** (vim sidebar file manager) dan **Ranger**.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/4N8gJ2p5/gambar-01.png"}
<p class="img-caption">Gambar 1 - Termite (VTE-Based Terminal) dan ST</p>

Saya sudah mencoba Terminal emulator yang lain, seperti gnome-terminal, xfce4-terminal, lxterminal, kitty, alacritty, semua menampilkan kesalahan yang sama seperti yang dialami oleh Termite. Permasalahan ini hanya dialami oleh Terminal yang berbasis VTE.

# Pemecahan Masalah

Karena alasan tersebut, saya akhirnya memutuskan untuk bermigrasi secara penuh dalam menggunakan St Terminal.

Mungkin saja, sebenarnya saya dapat mengatasi permasalahan dalam menampilkan glyph font ini, namun saya lebih memilih jalan untuk memigrasikan Terminal. Mumpung momennya sedang pas. Karena saya memang ingin pelan-pelan bermigrasi menggunakan aplikasi besutan dari Suckless. Karena dapat sekalian mengerti sedikit-sedikit bahasa C.

**Apa itu Simple Terminal?**

Dapat di baca sendiri [di sini](https://st.suckless.org/patches/alpha/){:target="_blank"}

# Instalasi

Proses instalasi St Terminal menurut saya sangat-sangat mudah.

1. Kunjungi link dari St Terminal, [di sini](https://st.suckless.org/){:target="_blank"}.

2. Scroll ke bagian paling bawah dari halaman, kita akan menemukan dua versi St yang dapat kita gunakan. Saya memilih versi `st 0.8.1` ketimbang menggunakan versi development dari Git.

3. Klik kanan link dari [`st 0.8.1`](https://dl.suckless.org/st/st-0.8.1.tar.gz){:target="_blank"} (2018-03-20) dan pilih **Copy Link Location**.

4. Buka Terminal, dan arahkan ke dalam direktori `~/.config/`.
```
$ cd ~/.config
```

5. Download dengan menggunakan `wget`.
```
$ wget "https://dl.suckless.org/st/st-0.8.1.tar.gz"
```

6. Ekstraksi paket `st-0.8.1.tar.gz` tersebut.
```
$ tar -xvf st-0.8.1.tar.gz
```

7. Rename direktori hasil ekstraksi.
```
$ mv st-0.8.1 st
```

8. Masuk ke dalam direktori `st`
```
$ cd st
```
Secara default paket `st-0.8.1` akan berisi seperti ini.
```
total 292
-rw-r--r-- 1 bandithijo users  1036 arg.h
-rw-r--r-- 1 bandithijo users 20114 config.def.h
-rw-r--r-- 1 bandithijo users   602 config.mk
-rw-r--r-- 1 bandithijo users  7158 FAQ
-rw-r--r-- 1 bandithijo users   732 LEGACY
-rw-r--r-- 1 bandithijo users  1834 LICENSE
-rw-r--r-- 1 bandithijo users  1253 Makefile
-rw-r--r-- 1 bandithijo users   723 README
-rw-r--r-- 1 bandithijo users  3667 st.1
-rw-r--r-- 1 bandithijo users 55693 st.c
-rw-r--r-- 1 bandithijo users  2835 st.h
-rw-r--r-- 1 bandithijo users  3685 st.info
-rw-r--r-- 1 bandithijo users   458 TODO
-rw-r--r-- 1 bandithijo users  1039 win.h
-rw-r--r-- 1 bandithijo users 44048 x.c
```

9. Saya memilih untuk me-*rename* file `config.def.h` daripada meng-*copy* nya.
```
$ mv config.def.h config.h
```
File konfig header ini berisi konfigurasi untuk font style, font size, fungsi keyboard, colorscheme, dan lain-lain.

10. Selanjutnya, bisa coba di compile dulu. Sekedar memastikan bisa di compile saja.
```
$ make
```
Nanti akan terbuat file binary yang bernama `st`.

    Kemudian untuk menginstallnya ke dalam sistem.
    ```
    $ sudo make install
    ```

<br>
<br>
Pada versi `0.8.1` ini, St sudah memiliki fitur-fitur bawaan seperti:

| <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>C</kbd> | Copy |
| <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>V</kbd> | Paste |
| <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>PgUp</kbd> | Zoom In |
| <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>PgDn</kbd> | Zoom Out |
| <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>Home</kbd> | Zoom Normal |

<br>
Namun, belum terdapat beberapa fungsi yang saya perlukan seperti:
1. Scroll back dengan keyboard dan mouse
2. Transparansi (optional)

Untuk itu, saya perlu untuk menambahkan beberapa patch.

# Patch

Patch yang saya gunakan tidak banyak. Beberapa di antaranya.

**Solarized Colors**

1. [st-no bold colors-0.8.1.diff](https://st.suckless.org/patches/solarized/st-no_bold_colors-0.8.1.diff){:target="_blank"}
<br>Patch ini untuk memperbaiki warna pada bold font yang biasanya ditampilkan salah.

2. [st-solarized-both-0.8.1.diff](https://st.suckless.org/patches/solarized/st-solarized-both-0.8.1.diff){:target="_blank"}
<br>Patch ini untuk dapat menggunakan Solarized colorshceme dan berganti antara Dark dan Light menggunakan <kbd>F6</kbd>.

**Scrollback**

1. [st-scrollback-0.8.diff](https://st.suckless.org/patches/scrollback/st-scrollback-0.8.diff){:target="_blank"}
<br>Patch ini untuk menambahkan fitur scrolling back ke atas dan ke bawah menggunakan keyboard, <kbd>SHIFT</kbd>+<kbd>PgUp</kbd> dan <kbd>SHIFT</kbd>+<kbd>PgDn</kbd>.

2. [st-scrollback-mouse-0.8.diff](https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.8.diff){:target="_blank"}
<br>Patch ini untuk menambahkan fitur scrolling back ke atas dan ke bawah menggunakan mouse, <kbd>SHIFT</kbd>+Scrolling Up  dan <kbd>SHIFT</kbd>+Scrolling Down.

**Alpha**

1. [st-alpha-0.8.1.diff](https://st.suckless.org/patches/alpha/st-alpha-0.8.1.diff){:target="_blank"}
<br>Patch ini untuk menambahkan fitur alpha atau transparansi pada background Terminal.

<br>
**Bagaimana cara menggunakan patch ini?**

Saya melakukan patching secara manual dan tidak menggunakan perintah `patch`. Proses patching inipun tidak sulit, hanya copy dan paste saja. Tidak memerlukan pengetahuan bahasa C.

**Bagaimana caranya?**

Akan saya buatkan video tutorialnya di kesempatan yang lain. Saat ini sedang kurang enak badan.

Saya kasih previewnya dulu saja gpp yaa. Hehe.

{% youtube w9l3-ZkXPT4 %}

# Hasilnya

Saya sangat puas dengan hasilnya. Dikarenakan ada beberapa hal yang saya tidak dapati pada Terminal emulator yang lain. Seperti:

1. Sangat cepat saat dipanggil (*startup*)
2. Bold font dapat menampilkan warna yang sesuai
3. Perpindahan dari Solarized Dark dan Light sangat halus dan tidak ada warna yang salah.
4. Glyph font yang sesuai
5. Dapat menghandle w3m dalam Ranger dengan baik

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/gcQWhNYs/gambar-02.gif"}

# Kekurangan

Saya masih belum dapat menggunakan tombol <kbd>DELETE</kbd> sebagai mana fungsinya. Karena saat ini fungsi tombol ini malah menampilkan karakter `~`.

Ada patch untuk **delkey**, namun setelah saya coba, malah berfungsi selayaknya <kbd>BACKSPACE</kbd>.

Saya memerlukan <kbd>DELETE</kbd> untuk fungsi "Move to Trash" pada Ranger. Sehingga saat ini saya memindahkan fungsinya ke tombol <kbd>F8</kbd>.

# Referensi

1. [st.suckless.org/](https://st.suckless.org/){:target="_blank"}
<br>Diakses tanggal: 2019/02/08

2. [wiki.archlinux.org/index.php/St](https://wiki.archlinux.org/index.php/St){:target="_blank"}
<br>Diakses tanggal: 2019/02/08

