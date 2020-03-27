---
layout: 'post'
title: "Membuat Vim Mengingat Posisi Terakhir Cursor"
date: 2020-03-27 16:38
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Vim']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Pendahuluan

Saya memerlukan fungsi dimana setiap file yang sudah pernah di buka, kemudian saya meninggalkan posisi cursor pada baris dan kolom tertentu, maka saat file tersebut dibuka kembali, saya menginginkan cursor masih berada pada posisi yang sama.

Hal ini dengan mudah dapat dilakukan oleh plugin bernama:

1. [restore_view.vim](https://github.com/vim-scripts/restore_view.vim){:target="_blank"}
2. [restoreview](https://github.com/senderle/restoreview){:target="_blank"}

*This is plugin for automatically restore one file's cursor position and folding information after restart vim.*

# Permasalahan

Saya menggunakan plugin **lightline** untuk menghandle statusline.

Nah, kedua plugin ini pasti menggunakan `:loadview` untuk me-load *folding* secara ototmatis ketika file dibuka.

Dampak dari penggunaan `:loadview` terhadap **lightline** adalah, statusline active tidak dapat berpindah secara otomatis.

Apabila terdapat dua buffer, maka statusline yang aktif hanya buffer yang terakhir. Sedangkan buffer sebelumnya menjadi inactive.

Maka dari itu saya memilih untuk tidak menggunakan kedua plugin tersebut. Karena fitur yang saya perlukan hanya "*restore cursor position*".

# Pemecahan Masalah

Cukup tambahkan konfigurasi berikut ini pada `.vimrc`.

```viml
" restore cursor position when opening file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif
```

Nah, dengan begini, cursor akan tetap berada pada posisi terakhir ketika file ditutup.









# Referensi

1. [github.com/mhinz/vim-galore#restore-cursor-position-when-opening-file](https://github.com/mhinz/vim-galore#restore-cursor-position-when-opening-file){:target="_blank"}
<br>Diakses tanggal: 2020/03/27
