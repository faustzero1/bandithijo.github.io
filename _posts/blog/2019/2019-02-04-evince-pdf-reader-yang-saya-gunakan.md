---
layout: 'post'
title: 'Evince, PDF Reader yang Menjadi Favorit Saya Sejak Lama'
date: 2019-02-04 23:24
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
description: "Saya adalah Gnome user sejak GNOME2. Sayangnya, laptop saya saat ini sudah tidak dapat menggunakan GNOME3. Namun, meski demikian, keuntungan dari GNU/Linux adalah kita bebas menggunakan komponen aplikasi yang ada di dalamnya. Evince adalah salah PDF reader yang menjadi default PDF reader di GNOME yang meski saat ini saya sudah menggunakan Window Manager, namun masih tetap saya gunakan. Apa alasannya? Simak catatan dan ulasannya pada artikel ini."
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata
PDF reader adalah salah satu aplikasi yang sudah menjadi kebutuhan saya selain Terminal dan Browser. Saya juga cukup sering menghabiskan waktu sembari membaca-baca *ebook* melalui aplikasi PDF reader.

Setiap dari pengguna distribusi sistem operasi GNU/Linux biasanya memiliki PDF reader favorit masin-masing. Saya pun demikian, memiliki satu PDF reader yang menjadi andalan, yaitu **Evince**.

Apapun *Desktop Environment* yang saya gunakan, seperti: GNOME, XFCE, maupun *Window Manager*, seperti: i3wm, saya tetap menggunakan Evince sebagai PDF reader.

Evince, yang sekarang lebih dikenal dengan **GNOME/Document viewer** adalah salah satu aplikasi pendukung GNOME desktop yang dapat kita pergunakan untuk membuka/membaca dokumen dengan banyak format, yaitu: PDF, PostScript, DjVu, tiff, dvi, XPS, Comic (cbr, cbz, cbt). Untuk daftar lebih lengkap dapat mengunjungi [*Supported Document Formats*](https://wiki.gnome.org/Apps/Evince/SupportedDocumentFormats){:target="_blank"}.

Saya sendiri lebih sering memanfaatkan Evince untuk membuka file dengan format PDF.

Untuk dapat mendukung format PDF, Evince menggunakan *backend* **Poppler**. Poppler adalah kepustakaan yang digunakan untuk merender file PDF yang berbasiskan `xpdf-3.0`.

Meskipun Evince saat ini lebih dikenal dengan <b>Document viewer</b>, namun penggunaan nama <b>evince</b> masih diterapkan dalam beberapa hal seperti: <i>excutable name</i> (<code>Exec=evince</code>), <i>nama paket</i>, dll.

# Instalasi

Untuk memasang **Evince**, biasaya sudah terdapat pada daftar paket-paket yang ada pada **Gnome Desktop**. Namun, kita dapat memasangnya secara independen.

Pilih saja salah satu mana dari paket Evince di bawah yang sesuai untuk teman-teman.

1. [extra/evince](https://www.archlinux.org/packages/extra/x86_64/evince/){:target="_blank"}
2. [aur/evince-no-gnome](https://aur.archlinux.org/packages/evince-no-gnome){:target="_blank"}

**extra/evince**

{% shell_user %}
sudo pacman -S evince
{% endshell_user %}

**aur/evince-no-gnome**
{% shell_user %}
yay -S evince-no-gnome
{% endshell_user %}

# Fitur-fitur

Apa keunggulan dari Evince yang membuat saya menjadikan Evince sebagai PDF reader andalan?

## User Interface yang Sederhana

{% image https://i.postimg.cc/pX1kRpZp/gambar-01.png | 1 | Dual Page %}

{% image https://i.postimg.cc/HLbtw3Cy/gambar-02.png | 2 | Single Page %}

{% image https://i.postimg.cc/GhpzWkvW/gambar-03.png | 3 | Side Pane: Thumbnails (kiri), Outline(tengah), Annotations(kanan) %}

{% image https://i.postimg.cc/sgkcGqbz/gambar-04.png | 4 | Night Mode  %}

{% image https://i.postimg.cc/XYGLJ4Hx/gambar-05.png | 5 | Highlight (Membuat dan Menghapus) %}

## Last Page Read

Evince akan menyimpan halaman terakhir yang kita baca. Sehingga memungkinkan saat kita buka file PDF tersebut, Evince akan menampilkan halaman dimana kita terkahir membaca.

## Keyboard Shortcut yang Mudah

**Navigasi**

Pada area kertas, kita dapat menggunakan navigasi yang mirip seperti Vim.

| Tombol | Fungsi |
|:---: | :--- |
| <kbd>J</kbd> | Scrolling kertas ke bawah |
| <kbd>K</kbd> | Scrolling kertas ke atas |
| <kbd>H</kbd> | Membuka halaman sebelumnya |
| <kbd>L</kbd> | Membuka halaman selanjutnya |

**Zoom in/out**

| Tombol | Fungsi |
|:---: | :--- |
| <kbd>+</kbd> | Zoom in |
| <kbd>-</kbd> | Zoom out |
| <kbd>CTRL</kbd>+<kbd>0</kbd> | Zoom 1:1 |
| <kbd>F</kbd> | Zoom Fit page |
| <kbd>W</kbd> | Zoom Fit width |

**Fungsi Lain-lain**

| Tombol | Fungsi |
|:---: | :--- |
| <kbd>C</kbd> | Contiuous scrolling |
| <kbd>D</kbd> | Toggle single/dual page |
| <kbd>F9</kbd> | Toggle open/close side pane |
| <kbd>CTRL</kbd>+<kbd>i</kbd> | Toggle Night Mode |
| <kbd>CTRL</kbd>+<kbd>L</kbd> | Go to Page Number |
| <kbd>CTRL</kbd>+<kbd>F</kbd> | Menampilkan Search bar |

**Touchpad Gesture**
<div style="clear:both;"></div>
<img style="float:left;" alt="gambar_6" src="{{ site.lazyload.logo_blank }}" data-echo="https://i.postimg.cc/4x5RNvYX/gambar-06.png" onerror="imgError(this);">
<div style="clear:both;"></div>

# Tambahan Konfigurasi

Apabila teman-teman ingin mengatur konfigurasi default Evince dapat menggunakan aplikasi `dconf-editor`.

Alamatnya ada di:
```
/org/gnome/evince/default
```

Di dalam sini terdapat beberapa konfigurasi *default* yang bisa kita atur seprti:
1. continuous
2. dual-page
3. show-sidebar
4. sidebar-size
5. show-toolbar
6. dll.

Maksud dari "*default*" di sini adalah konfigurasi yang akan diterapkan kepada Evince saat pertama kali di jalankan.

# Autoupdate Konten

Apabila teman-teman berurusan dengan edit-mengedit file PDF, misalkan seperti LaTeX yang kemudian dikonversi ke PDF menggunakan `pdflatex`. Maka setelah proses kompilasi `.tex` menjadi `.pdf` selesai, Evince akan langsung mengupdate isi dari file PDF tersebut secara otomatis.

{% image https://i.postimg.cc/6QMYz3K4/gambar-22.png | 7 | Vim (kiri) sebagai LaTeX editor dengan Evince (kanan) %}


# Kekurangan

Kekurangan yang sampai saat ini masih saya rasakan adalah, pada sistem saya, Evince masih belum dapat digunakan untuk *push to print* (ngeprint langsung dari Evince, <kbd>CTRL</kbd>+<kbd>P</kbd>) -- Print Settings Window terbuka, namun tidak berdampak apa-apa saat kita menekan tombol print.

Untuk mengakali ini, saya biasa membuka PDF di Firefox, kemudian baru memanfaatkan fitur print dari PDF reader yang dimiliki oleh Firefox.

# Pesan Penulis

Apabila dari teman-teman mempunyai PDF reader favorit boleh banget direkomendasikan kepada saya. Tentunya yang memiliki fitur setidaknya sama atau ada fitur lebih yang tidak dimiliki oleh Evince.

Saya sudah pernah mencoba **Okular**, namun karena aplikasi Qt, saya kurang begitu senang dengan interface yang terlalu banyak icon. **xpdf**, **mupdf**, terlalu sederhana, tidak ada fitur-fitur yang saya perlukan seperti membuat da menghapus *highlight*.

Sepertinya segini dulu, mudah-mudahan bermanfaat.


# Referensi

1. [wiki.archlinux.org/index.php/GNOME/Document_viewer](https://wiki.archlinux.org/index.php/GNOME/Document_viewer){:target="_blank"}
<br>Diakses tanggal: 2019/02/04

2. [wiki.gnome.org/Apps/Evince](https://wiki.gnome.org/Apps/Evince){:target="_blank"}
<br>Diakses tanggal: 2019/02/04

3. [wiki.gnome.org/Apps/Evince/SupportedDocumentFormats](https://wiki.gnome.org/Apps/Evince/SupportedDocumentFormats){:target="_blank"}
<br>Diakses tanggal: 2019/02/04

4. [poppler.freedesktop.org/](https://poppler.freedesktop.org/){:target="_blank"}
<br>Diakses tanggal: 2019/02/04
