---
layout: 'post'
title: 'Lightline, Alternatif Vim Statusline selain Vim-Airline'
date: 2019-01-26 14:34
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Vim', 'Tips', 'Ulasan']
pin:
hot:
contributors: []
---

<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/wernight/powerline-web-fonts@ba4426cb0c0b05eb6cb342c7719776a41e1f2114/PowerlineFonts.css">
<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

<br>
<!-- OUTDATED POST -->
<p class="notif-post" style="margin-bottom: -20px;">Post ini sudah tidak up to date !</p>

Post terbaru ada di sini: [**Lightline, Alternatif Vim Statusline Bagian 2 (feat. Defx)**](/blog/lightline-alternatif-vim-statusline-part-2){:target="_blank"}.

# Latar Belakang Masalah

Malam tadi, 2019/01/25, tiba-tiba saja saya merasa Vim (teks editor favorit saya) terasa lambat sekali saat proses *startup*.

Saya dapat menyadari kejanggalan ini karena reflek saya setiap sehabis menjalankan perintah <span class="nobr">`$ vim nama_file`</span> selalu menekan tombol <kbd>J</kbd>. Secara bersamaan, *cursor line* yang terdapat di dalam Vim sama sekali tidak bergerak.

Setelah saya amati, statusline yang dihandle oleh `vim-airline` mengalami delay saat proses *startup* ini.

Coba perhatikan perbandingan Vim pada user biasa dan pada user root di bawah ini.

<!-- IMAGE CAPTION -->
![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/JzcBJfsM/gambar-01.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 1 - Perbandingan startup Vim pada root dan Vim pada user</p>

Sisi kanan adalah Vim pada user biasa, perhatikan delay yang terjadi pada Vim-Airline saat proses *startup* berlangsung. Bandingkan dengan sisi kiri, yaitu Vim pada root.

**User biasa**&nbsp;: Statusline terlambat keluar setelah bufferline

**User root**&nbsp;&nbsp;: Statusline berbarengan keluar bersama bufferline

Delay yang dialami oleh statusline pada proses *startup* ini dapat semakin molor apabila file yang dibuka memiliki baris yang panjang dan belum terdapat *cache* atau ada kondisi lain lagi (belum dapat memastikan).

Karena alasan tersebut saya memutuskan untuk memigrasikan `vim-airline` dan mencari alternatif statusline yang lain.

# Pemecahan Masalah

Setelah mencoba beberapa statusline, pilihan saya jatuh pada [**itchyny/lightline**](https://github.com/itchyny/lightline.vim){:target="_blank"}.

Dan untuk menghandle bufferline, saya menggunakan [**mengelbrecht/lightline-bufferline**](https://github.com/mengelbrecht/lightline-bufferline){:target="_blank"}.

Berikut ini adalah gambar perbandingan tampilan antara **Vim-Airline** versus **Lightline** dan **Lightline-Bufferline**.

<!-- IMAGE CAPTION -->
![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/05dcfybJ/gambar-02.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 2 - Vim-Airline (Kiri), Lightline (Kanan)</p>

<!-- IMAGE CAPTION -->
![gambar_7]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/wB5t1V5t/gambar-07.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 3 - Startup dengan Vim-Airline</p>

<!-- IMAGE CAPTION -->
![gambar_8]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/j5sDP7vM/gambar-08.gif" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 4 - Startup dengan Lightline</p>

<!-- IMAGE CAPTION -->
![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/2SDs8SVk/gambar-05.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 5 - Vim-Airline</p>

<!-- IMAGE CAPTION -->
![gambar_6]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/52SZHWCw/gambar-06.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 6 - Lightline</p>


# Instalasi

Saya menggunakan plugin manager [**vim-plug**](https://github.com/junegunn/vim-plug){:target="_blank"}.
```
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
```

# Konfigurasi

## Lightline

Pada konfigurasi `lightline` ini saya hanya menambahkan:
1. Colorscheme modifikasi dari `solarized` Lightline theme
2. Menampilkan `git-branch` (membutuhkan [`vim-fugitive`](https://github.com/tpope/vim-fugitive){:target="_blank"})
3. Menggunakan simbol `powerline`
4. Menambahkan konfigurasi buffer dengan menggunakan [`lightline-bufferline`](https://github.com/mengelbrecht/lightline-bufferline){:target="_blank"}
5. Mengkostumisasi tabline sebelah kiri (atas)
6. Menambahkan Devicons, perlu plugin `ryanoasis/vim-devicons`.

Tambahkan konfigurasi di bawah pada `~/.vimrc`.

```viml
let g:lightline = {
\   'colorscheme': 'solarized',
\   'active': {
\    'left' :[[ 'mode', 'paste' ],
\             [ 'readonly' ],
\             [ 'filename', 'modified' ]],
\    'right':[[ 'lineinfo' ],
\             [ 'percent' ],
\             [ 'filetype', 'fileencoding', 'fileformat' ]]
\   },
\   'component': {
\     'lineinfo': ' %3l:%-2v',
\   },
\   'component_function': {
\     'fugitive': 'fugitive#head',
\   }
\}
let g:lightline.separator = {
\   'left': '', 'right': ''
\}
let g:lightline.subseparator = {
\   'left': '', 'right': ''
\}
let g:lightline.tabline = {
\   'left': [['buffers']],
\   'right': [['close']]
\}
let g:lightline.component_expand = {
\   'buffers': 'lightline#bufferline#buffers'
\}
let g:lightline.component_type = {
\   'buffers': 'tabsel'
\}
```

<!-- PERHATIAN -->
<div class="blockquote-red">
<div class="blockquote-red-title">[ ! ] Perhatian</div>
<p>Beberapa karakter <b>Powerline</b> mungkin mengalami gagal rendering pada Browser. Namun apabila dicopy-paste ke Terminal, tetap dapat ditampilkan dengan benar.</p>
<p>Apabila tidak berhasil, coba copy-paste secara manual output dari command di bawah ke dalam <code>.vimrc</code> di atas.</p>
<pre>
$ echo -e "\ue0a1 \ue0b0 \ue0b1 \ue0b2 \ue0b3"
</pre>
</div>

Untuk melihat colorscheme dapat menggunakan `:h g:lightline.colorscheme`.

Berikut ini adalah daftar colorscheme yang tersedia:
```
Currently, wombat, solarized, powerline, jellybeans, Tomorrow,
Tomorrow_Night, Tomorrow_Night_Blue, Tomorrow_Night_Eighties,
PaperColor, seoul256, landscape, one, darcula, molokai, materia,
material, OldHope, nord, 16color and deus are available.
```

## Lightline-Bufferline

Buat apa kita perlu `Lightline-Bufferline` ?

Apabila kita hanya menggunakan `Lightline` saja, maka buffer yang terdapat di pojok kiri atas hanya akan ditampilkan satu buah. Karena ini, kita memerlukan `Lightline-Bufferline` untuk menampilkan buffer yang terbuka.

Untuk mengaktifkan bufferline (tabline), tambahkan di bawahnya.
```viml
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline
```
Kemudian tambahkan konfigurasi untuk `lightline-bufferline`, namun ini hanya optional saja, karena secara *default* tampilan dari `lightline-bufferline` sudah bagus.

Value yang saya gunakan hampir rata-rata adalah value *default* kecuali `unnamed` saya ganti menjadi `[NO NAME]`, defaultnya adalah `*`.
```viml
let g:lightline#bufferline#unnamed = "[NO NAME]"
let g:lightline#bufferline#filename_modifier= ":."
let g:lightline#bufferline#more_buffers = "..."
let g:lightline#bufferline#modified = " ●"
let g:lightline#bufferline#read_only = " "
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unicode_symbols = 1
```

# Modifikasi

Beberapa modifikasi yang saya lakukan adalah,

## Colorscheme

Modifikasi terhadap `solarized` colorscheme.

Saya akan menduplikasi (Copy) dan mengganti namanya, agar tetap mempertahankan theme solarized default dari Lightline.

```
$ cd .vim/plugged/lightline.vim/autoload/lightline/colorscheme/
$ cp solarized.vim lightline_solarized.vim
```

Saya akan memodifikasi beberapa bagian.

```
$ vim lightline_solarized.vim
```
<pre>
" =============================================================================
" Filename: autoload/lightline/colorscheme/<mark>lightline_solarized.vim</mark>
" Author: itchyny
" License: MIT License
" Last Change: 2017/11/25 11:13:46.
" =============================================================================
...
...

" The following condition only applies for the console and is the same
" condition vim-colors-solarized uses to determine which set of colors
" to use.
let s:<mark>lightline_solarized_termcolors</mark> = get(g:, 'solarized_termcolors', 256)
if s:<mark>lightline_solarized_termcolors</mark> != 256 && &t_Co >= 16
  let s:cuiindex = 0
elseif s:<mark>lightlinesolarized_termcolors</mark> == 256
  let s:cuiindex = 1
else
  let s:cuiindex = 2
endif

let s:p.normal.left = [ [ s:base03, <mark>s:base1</mark>, <mark>'bold'</mark> ], [ s:base03, s:base00 ] ]
let s:p.normal.right = [ [ s:base03, s:base1, <mark>'bold'</mark> ], [ s:base03, s:base00 ] ]
let s:p.inactive.right = [ [ <mark>s:base02</mark>, s:base00 ], [ <mark>s:base02, s:base00</mark> ] ]
let s:p.inactive.left =  [ [ <mark>s:base02</mark>, s:base00 ], [ <mark>s:base02, s:base00</mark> ] ]
let s:p.insert.left = [ [ s:base03, <mark>s:yellow, 'bold'</mark> ], [ s:base03, s:base00 ] ]
let s:p.replace.left = [ [ s:base03, s:red, <mark>'bold'</mark> ], [ s:base03, s:base00 ] ]
let s:p.visual.left = [ [ s:base03, <mark>s:green, 'bold'</mark> ], [ s:base03, s:base00 ] ]
let s:p.normal.middle = [ [ s:base1, s:base02 ] ]
let s:p.inactive.middle = [ [ <mark>s:base02, s:base00</mark> ] ]
let s:p.tabline.left = [ [ s:base03, s:base00, <mark>'bold'</mark> ] ]
let s:p.tabline.tabsel = [ [ s:base03, s:base1, <mark>'bold'</mark> ] ]
let s:p.tabline.middle = [ [ s:base0, s:base02 ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:base03, s:red, <mark>'bold'</mark> ] ]
let s:p.normal.warning = [ [ s:base03, s:yellow, <mark>'bold'</mark> ] ]

let g:lightline#colorscheme#<mark>lightline_solarized</mark>#palette = lightline#colorscheme#flatten(s:p)
</pre>

## Tabline

Modifikasi yang saya lakukan adalah merubah dan menambah **tabline** sebelah kanan atas. Yang sebelumnya hanya menampilkan tanda **X**, saya rubah menjadi menampilkan **BUFFERS** dan **BANDITHIJO.COM**.

Cari baris di bawah ini.

```viml
let g:lightline.tabline = {
\   'left': [ ['buffers'] ],
\   'right': [ ['close'] ]
\}
```

Ubah `'close'` menjadi `'string1'` dan `'string2'`.

```viml
let g:lightline.tabline = {
\   'left': [ ['buffers'] ],
\   'right': [ ['string1'], ['string2'] ]
\}
```

Tambahkan pada `.component_expand`.

```viml
let g:lightline.component_expand = {
\   'buffers': 'lightline#bufferline#buffers',
\   'string1': 'String1',
\   'string2': 'String2'
\}
```

Kemudian tambahkan fungsi di bawah.

```viml
function! String1()
  return 'BANDITHIJO.COM'
endfunction

function! String2()
  return 'BUFFERS'
endfunction
```

# Hasilnya
<!-- IMAGE CAPTION -->
![gambar_7]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/TwHHXRWc/gambar-03.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 7 - Lightline + Lightline-Bufferline</p>

<!-- IMAGE CAPTION -->
![gambar_8]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/yxfHSq5Q/gambar-04.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 8 - Tampilan saat tidak sibuk</p>

# Tambahan Fugitive, Readonly, Modified, FileFormat, dan FileType

Kita juga dapat menambahkan simbol untuk **vim-fugitive** dan **readonly** agar lebih mirip lagi dengan **vim-airline**.

**Perhatikan baik-baik**, saya melakukan modifikasi pada beberapa bagian.

Bagian yang saya *marking* kuning adalah bagian-bagian yang saya modifikasi dari konfigurasi sebelumnya (di atas).


<pre>
let g:lightline = {
\   'colorscheme': <mark>'lightline_solarized',</mark>
\   'active': {
\    'left' :[[ 'mode', 'paste' ],
\             [ <mark>'fugitive'</mark>, 'readonly' ],
\             [ 'filename', 'modified' ]],
\    'right':[[ 'lineinfo' ],
\             [ 'percent' ],
\             [ 'filetype', 'fileencoding', 'fileformat' ]]
\   },
\   'component': {
\     'lineinfo': ' %3l:%-2v',
\     <mark>'filename': '%<%f'</mark>
\   },
\   'component_function': {
\     'fugitive': <mark>'LightlineFugitive',</mark>
\     <mark>'readonly': 'LightlineReadonly',</mark>
\     <mark>'modified': 'LightlineModified',</mark>
\     <mark>'fileformat': 'LightlineFileformat',</mark>
\     <mark>'filetype': 'LightlineFiletype',</mark>
\   }
\}
let g:lightline.separator = {
\  'left': '', 'right': ''
\}
let g:lightline.subseparator = {
\   'left': '', 'right': ''
\}
let g:lightline.tabline = {
\   'left': [['buffers']],
\   'right': <mark>[['string1'], ['string2']]</mark>
\}
let g:lightline.component_expand = {
\   'buffers': 'lightline#bufferline#buffers',
\   <mark>'string1': 'String1',</mark>
\   <mark>'string2': 'String2'</mark>
\}
\}
let g:lightline.component_type = {
\   'buffers': 'tabsel'
\}

<mark>function! LightlineModified()
  return &modified ? '●' : ''
endfunction

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return fugitive#head()
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! String1()
  return 'BANDITHIJO.COM'
endfunction

function! String2()
  return 'BUFFERS'
endfunction

" autoreload
command! LightlineReload call LightlineReload()

function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline</mark>
</pre>

Pada bagian `'right': [['string1'], ['string2']]` juga sudah saya lakukan modifikasi dari yang sebelumnya `'right': [['close']]` pada bagian [Tabline]({{ site.url }}/blog/lightline-alternatif-vim-statusline#tabline){:target="_blank"}.

Saya juga melakukan modifikasi terhadap `modified` indikator yang tadinya `+` saya ubah agar lebih terlihat jelas menjadi `●`.

Juga penambahan Devicons pada Filetype dan Fileformat.

**Hasilnya**,
<!-- IMAGE CAPTION -->
![gambar_9]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/TPc2p3Zj/gambar-09.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 9 - Dengan tambahan powerline symbol untuk master dan readonly</p>

![gambar_10]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/CKn1Fgcd/gambar-10.png" onerror="imgError(this);"}{:class="myImg"}
<p class="img-caption">Gambar 10 - Dengan penambahan Devicon pada Filetype dan Fileformat</p>


# Pesan Penulis

Saya memutuskan untuk bermigrasi bukan berarti `vim-airline` tidak bagus dan berat. Hanya saja, pada kasus saya, saya mengalami "startup delay" yang entah dari mana datangnya tiba-tiba menghampiri Vim saya.

Kesempatan ini saya pergunakan untuk berekplorasi dengan statusline plugin yang lain, selain dari `vim-airline` yang tersohor. Hehehe.

Sebaik-baik dokumentasi adalah yang ditulis oleh developer pengembang dari masing-masing plugin. Silahkan kunjungin GitHub pages dari masing-masing plugin untuk penjelasan yang lebih kompleks.


# Referensi

1. [github.com/itchyny/lightline.vim](https://github.com/itchyny/lightline.vim){:target="_blank"}
<br>Diakses tanggal: 2019/01/26

2. [github.com/mengelbrecht/lightline-bufferline](https://github.com/mengelbrecht/lightline-bufferline){:target="_blank"}
<br>Diakses tanggal: 2019/01/26

