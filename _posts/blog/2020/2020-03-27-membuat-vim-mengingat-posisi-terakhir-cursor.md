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
contributors: []
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

Kita akan menggunakan bantuan viminfo agar dapat mengingat **marks**.

Tanda `"` akan mengingat posisi cursor di dalam buffer saat kita keluar (delete buffer/keluar vim).

{% highlight_caption $HOME/.vimrc %}
{% highlight viml linenos %}
" restore cursor position when opening file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif
{% endhighlight %}

Kira-kira begini penjelasannya,

Jika tanda `"` mengandung nilai **X** line number lebih dari 1 dan tidak lebih dari line number dari baris terakhir di dalam file, maka posisi cursor akan di bawa ke baris **X** tersebut.

Nah, dengan begini, cursor akan tetap berada pada posisi terakhir ketika file atau buffer ditutup.

<br>
![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/1X2HrLyc/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}{:class="myImg"}
<p class="img-caption">Gambar 1 - NeoVim (kiri), Vim (kanan), Posisi kursor berada di baris 59</p>

Kalau teman-teman menggunakan **Vim**, kalian dapat melihan informasi yang disimpan pada `.viminfo`.

Kalau teman-teman menggunakan **NeoVim**, kalian dapat melihat informasi yang disimpan pada **ShaDa File** yang berada di `~/.local/share/nvim/shada/main.shada`.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/v8N3y65g/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}{:class="myImg"}
<p class="img-caption">Gambar 2 - Data disimpan pada ShaDa file di NeoVim (kiri), Data disimpan pada .viminfo pada Vim (kanan)</p>

<!-- PERTANYAAN -->
<div class="blockquote-yellow">
<div class="blockquote-yellow-title">Apa itu ShaDa File?</div>
<p><i>If you exit Vim and later start it again, you would normally lose a lot of information</i>.</p>
<p><i>The ShaDa file can be used to remember that information, which enables you to continue where you left off.  Its name is the abbreviation of <b>SHAred DAta</b> because it is used for sharing data between Neovim sessions</i>.</p>
</div>








# Referensi

1. [github.com/mhinz/vim-galore#restore-cursor-position-when-opening-file](https://github.com/mhinz/vim-galore#restore-cursor-position-when-opening-file){:target="_blank"}
<br>Diakses tanggal: 2020/03/27

2. [StackOverflow - How to make vim restore last cursor position for CURRENT buffer?](https://stackoverflow.com/a/57261040/4862516){:target="_blank"}
<br>Diakses tanggal: 2020/07/11

3. [neovim.io/doc/user/starting.html#shada](https://neovim.io/doc/user/starting.html#shada){:target="_blank"}
<br>Diakses tanggal: 2020/07/11

4. [vim.fandom.com/wiki/Using_marks](https://vim.fandom.com/wiki/Using_marks){:target="_blank"}
<br>Diakses tanggal: 2020/07/11
