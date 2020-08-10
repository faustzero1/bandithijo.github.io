---
layout: 'post'
title: "Mengedit dengan Vim pada Nautilus dan Thunar pada Window Manager"
date: 2020-08-11 02:51
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
---

# Sekenario Masalah

Ini bukan pertama kalinya saya mengkonfigurasi "Membuka vim/neovim pada Nautilus atau Thunar pada Window Manager".

Namun, karena tidak pernah dicatat --karena saya menganggap ini adalah hal yang spele dan tidak perlu dicatat-- ternyata berdampak buruk dikemudian hari.

Karena tidak memiliki catatan, saya harus mencari-cari bagaimana konfigurasi yang pas untuk membuka file text dengan Vim/Neovim di Nautilus maupun Thunar.

Sangat merepotkan. 😅

# Pemecahan Masalah

1. Copy file `vim.desktop` atau `nvim.desktop`

    yang berlokasi di `/usr/local/share/applications/`

    ke dalam `~/.local/share/applications/`.

    Tujuannya agar kita memiliki konfigurasi khusus untuk akun kita saja.

2. Kemudian edit file tersebut, kira-kira berisi seperti di bawah ini.

    <pre>
    [Desktop Entry]
    Name=Neovim
    Comment=Edit text files
    TryExec=nvim
    <mark>Exec=st -e "nvim" %f</mark>
    <mark>Terminal=false</mark>
    Type=Application
    Keywords=Text;editor;
    Icon=nvim
    Categories=Utility;TextEditor;
    StartupNotify=false
    MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;</pre>

    Perhatikan bagian yang saya marking, itu adalah bagian penentu agar kita dapat mengedit file text dengan menggunakan Vim/Neovim pada Nautilus atau Thunar.

    `Exec=st -e "nvim" %f`, Saya menggunakan Simple Terminal, teman-teman dapat mengganti dengan Terminal emulator favorit teman-teman. Tentu saja Terminal yang memiliki flag executable. Silahkan lihat dengan flag `-h` apakah Terminal emulator yang digunakan memiliki fitur ini.

    `Terminal=false`, ini juga bagian terpenting. Pastikan bernilai **false**. Karena kita sudah menjalankan instance Terminal pada bagian `Exec=` di atas. Perlakuan ini hanya pada Window Manager, mungkin akan berbeda dengan Desktop Environment.

# Hasilnya

Kalau sudah diset, sekarang coba buka salah satu plain text, dengan klik kanan "Open With Vim/NeoVim". Seperti yang saya demokan di bawah.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/ryWmMDwS/gambar-01.gif" onerror="imgError(this);"}{:class="myImg"}




<br>
Mantap!!!

Saya rasa hanya ini yang dapat saya tuliskan saat ini.

Mudah-mudahan dapat bermanfaat untuk teman-teman.

Terima kasih.

(^_^)








# Referensi

1. [Open Vim in Xfce4 Terminal from Thunar](https://askubuntu.com/a/789541/777616){:target="_blank"}
<br>Diakses tanggal: 2020/08/11
