---
layout: 'post'
title: 'Manajemen Clipboard dengan Clipmenu pada i3wm'
date: 2018-12-16 11:42
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Terminal', 'Tools', 'I3WM', 'Ulasan']
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="#" alt="banner"> -->

# Prakata

Selama ini saya tidak pernah menggunakan aplikasi *clipboard manager* semacam **Clipman** (`xfce4-clipman-plugin`) yang kegunaannya untuk menangkap, mengumpulkan, dan memanajemen hasil inputan copy. Saya merasa belum membutuhkannya. Saya pikir *copy* dan *paste* adalah hal yang sangat sederhana, tidak perlu sampai dimanajemen segala.

Sampai beberapa hari lalu, saya membalas pertanyaan di group openSUSE Indonesia, dan salah mention, lalu saya *copy* jawaban dan hapus. Saat akan saya *paste* ke bubble yang bertanya, ternyata *clipboard* saya sudah tertumpuk oleh inputan *copy* yang lain. Hahaha. Beginilah yaa, usia sudah tidak lagi muda, terdistraksi sedikit dapat menimbulkan kelupaan.

# Solusi

Hal yang saya alami tidak akan terjadi apabila saya menggunakan *clipboard manager*. Tahun ini sebenarnya sudah pernah juga mencoba *clipboard manager*, karena melihat video dari [Kai Hendry tentang bagaimana dia menghandle clipboard pada sistemnya](https://youtu.be/2rs1l4YZxRo){:target="_blank"}. Ia mengunakan [**cdown/clipmenu**](https://github.com/cdown/clipmenu){:target="_blank"}. Lantas saat saya coba pasang, Hahaha, selama pemakaian *resource memory* saya terus naik. Karena kurangnya ilmu saat itu dan motivasi yang sekedar ikut-ikutan, lantas niat menggunakan *clipboard manager* pupus di pinggr jalan.

Clipmenu adalah *clipboard manager* yang menggunakan dmenu atau Rofi sebagai antar muka.
<!-- IMAGE CAPTION -->
![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/J08d4wSg/gambar-01.png"}
<p class="img-caption">Gambar 1 - Tampilan Clipmenu menggunakan Rofi sebagai antar muka</p>


# Instalasi

Untuk memasang **clipmenu** pada sistem, terdapat dua cara yang saya ketahui.
1. [`community/clipmenu`](https://www.archlinux.org/packages/community/any/clipmenu/){:target="_blank"} (Arch Linux)

2. [`cdown/clipmenu`](https://github.com/cdown/clipmenu){:target="_blank"} (GitHub)

Dalam catatan ini, saya akan mencoba meng-*cover* kedua cara ini.

Konfigurasi akan saya tulis pada bagian <a href="#konfigurasi">Konfigurasi</a>.

## Clipmenu from Arch Repo

Cara pasangnya sangat mudah.
```
$ sudo pacman -S clipmenu xsel

```
Clipmenu memerlukan paket `xsel` untuk menhandle *clipboard*.

## Clipmenu from GitHub

Pertama-tama beri bintang pada repository [cdown/clipmenu](https://github.com/cdown/clipmenu){:target="_blank"}. Sebagai bentuk apresiasi kita terhadap waktu dan pikiran developer.

1. Kloning dari GitHub repo dan letakkan pada direkotri tempat kalian mengumpulkan repository dari GitHub. Saya mempunyai direktori `~/app/` tempat saya mengumpulkan resource aplikasi.
    ```
    $ cd app
    $ git clone https://github.com/cdown/clipmenu.git
    ```

2. Masuk ke dalam direktori `clipmenu` dan buat symbolic link ke direktori `/usr/bin/`.
    ```
    $ cd clipmenu
    $ sudo ln -sf $HOME/app/clipmenu/clipmenu /usr/bin/clipmenu
    $ sudo ln -sf $HOME/app/clipmenu/clipmenud /usr/bin/clipmenud
    ```
    Sesuaikan sumber dari link (`$HOME/app/`) dengan path tempat kalian menyimpan kloning repo.
5. Masuk ke direktori `init` dan buat symbolic link dari file service ke `/usr/lib/systemd/user/`.
    <!-- PERHATIAN -->
    <div class="blockquote-red">
    <div class="blockquote-red-title">[ ! ] Perhatian</div>
    <p>Saya tidak berhasil menjalankan <code>clipmenud.service</code>. Sehingga saya tidak menggunakan cara ini.</p>
    </div>
    ```
    $ cd init
    $ sudo ln -sf $HOME/app/clipmenu/init/clipmenud.service /usr/lib/systemd/user/clipmenud.service
    ```
4. Periksa apakah semua symbolic link sudah berada di tujuan dan mengarah ke arah yang benar.

    **File Binary**
    ```
    $ ll /usr/bin | grep -E 'clipmenu|clipmenud'
    ```
    ```
    lrwxrwxrwx 1 root root  38 Dec 16 15:18 clipmenu -> /home/bandithijo/app/clipmenu/clipmenu
    lrwxrwxrwx 1 root root  39 Dec 16 15:18 clipmenud -> /home/bandithijo/app/clipmenu/clipmenud
    ```
    **File Service**
    ```
    $ ll /usr/lib/systemd/user/ | grep -i clipmenud.service
    ```
    ```
    lrwxrwxrwx 1 root root  52 Dec 16 15:26 clipmenud.service -> /home/bandithijo/app/clipmenu/init/clipmenud.service
    ```


# Konfigurasi

Sebagai informasi, konfigurasi yang saya tulis ini adalah konfigurasi untuk **i3wm**/**i3-gaps**. Untuk teman-teman yang tidak menggunakan wm yang sama, dapat menyesuaikan dan memodifikasi dengan wm masing-masing.

## Aktifkan Clipmenu Daemon

Ada diua cara untuk menggukana mengaktifkan `clipmenud` (clipmenu daemon). Dengan menjalankannya saat sistem startup atau saat sistem booting.

**System Startup i3wm**

Tambahkan baris berikut pada file config i3wm.
```
$ vim .config/i3/config
```
```
# clipmenu daemon
exec --no-startup-id clipmenud
```
<br>
Atau,

**Systemd Service**
<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Saya tidak berhasil menjalankan <code>clipmenud.service</code>. Sehingga saya tidak menggunakan cara ini.</p>
</div>
Aktifkan/enable service, agar saat sistem booting, clipmenud akan sekalian di jalankan.
```
$ sudo systemctl enable clipmenud.service
$ sudo systemctl start clipmenud.service
```

## Definisikan Default Path

Sebelum mengkonfigurasi, selalu biasakan untuk melihat help atau manual dari clipmenu terlebih dahulu.
```
$ clipmenu -h
```
```
clipmenu is a simple clipboard manager using dmenu and xsel. Launch this
when you want to select a clip.

All arguments are passed through to dmenu itself.

Environment variables:

- $CM_DIR: specify the base directory to store the cache dir in (default: $XDG_RUNTIME_DIR, $TMPDIR, or /tmp)
- $CM_HISTLENGTH: specify the number of lines to show in dmenu/rofi (default: 8)
- $CM_LAUNCHER: specify a dmenu-compatible launcher (default: dmenu)
```
Nah, kita perlu menambahkan **environment variable**.

Secara default, clipmenu menggunakan dmenu sebagai antar muka. Namun bagi yang menggunakan rofi dapat menambahkan `rofi` pada `CM_LAUNCHER`.

Jangan lupa juga untuk mendefinisikan path dari `CM_DIR`. Saya memilih untuk membuat direktori `clipmenu` pada `/tmp` agar dapat saya manipulasi, seperti menghapus clipboard yang tersimpan.

Untuk teman-teman yang menggunakan Display Manager seperti LightDM dan GDM, silahkan tambahkan baris di bawah ini pada file `~/.profile`. Untuk yang menggunakan startx dapat menambahkannya pada `~/.xinitrc`.

```
$ vim ~/.profile
```
```
# Clipmenu Environment Variables
export CM_LAUNCHER=rofi-clipmenu
export CM_DIR=/tmp/clipmenu
```
**Perhatian!** Pada `CM_LAUNCHER=` di atas, saya membuat *custom* bash script yang bernama `rofi-clipmenu` untuk memanggil perintah rofi yang sudah saya modif agar menampilkan tulisan "CLIPBOARD" dengan baris dan lebar tertentu.

Maka kita akan membuatnya. Kalian bisa membuatnya di lokal `~/.local/bin/` (kalau punya), atau langsung saja di `/usr/bin/`.
```
$ sudo vim /usr/bin/rofi-clipmenu
```
```
#!/usr/bin/env bash

rofi -dmenu -p 'CLIPBOARD' -lines 8 -width 500
```
Sesuaikan dengan preferensi yang kalian inginkan.

Jangan lupa buat menjadi excutable.
```
$ sudo chmod +x /usr/bin/rofi-clipmenu
```


## Keyboard Shortcuts

Selanjutnya tinggal mendefiniskan keyboard shortcut.

Karena menggunakan i3wm, maka caranya sangat mudah sekali, tinggal tambahkan baris di bawah pada file config i3 `~/.config/i3/config`. Tambahkan di bawah baris `clipmenud` yang sudah kita tambahkan sebelumnya, agar rapi.

```
bindsym $mod+p exec --no-startup-id clipmenu
bindsym $mod+Shift+p exec --no-startup-id rm -rf /tmp/clipmenu/*
```
Perhatikan pada baris kedua, saya mempergunakan untuk menghapus seluruh clipboard menggunakan perintah `$ rm -rvf /tmp/clipmenu/*`. Sebenarnya Clipmenu sudah menyediakan `clipdel` namun tidak saya pergunakan. Alternatif lain dapatpula menggunakan `trash-cli`.

Sesuaikan keyboard shortcut sesuai preferensi kalian.

Saya menggunakan :

<kbd>SUPER</kbd> + <kbd>P</kbd>, untuk memanggil clipmenu.

<kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>P</kbd>, untuk menghapus seluruh clipboard yang ada di clipmenu.

Untuk memilih clip mana yang ingin kita pergunakan kembali, tinggal menekan arrow key <kbd> ↓ </kbd> / <kbd> ↑ </kbd> untuk memilih, tekan <kbd>ENTER</kbd> untuk memasukkannya pada PRIMARY. Kemudian, tinggal kita *paste* di mana saja.

<!-- IMAGE CAPTION -->
![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/MTkmShLQ/gambar-02.gif"}
<p class="img-caption">Gambar 2 - Ilustrasi penggunaan Clipmenu dengan Rofi</p>

# Pesan Penulis

Terdapat banyak sekali *clipboard management* yang dapat kita pergunakan. Saat ini saya sedang mengunakan clipmenu, entah besok akan mencoba yang mana lagi.

Catatan dokumentasi ini masih jauh dari kata sempurna. Sebaik-baik dokumentasi adalah dokumentasi resmi yang ditulis oleh developer pengembang aplikasi. Silahkan bereksplorasi terhadap clipmenu dengan merujuk pada referensi yang saya sertakan di bawah.

Karena keterbatasan pengetahuan, Saya masih mengalami kegagalan dalam menjalankan clipmenud daemon melalui systemd service. Hehehe.


# Referensi

1. [wiki.archlinux.org/index.php/Clipboard](https://wiki.archlinux.org/index.php/Clipboard){:target="_blank"}
<br>Diakses tanggal: 2018/12/16

2. [github.com/cdown/clipmenu](https://github.com/cdown/clipmenu){:target="_blank"}
<br>Diakses tanggal: 2018/12/16

