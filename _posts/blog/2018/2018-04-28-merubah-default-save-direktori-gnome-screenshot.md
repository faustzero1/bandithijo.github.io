---
layout: 'post'
title: 'Merubah Default Save Direktori pada GNOME-Screenshot'
date: 2018-04-28 06:09
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tools', 'Tips']
pin:
hot:
contributors: []
description:
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://s20.postimg.cc/yjw814lz1/banner_post_08.png" onerror="imgError(this);" alt="banner">

# Latar Belakang

**GNOME-ScreenShot** adalah aplikasi untuk mengambil gambar layar monitor yang sudah tersedia secara *native* pada **GNOME** *desktop environment*. Saya sudah menggunakan aplikasi ini sejak masih GNOME versi 2. Saat ini saya sedang menggunakan **XFCE4**, namun saya kurang menyukai aplikasi *screenshot* milik XFCE4 karena terlalu sederhana (subjektif penulis).

# Permasalahan

Saat mengambil *screenshot* menggunakan *shortcut* dengan kombinasi tombol pada keyboard. File gambar otomatis langsung diletakkan pada direktori **~/Pictures**. Tentunya hal ini sangat tidak menyenangkan buat saya, karena file tidak terorganisir sesuai tempatnya.

# Solusi

Kita membutuhkan aplikasi bantuan untuk merubah konfigurasi, yang bernama [**dconf-editor**](https://www.archlinux.org/packages/extra/x86_64/dconf-editor/){:target="_blank"}.

{% shell_user %}
sudo pacman -S dconf-editor
{% endshell_user %}

Setelah, dconf-editor berhasil dipasang. Buka dconf-editor.

Lalu pergi ke **org** > **gnome** > **gnome-screenshot**.

Klik dua kali pada bagian **auto-save-directory**.

![gambar1]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/kq7vc3vyl/gambar_01.png" onerror="imgError(this);"}{:class="myImg"}

Nanti akan terbuka *section* seperti di bawah.

![gambar2]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/rhyaek099/gambar_02.png" onerror="imgError(this);"}{:class="myImg"}

Pada bagian paling bawah, **Custom value**, ganti ke direktori tempat dimana kalian ingin menyimpan hasil *screenshot*.

Namun sebelumnya, untuk memberikan nilai pada Custom value, harus men-disable **Use default value**.

Pada contoh di atas, saya meletakkan hasil *screenshot* pada direktori `file:///home/bandithijo/pix/ScreenShot`.

<span class="font-latin">And we're redy to go !</span>

# Referensi

1. [askubuntu.com/questions/114429/default-save-directory-for-gnome-screenshot](https://askubuntu.com/questions/114429/default-save-directory-for-gnome-screenshot){:target="_blank"}
<br>Diakses tanggal: 2018/04/28

