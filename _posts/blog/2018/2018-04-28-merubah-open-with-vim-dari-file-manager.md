---
layout: 'post'
title: 'Merubah Open With Vim dari File Manager'
date: 2018-04-28 09:58
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Vim', 'Tips', 'Tools']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<img class="post-body-img" src="{{ site.lazyload.logo_blank_banner }}" data-echo="https://s20.postimg.cc/wzvhg7ngd/banner_post_09.png" onerror="imgError(this);" alt="banner">

# Latar Belakang

[**Vim**](https://www.vim.org/){:target="_blank"} adalah *text editor* yang sejak 2016 saya gunakan. Keputusan untuk mempelajari Vim pada tahun itu, semakin saya rasakan manfaatnya seiring berjalannya waktu. Keuntungan-keuntungan yang diceritakan oleh orang-orang yang sudah terlebih dahulu menggunakan Vim, juga saya alami sekarang. Bagi saya yang hampir 80% sehari-hari menggunakan *text editor*, mempelajari Vim adalah investasi jangka panjang yang berharga. Jadi buat kalian yang sedang mempelajari Vim, maju terus pantang mundur. Buat yang belum tahu apa itu Vim, saya tidak merekomendasikan. Hehehe.

# Permasalahan

Saat ini saya sudah tidak lagi menggunakan Vim, karena beberapa alasan yang salah satunya adalah dukungan terhadap *clipboard* -- salah satu kegunannya adalah *copy paste* dari Vim ke dalam sistem dan sebaliknya. Sehingga saya lebih memilih turunan dari Vim yang membawa lebih banyak fitur, yaitu [**NeoVim**](https://neovim.io/){:target="_blank"}.

NeoVim juga mendukung mime. Sehingga kita dapat langsung membuka berbagai macam *text format file* dengan menggunakan menu **Open With...** Namun, secara *default* NeoVim meminta kita untuk membuka dengan **XTerm** *terminal emulator*. Yang mana saya tidak begitu suka menggunakan XTerm (subjektif penulis).

Atas dasar ini, saya akan merubah konfigurasi agar NeoVim dapat dibuka pada *terminal emulator* yang saya gunakan. Terkadang saya menggunakan **URXVT**, namun saat ini saya sedang menggunakan **XFCE4-Terminal**.

# Solusi

Kita perlu memindahkan file launcher `vim.desktop` atau `nvim.desktop` -- tergantung kalian menggunakan Vim atau NeoVim. Lokasinya berada pada `/usr/share/applications/`, kita pindahkan ke dalam direktori lokal kita, yaitu `~/.local/share/applications/`.

```
$ cp /usr/share/applications/nvim.desktop /home/bandithijo/.local/share/applications/nvim.desktop
```
Ubah nama direktori user `bandithijo` menjadi nama direktori user kalian.

Lalu edit isi dari `vim.desktop` atau `nvim.desktop` yang berada pada direktori lokal seperti contoh di bawah.

<pre>
[Desktop Entry]
Name=Neovim
Comment=Edit text files
#TryExec=nvim
#Exec=nvim %F
Exec=<mark>xfce4-terminal -x nvim %F</mark>
Terminal=false
Type=Application
Keywords=Text;editor;
Icon=nvim
Categories=Utility;TextEditor;
StartupNotify=false
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
</pre>
Perhatikan pada bagian `Exec=`. Saya men-disable yang lama dengan menjadikannya komentar -- memberi tanda `#` pada bagian awal dari baris. Kemudian membuat `Exec=` baru pada baris di bawahnya yang berisi `xfce4-terminal -x nvim %F`.

Jangan lupa untuk mengeset atribute `Terminal=false` apabila nilainya masih `true`. Karena akan menyebabkan terbukanya dua buah terminal.

Apabila berhasil, nanti akan seperti ini hasilnya.

![gambar1]({{ site.lazyload.logo_blank }}){:data-echo="https://s20.postimg.cc/iupoeprd9/nvim-on-pcmanfm.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Open With Text Format pada PCMANFM File Manager</p>

# Referensi

1. [askubuntu.com/questions/788736/open-vim-in-xfce4-terminal-from-thunar](https://askubuntu.com/questions/788736/open-vim-in-xfce4-terminal-from-thunar){:target="_blank"}
<br>Diakses tanggal: 2018/04/28
