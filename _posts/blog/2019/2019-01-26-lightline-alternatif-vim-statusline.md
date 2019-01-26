---
layout: 'post'
title: 'Lightline, Alternatif Vim Statusline selain Vim-Airline <span class="new">BARU</span>'
date: 2019-01-26 14:34
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Vim', 'Tips']
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="/assets/img/logo/logo_blank_banner.png" data&#45;echo="#" alt="banner"> -->

# Latar Belakang Masalah

Malam tadi, 2019/01/25, tiba-tiba saja saya merasa Vim (teks editor favorit saya) terasa lambat sekali saat proses *startup*.

Saya dapat menyadari kejanggalan ini karena reflek saya setiap sehabis menjalankan perintah <span class="nobr">`$ vim nama_file`</span> selalu menekan tombol <kbd>J</kbd>. Secara bersamaan, *cursor line* yang terdapat di dalam Vim sama sekali tidak bergerak.

Setelah saya amati, statusline yang dihandle oleh `vim-airline` mengalami delay saat proses *startup* ini.

Coba perhatikan perbandingan Vim pada user biasa dan pada user root di bawah ini.

<!-- IMAGE CAPTION -->
![gambar_1](/assets/img/logo/logo_blank.png){:data-echo="https://i.postimg.cc/JzcBJfsM/gambar-01.gif"}
<p class="img-caption">Gambar 1 - Perbandingan startup vim on root dan vim on user</p>

Sisi kiri adalah Vim pada user biasa, perhatikan delay yang terjadi pada Vim-Airline saat proses *startup* berlangsung. Bandingkan dengan sisi kanan, yaitu Vim pada root.

**User biasa**&nbsp;: Statusline terlambat keluar setelah bufferline

**User root**&nbsp;&nbsp;: Statusline berbarengan keluar bersama bufferline

Delay yang dialami oleh statusline pada proses *startup* ini dapat semakin molor apabila file yang dibuka memiliki baris yang panjang dan belum terdapat *cache* atau ada kondisi lain lagi (belum dapat memastikan).

Karena alasan tersebut saya memutuskan untuk memigrasikan `vim-airline` dan mencari alternatif statusline yang lain.

# Pemecahan Masalah

Setelah mencoba beberapa statusline, pilihan saya jatuh pada [**itchyny/lightline**](https://github.com/itchyny/lightline.vim){:target="_blank"}.

Dan untuk menghandle bufferline, saya menggunakan [**mengelbrecht/lightline-bufferline**](https://github.com/mengelbrecht/lightline-bufferline){:target="_blank"}.

Berikut ini adalah gambar perbandingan tampilan antara **Vim-Airline** versus **Lightline** dan **Lightline-Bufferline**.
<!-- IMAGE CAPTION -->
![gambar_2](/assets/img/logo/logo_blank.png){:data-echo="https://i.postimg.cc/05dcfybJ/gambar-02.png"}
<p class="img-caption">Gambar 2 - Vim-Airline (Kiri), Lightline (Kanan)</p>


# Instalasi

Saya menggunakan plugin manager [**vim-plug**](https://github.com/junegunn/vim-plug){:target="_blank"}.
```
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
```

# Konfigurasi

## Ligtline

Pada konfigurasi `lightline` ini saya hanya menambahkan:
1. Colorscheme
2. Menampilkan `git-branch` (membutuhkan [`vim-fugitive`](https://github.com/tpope/vim-fugitive){:target="_blank"})
3. Menggunakan simbol `powerline`
4. Menambahkan konfigurasi buffer dengan menggunakan [`lightline-bufferline`](https://github.com/mengelbrecht/lightline-bufferline){:target="_blank"}
5. Mengkostumisasi tabline sebelah kiri (atas)

Tambahkan konfigurasi di bawah pada `~/.vimrc`.

```python
let g:lightline = {
\   'colorscheme': 'solarized',
\   'active': {
\     'left':[ [ 'mode', 'paste' ],
\              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
\     ]
\   },
\   'component': {
\     'lineinfo': ' %3l:%-2v',
\   },
\   'component_function': {
\     'gitbranch': 'fugitive#head',
\   }
\}
let g:lightline.separator = {
\   'left': '', 'right': ''
\}
let g:lightline.subseparator = {
\   'left': '', 'right': ''
\}
let g:lightline.tabline = {
\   'left': [ ['buffers'] ],
\   'right': [ ['close']]
\}
let g:lightline.component_expand = {
\   'buffers': 'lightline#bufferline#buffers'
\}
let g:lightline.component_type = {
\   'buffers': 'tabsel'
\}
```

Untuk melihat colorscheme dapat menggunakan `:h g:lightline.colorscheme`.

Berikut ini adalah daftar colorscheme yang tersedia:
```
Currently, wombat, solarized, powerline, jellybeans, Tomorrow,
Tomorrow_Night, Tomorrow_Night_Blue, Tomorrow_Night_Eighties,
PaperColor, seoul256, landscape, one, darcula, molokai, materia,
material, OldHope, nord, 16color and deus are available.
```

## Lightline-Bufferline

Untuk mengaktifkan bufferline (tabline), tambahkan di bawahnya.
```
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline
```
Kemudian tambahkan konfigurasi untuk `lightline-bufferline`, namun ini hanya optional saja, karena secara *default* tampilan dari `lightline-bufferline` sudah bagus.

Value yang saya gunakan hampir rata-rata adalah value *default* kecuali `unnamed` saya ganti menjadi `[NO NAME]`, defaultnya adalah `*`.
```
let g:lightline#bufferline#unnamed = "[NO NAME]"
let g:lightline#bufferline#filename_modifier= ":."
let g:lightline#bufferline#more_buffers = "..."
let g:lightline#bufferline#modified = " +"
let g:lightline#bufferline#read_only = " -"
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#show_number = 0
```

# Modifikasi

Beberapa modifikasi yang saya lakukan adalah,

## Colorscheme

Modifikasi terhadap `solarized` colorscheme, saya membuat cetak tebal pada mode dan beberapa bagian.
```
$ vim .vim/plugged/lightline.vim/autoload/lightline/colorscheme/solarized.vim
```
<pre>
...
let s:p.normal.left = [ [ s:base03, s:base1, <mark>'bold'</mark> ], [ s:base03, s:base00 ] ]
let s:p.normal.right = [ [ s:base03, s:base1, <mark>'bold'</mark> ], [ s:base03, s:base00 ] ]
let s:p.inactive.right = [ [ s:base03, s:base00 ], [ s:base0, s:base02 ] ]
let s:p.inactive.left =  [ [ s:base0, s:base02 ], [ s:base0, s:base02 ] ]
let s:p.insert.left = [ [ s:base03, s:yellow, <mark>'bold'</mark> ], [ s:base03, s:base00 ] ]
let s:p.replace.left = [ [ s:base03, s:red, <mark>'bold'</mark> ], [ s:base03, s:base00 ] ]
let s:p.visual.left = [ [ s:base03, s:green, <mark>'bold'</mark> ], [ s:base03, s:base00 ] ]
let s:p.normal.middle = [ [ s:base1, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base01, s:base02 ] ]
let s:p.tabline.left = [ [ s:base03, s:base00, <mark>'bold'</mark> ] ]
let s:p.tabline.tabsel = [ [ s:base03, s:base1, <mark>'bold'</mark> ] ]
let s:p.tabline.middle = [ [ s:base0, s:base02 ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:base03, s:red, <mark>'bold'</mark> ] ]
let s:p.normal.warning = [ [ s:base03, s:yellow, <mark>'bold'</mark> ] ]
</pre>

## Tabline

Modifikasi yang saya lakukan adalah merubah dan menambah **tabline** sebelah kanan atas. Yang sebelumnya hanya menampilkan tanda **X**, saya rubah menjadi menampilkan **BUFFERS** dan **BANDITHIJO.COM**.

Terdapat 3 baris yang saya modifikasi.

```
$ vim .vim/plugged/lightline.vim/autoload/lightline.vim
```

<br>
**Periksa pada line 97**.
<pre>
\   'tabline': {
\     'left': [['tabs']],
\     'right': <mark>[['string1'], ['string2']]</mark>
\   },
</pre>
Saya merubah nilai `close` menjadi `string1` dan `string2`.

<br>
**Periksa pada line 109**.
<pre>
\     'lineinfo': '%3l:%-2v', 'line': '%l', 'column': '%c', <mark>'string1': '%999X BANDITHIJO.COM ', 'string2': '%999X BUFFERS '</mark>, 'winnr': '%{winnr()}'
</pre>
Saya mengganti `'close': '%999X X'` menjadi seperti di atas.

<br>
**Perhatikan line 120**.
<pre>
\   'component_type': {
\     'tabs': 'tabsel', <mark>'string1': 'raw', 'string2': 'raw',</mark>
\   },
</pre>
Saya mengganti `'close': 'raw'` menjadi seperti di atas.

# Hasilnya
<!-- IMAGE CAPTION -->
![gambar_3](/assets/img/logo/logo_blank.png){:data-echo="https://i.postimg.cc/TwHHXRWc/gambar-03.png"}
<p class="img-caption">Gambar 3 - Lightline + Lightline-Bufferline</p>

# Pesan Penulis

Saya memutuskan untuk bermigrasi bukan berarti `vim-airline` tidak bagus dan berat. Hanya saja, pada kasus saya, saya mengalami "startup delay" yang entah dari mana datangnya tiba-tiba menghampiri Vim saya.

Kesempatan ini saya pergunakan untuk berekplorasi dengan statusline plugin yang lain, selain dari `vim-airline` yang tersohor. Hehehe.

Sebaik-baik dokumentasi adalah yang ditulis oleh developer pengembang dari masing-masing plugin. Silahkan kunjungin GitHub pages dari masing-masing plugin untuk penjelasan yang lebih kompleks.



# Referensi

1. [github.com/itchyny/lightline.vim](https://github.com/itchyny/lightline.vim){:target="_blank"}
<br>Diakses tanggal: 2019/01/26

2. [github.com/mengelbrecht/lightline-bufferline](https://github.com/mengelbrecht/lightline-bufferline){:target="_blank"}
<br>Diakses tanggal: 2019/01/26

