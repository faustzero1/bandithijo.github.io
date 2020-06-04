---
layout: 'post'
title: "Konfigurasi Vimrc yang Modular"
date: 2020-06-01 21:15
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

Kira-kira 27 Maret 2020 yang lalu, saya berdiskusi dengan **M. Nabil Adani** ([@mnabila](https://t.me/mnabila){:target="_blank"}) perihal akan ikut memigrasikan konfigurasi vim --lebih tepatnya Neovim-- saya menjadi modular. Kali ini saya tidak bisa menunda, karena saya menemukan masalah terhadap lightline saya yang mengalami error saat berpindah-pindah buffer.

Jadi, untuk mencari penyebab dari permasalahan tersebut, saya memilih menggunakan cara modular, yang mana --asumsi saya-- nantinya, saya dapat menelusuri modul-modul mana yang ternyata menyebabkan masalah tersebut.

# Dasar Teori

Untuk teori vimrc modular ini saya belum menelusuri lebih jauh. Tulisan ini saya buat hanya sebagai catatan dan bukan sebagai referensi.

Dasar atau panduan saya membuat vimrc menjadi modular ini adalah catatan yang diberikan oleh **@mnabila**.

# Struktur Direktori

Memodularkan konfigurasi vim (vimrc), bisa dikatakan mengelompokkan konfigurasi berdasarkan fungsi-fungsi yang bersesuaian satu dengan yang lainnya baik dalam bentuk file maupun direktori.

Berikut ini adalah struktur direktori yang saya pergunakan, saya sedikit melakukan penyesuaian dari yang direkomendasi oleh **@mnabila**.

1. **autoload/**<br>
Direktori ini saya pergunakan, apabila terdapat plugin yang mengharuskan untuk menambahkan konfigurasi pada autoload.

2. **colors/**<br>
Direktori ini biasa saya gunakan untuk menyimpan colorscheme hasil modifikasi saya.

3. **doc/**<br>
Biasanya plugin menyertakan dokumentasi. Kita dapat pula mnyimpan secara terpisah, pada direktori ini. Namun saya jarang melakukannya.

4. **init.d/**<br>
Direktori ini berisi pecahan konfigurasi yang sebagian besar ada di vimrc.

5. **plugin/**<br>
Direktori ini berisi konfigurasi dari masing-masing plugin. Penamaan file di dalamnya bebas. Contoh: `name_of_plugin.vim`.

6. **syntax/**<br>
Direktori ini saya gunakan untuk menambahkan file sintaks tanpa perlu menggunakan plugin.

# Penerapan

Nah, dari struktur direktori di atas, saya tinggal memecah-mecah isi dari konfigurasi-konfigurasi yang ada di dalam vimrc saya, yang kira-kira berisi 1500an baris. Hehehe =P

Kemudian saya akan mapping dan distribusikan seperti ini.

<pre>
<b>~/.config/nvim/</b>
├── <b>autoload/</b>
│   ├── buffer.vim
│   └── nrrwrgn.vim
├── <b>colors/</b>
│   ├── <b>lightline/</b>
│   │   ├── codedark.vim
│   │   └── dwm.vim
│   ├── codedark.vim
│   └── Tomorrow-Night-Bandit.vim
├── <b>doc/</b>
├── <b>init.d/</b>
│   ├── filetype.vim
│   ├── formating.vim
│   ├── keybinding.vim
│   ├── plugin.vim
│   └── settings.vim
├── <b>plugin/</b>
│   ├── autoscroll.vim
│   ├── config-coc-snippets.vim
│   ├── config-coc.vim
│   ├── config-emmet-vim.vim
│   ├── config-fzf.vim
│   ├── config-greplace.vim
│   ├── config-indentline.vim
│   ├── config-languagetool.vim
│   ├── config-lightline-bufferline.vim
│   ├── config-lightline.vim
│   ├── config-markdown-preview.vim
│   ├── config-nerdtree.vim
│   ├── config-pgsql.vim
│   ├── config-pylint.vim
│   ├── config-python-mode.vim
│   ├── config-restore-view.vim
│   ├── config-rubycomplete.vim
│   ├── config-tagbar.vim
│   ├── config-vim-commentary.vim
│   ├── config-vim-devicons.vim
│   ├── config-vim-gutter.vim
│   ├── config-vim-orgmode.vim
│   ├── config-vim-table-mode.vim
│   ├── config-vimtex.vim
│   ├── NrrwRgn.vim
│   └── taglist.vim
├── <b>syntax/</b>
│   ├── coffee.vim
│   ├── eruby.vim
│   ├── litcoffee.vim
│   ├── pgsql.vim
│   └── sh.vim
├── coc-settings.json
├── init.vim
└── README.md
</pre>

Isi yang ada di dalam file-file di dalam struktur direktori di atas bebas saja.

Yang paling penting adalah proses sourcing di dalam file **init.vim**.

<pre>
source $HOME/.config/nvim/init.d/<b>settings.vim</b>
source $HOME/.config/nvim/init.d/<b>formating.vim</b>
source $HOME/.config/nvim/init.d/<b>plugin.vim</b>
source $HOME/.config/nvim/init.d/<b>filetype.vim</b>
source $HOME/.config/nvim/init.d/<b>keybinding.vim</b>
</pre>

Hanya perlu melakukan sourcing pada file **.vim** yang ada pada direktori **init.d/**.

Selesai!

Untuk contoh lebih detail dan lebih lengkap, mungkin dapat melihat langsung pada konfigurasi yang saya simpan di GitHub, [di sini](https://github.com/bandithijo/nvimrc){:target="_blank"}

<div class="blockquote-blue">
<div class="blockquote-blue-title">[ i ] Informasi</div>
<p>Saya tidak lagi menggunakan file <code>~/.vimrc</code>. Karena konfigurasi modular di atas, tidak memerlukan vimrc.</p>
</div>

# Pesan Penulis

Sepertinya segini saja yang dapat saya catat.

Mungkin lain waktu akan ada perbaikan dan pembaharuan.

Silahkan merujuk dan membaca-baca sumber referensi yang saya sertakan di bawah.

Mudah-mudahan dapat bermanfaat buat teman-teman.

Terima kasih.

(^_^)



# Referensi

1. [gist.github.com/mnabila/112d8770475bb3cb6ce59b076fb1d123](https://gist.github.com/mnabila/112d8770475bb3cb6ce59b076fb1d123){:target="_blank"}
<br>Diakses tanggal: 2020/06/01

2. [www.sthu.org/code/codesnippets/vimconf.html](https://www.sthu.org/code/codesnippets/vimconf.html){:target="_blank"}
<br>Diakses tanggal: 2020/06/01
