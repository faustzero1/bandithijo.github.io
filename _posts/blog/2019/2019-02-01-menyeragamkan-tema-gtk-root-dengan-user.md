---
layout: 'post'
title: 'Menyeragamkan Tema GTK Root dengan Tema User'
date: 2019-02-01 01:30
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips']
pin:
hot:
contributors: []
description: "Bicara tentang tampilan desktop, setidaknya terdapat 2 library yang banyak digunakna oleh aplikasi-aplikasi GUI di lingkungan GNU/Linux, yaitu GTK+ dan Qt. Kedua library ini mungkin memiliki default theme mereka sendiri. Mungkin gak kalau kita seragamkan? Sangat mungkin! Beberapa teman-teman yang sering melihat screenshot atau video-video pendek yang sering saya share di Telegram mungkin pernah melihat dan memperhatikan."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Menyeragamkan GTK theme yang dimiliki oleh root agar seragam dengan yang dimiliki oleh user biasa.

**Syarat**:

1. GTK theme terinstall pada lokasi global `/usr/share/themes/`
2. GTK theme memiliki dukungan terhadap GTK2 dan GTK3 (optional)

# Pengecekan

## Pengecekan Lokasi Tema

Lakukan pengecekan untuk syarat pertama, apakah GKT theme yang kita pakai sudah berada pada direktori `/usr/share/themes/`. Kalau ternyata belum, sebaiknya dipindahkan saja.

1. Cek nama tema yang sedang aktif pergunakan. Saya menggunakan "**NumixSolarizedDarkYellow**".
2. Cek apakah pada direktori `/usr/share/themes/` terdapat direktori yang bernama sama seperti tema yang kita gunakan.

   Cek menggunakan Terminal,

   {% shell_user %}
ll /usr/share/themes | grep -e "Numix"
{% endshell_user %}

   <pre>
   drwxr-xr-x 11 root root Numix
   drwxr-xr-x 11 root root Numix-DarkBlue
   drwxr-xr-x  8 root root Numix Solarized
   drwxr-xr-x 11 root root NumixSolarizedDarkBlue
   drwxr-xr-x 11 root root NumixSolarizedDarkGreen
   <mark>drwxr-xr-x 11 root root NumixSolarizedDarkYellow</mark>
   drwxr-xr-x 11 root root NumixSolarizedLightBlue
   drwxr-xr-x 11 root root NumixSolarizedLightGreen
   drwxr-xr-x 11 root root NumixSolarizedLightYellow</pre>

   Atau, cek menggunakan File Manager,
{% image https://i.postimg.cc/CKjv85C1/gambar-01.png | 1 %}

   Apabila GTK theme yang kita pergunakan ternyata tidak terdapat pada direktori `/usr/share/themes`, lantas coba lakukan pengecekan pada direktori `~/.local/share/themes/`.

   Apabila ketemu, saya menyarankan untuk memindahkannya saja ke direktori `/usr/share/themes`.

   Tujuannya, agar GTK theme yang kita pergunakan juga dapat dipergunakan oleh user yang lain. Dalam hal ini adalah root. Karena kita akan berbagi tema yang sama dengan root.

## Pengecekan GTK2 dan GTK3 Compatibility

Selanjutnya, lakukan pengecekan apakah teman yang kita pergunakan memiliki kompatibilitas terhadap GTK2 dan GTK3 atau tidak. Apa hanya GTK3 saja.

1. Caranya cukup masuk ke dalam direktori tema dan cek apakah terdapat direktori `gtk-2.0/` dan `gtk-3.0/`.

   Cek menggunakan Terminal,

   {% shell_user %}
cd /usr/share/themes/<mark>NumixSolarizedDarkYellow</mark>
ll
{% endshell_user %}

   Ganti `NumixSolarizedDarkYellow` dengan tema yang kalian gunakan.

   <pre>
   total 40
   drwxr-xr-x 2 root root assets
   <mark>drwxr-xr-x 2 root root gtk-2.0
   drwxr-xr-x 2 root root gtk-3.0</mark>
   drwxr-xr-x 2 root root gtk-3.20
   -rw-r--r-- 1 root root index.theme
   drwxr-xr-x 2 root root metacity-1
   drwxr-xr-x 2 root root openbox-3
   drwxr-xr-x 3 root root unity
   drwxr-xr-x 2 root root xfce-notify-4.0
   drwxr-xr-x 2 root root xfwm4</pre>

   Atau, cek menggunakan File Manager,

   {% image https://i.postimg.cc/XvmCnkBB/gambar-02.png | 2 %}

   Apabila hanya terdapat salah satu dari keduanya, artinya GTK theme yang kalian pergunakan hanya mendukung GTK versi yang tersedia di tema.

   Nah, dengan ini, tahap pengecekan sudah selesai.

# Eksekusi

Setelah kita memastikan lokasi tema yang kita pergunakan sudah terdapat pada direktori `/usr/share/themes/`. Langkah selanjutnya adalah mencopy konfigurasi GTK, baik GTK2 maupun GTK3 yang dimiliki oleh user (yang kita gunakan) ke direktori `/root/`.

## GTK2

Aplikasi GUI yang membutuhkan root permission dan masih menggunakan GTK2, salah satunya adalah **GParted**.

Untuk tema yang menggunakan GTK2, konfigurasi disimpan ada `~/.gtkrc-2.0` yang ada pada HOME direktori kita.

Coba kita buka untuk melihat bagaimana bentuk konfigurasi yang ada di dalamnya.

{% shell_user %}
vim ~/.gtkrc-2.0
{% endshell_user %}

{% highlight_caption $HOME/.gtkrc-2.0 %}
{% pre_caption %}
# DO NOT EDIT! This file will be overwritten by LXAppearance.
# Any customization should be done in ~/.gtkrc-2.0.mine instead.

include "/home/bandithijo/.gtkrc-2.0.mine"
<mark>gtk-theme-name="NumixSolarizedDarkYellow"</mark>
gtk-icon-theme-name="DarK-Dark"
gtk-font-name="Hack 9"
gtk-cursor-theme-name="ComixCursors-Opaque-White"
gtk-cursor-theme-size=24
gtk-toolbar-style=GTK_TOOLBAR_ICONS
gtk-toolbar-icon-size=GTK_ICON_SIZE_SMALL_TOOLBAR
gtk-button-images=0
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=0
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle="hintfull"
gtk-xft-rgba="rgb"
gtk-modules="canberra-gtk-module:gail:atk-bridge"
{% endpre_caption %}

Dapat dilihat bahwa, pada sistem saya, file `gtkrc-2.0` ini digenerate oleh `LXAppearance`.
{% image https://i.postimg.cc/257SKdFf/gambar-03.png | 3 | Interface dari LXAppearance %}

Dapat dilihat di dalam file `~/.gtkrc-2.0` ini terdapat GTK theme yang saya pergunakan. Karena tema yang saya pergunakan memang menyediakan tema untuk GTK2.

Selanjutnya, tinggal men-copy ke dalam direktori `/root/`.

{% shell_user %}
sudo cp ~/.gtkrc-2.0 /root/
{% endshell_user %}

Berikut ini adalah ilustrasinya.
{% image https://i.postimg.cc/htBLQBs4/gtk2.gif | gtk2 %}

## GTK3

Sejujurnya saya jarang sekali menggunakan aplikasi GTK3 yang memerlukan root permission.

Kalau untuk copy-paste direktori atau file yang membutuhkan root permission, saya biasa menggunakan Terminal.

Untuk tema yang menggunakan GTK3, konfigurasi disimpan ada `~/.config/gtk-3.0/settings.ini` yang ada pada `~/.config/gtk-3.0/` direktori kita.

Coba kita buka untuk melihat bagaimana bentuk konfigurasi yang ada di dalamnya.

{% shell_user %}
vim ~/.config/gtk-3.0/settings.ini
{% endshell_user %}

{% highlight_caption $HOME/.config/gtk-3.0/settings.ini %}
{% pre_caption %}
[Settings]
gtk-application-prefer-dark-theme=0
<mark>gtk-theme-name=NumixSolarizedDarkYellow</mark>
gtk-icon-theme-name=DarK-Dark
gtk-font-name=Hack 9
gtk-cursor-theme-name=ComixCursors-Opaque-White
gtk-cursor-theme-size=24
gtk-toolbar-style=GTK_TOOLBAR_ICONS
gtk-toolbar-icon-size=GTK_ICON_SIZE_SMALL_TOOLBAR
gtk-button-images=0
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=0
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintfull
gtk-xft-rgba=rgb
gtk-modules=canberra-gtk-module:gail:atk-bridge
gtk-recent-files-max-age=0
gtk-recent-files-limit=0
gtk-recent-files-enabled=0
{% endpre_caption %}

Kurang lebih hampir mirip dengan konfigurasi GTK2 di atas yaa, `~/.gtkrc-2.0`.

Selanjutnya, tinggal men-copy ke dalam direktori `/root/`.

{% shell_user %}
sudo cp -rvf ~/.config/gtk-3.0 /root/.config
{% endshell_user %}

Sekarang coba buka aplikasi GTK3 dengan root permission.

Berikut ilustrasinya.
{% image https://i.postimg.cc/Ssq3g3mm/gtk3.gif | gtk3 %}

Nah, sekarang tampilan aplikasi GTK3 yang dimiliki oleh root dan user sudah sama.

# Pesan Penulis

Sejujurnya saya kurang mengerti apakah terdapat dampak buruk dari modifikasi ini terhadap keamanan sistem. Karena jujur saja untuk hal-hal yang berurusan dengan root permission, saya sedikit takut-takut.

Namun, kalau saya menilai dari yang kasus di atas, dimana kita hanya menambah beberapa konfigurasi untuk tampilan GTK, saya rasa tidak ada masalah yang serius. Apalagi kita hanya menggunakan pada komputer pribadi, bukan Server (yaa kali server dikasih tema, bosku).

Bagaimanapun juga, karena ini berurusan dengan root permission, saya harus menyampaikan, "*Do with Your Own Risk*".

