---
layout: 'post'
title: "Defx, Alternatif Vim File Explorer selain NERDTree"
date: 2020-10-27 05:41
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Ulasan', 'Vim']
pin:
hot:
contributors: []
resume:
---

# Latar Belakang

Di Vim "world", ada beberapa nama-nama plugin yang sudah tersohor di kalangan pengguna Vim. Dan biasanya menjadi plugin pilihan pertama oleh Vim user ketika baru bargabung dengan komunitas Vim. Tentu saja, yang menyebabkan hal tersebut adalah, karena biasanya di dalam tutorial, baik blog maupun vlog yang mereka lihat menginformasikan untuk memasang nama-nama plugin tersebut.

Salah satu plugin tersohor tersebut adalah NERDTree. NERDTree digunakan sebagai file explorer pengganti Netrw (default vim file explorer).

Saya pun, sejak awal menggunakan Vim, sudah menggunakan NERDTree, sampai-sampai saya tidak mengetahui bagaimana cara menggunakan Netrw.

Catatan kali ini tentang, proses migrasi saya dari NERDTree ke Defx.nvim.

Menurut yang tertulis di halaman GitHub README dari Defx, plugin ini diciptakan untuk menggantikan vimfiler yang sudah deprecated.

Penjelasan mengenai konsep dari Defx, dapat teman-teman baca [di sini](https://github.com/Shougo/defx.nvim/blob/master/README.md){:target="_blank"}.

# Requirement

`Neovim 0.4.0+` atau `Vim8.2+` dengan `Python3.6.1+`.

# Instalasi

Saya menggunakan **vim-plug** sebagai plugin manager.

```vimscript
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
```

Saya juga menambahkan 2 plugin tambahan untuk icon dan git status.

```vimscript
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'
```

# Konfigurasi Defx

Jangan kaget, kalau di halaman GitHub README tidak tersedia contoh-contoh konfigurasi.

Teman-teman dapat melihat contoh konfigurasi pada:

<pre>
<b>:help defx-examples</b>
</pre>

Namun, pada catatan kali ini, saya akan langsung memberikan konfigurasi yang saya pergunakan.

{% highlight_caption $HOME/.config/nvim/init.vim %}
{% highlight vimscript linenos %}
if exists('g:plugs["defx.nvim"]')
  autocmd FileType     defx call s:defx_my_settings()
  autocmd BufWritePost *    call defx#redraw()
  autocmd BufEnter     *    call s:open_defx_if_directory()

  call defx#custom#option('_', {
    \ 'winwidth'           : 40,
    \ 'split'              : 'vertical',
    \ 'direction'          : 'topleft',
    \ 'buffer_name'        : 'defx',
    \ 'columns'            : 'git:indent:icons:filename',
    \ 'show_ignored_files' : 0,
    \ 'toggle'             : 1,
    \ 'resume'             : 1,
    \ 'auto_cd'            : 1,
    \ })

  call defx#custom#column('icon', {
    \ 'directory_icon' : ' ',
    \ 'opened_icon'    : ' ',
    \ })

  call defx#custom#column('filename', {
    \ 'min_width': 40,
    \ 'max_width': 1000,
    \ })

  " Open Defx when open a directory
  function! s:open_defx_if_directory()
    try
      let l:full_path = expand(expand('%:p'))
    catch
      return
    endtry

    if isdirectory(l:full_path)
      execute "Defx `expand('%:p')` | bd " . expand('%:r')
    endif
  endfunction

  function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR> defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
    nnoremap <silent><buffer><expr> <2-LeftMouse>
    \ defx#do_action('drop')
    nnoremap <silent><buffer><expr> <2-RightMouse>
    \ defx#do_action('open_or_close_tree')
    nnoremap <silent><buffer><expr> c
    \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
    \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
    \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> V
    \ defx#do_action('drop', 'vsplit')
    nnoremap <silent><buffer><expr> S
    \ defx#do_action('drop', 'split')
    nnoremap <silent><buffer><expr> P
    \ defx#do_action('open', 'pedit')
    nnoremap <silent><buffer><expr> o
    \ defx#do_action('open_or_close_tree')
    nnoremap <silent><buffer><expr> K
    \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N
    \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M
    \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> T
    \ defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> d
    \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> r
    \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> !
    \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x
    \ defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yp
    \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
    \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ;
    \ defx#do_action('repeat')
    nnoremap <silent><buffer><expr> <Backspace>
    \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~
    \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q
    \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space>
    \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
    \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j
    \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
    \ line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-r>
    \ defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>
    \ defx#do_action('print')
    nnoremap <silent><buffer><expr> cd
    \ defx#do_action('change_vim_cwd')
  endfunction

endif
{% endhighlight %}

# Penjelasan

```vimscript
autocmd FileType defx call s:defx_my_settings()
```

Baris di atas bertujuan untuk memanggil fungsi `s:defx_my_settings` apabila file type dari buffer yang dibuka bernilai `defx`.

<br>
```vimscript
autocmd BufWritePost * call defx#redraw()
```

Baris di atas bertujuan untuk memanggil fungsi `defx#redraw()` apabila seluruh buffer sudah di-write ke file --mungkin maksudnya di-save.

<br>
```vimscript
autocmd BufEnter * call s:open_defx_if_directory()
```

Baris di atas bertujuan untuk memanggil fungsi `s:open_defx_if_directory()` ketika vim dipanggil dengan atribut bernilai direktori misal: `$ vim .config/nvim`.

<br>
```vimscript
call defx#custom#option('_', {
  \ 'winwidth'           : 40,
  \ 'split'              : 'vertical',
  \ 'direction'          : 'topleft',
  \ 'buffer_name'        : 'defx',
  \ 'columns'            : 'git:indent:icons:filename',
  \ 'show_ignored_files' : 0,
  \ 'toggle'             : 1,
  \ 'resume'             : 1,
  \ 'auto_cd'            : 1,
  \ })
```

Baris di atas bertujuan untuk mengkonfigurasi fungsi `defx#custom#option()`.

Saya akan menjelaskan bagian-bagian yang sekiranya tidak dipahami,

`winwidth`, untuk membuat vertical split selebar 40px.

`toggle`, untuk mengaktifkan fitur toggling, apabila `:Defx` dipanggil.

`columns`, untuk mendefisikan apa saja isi (konten) dari column `defx`.

`resume`, untuk mengaktifkan fitur resume --artinya, abaila kita menutup buffer Defx dan membukanya kembali, Defx akan mengingat posisi terakhir cursor kita berada.

`auto_cd`, untuk mengaktifkan fungsi berganti direktori (*change directory*) ketika menafigasikan Defx untuk masuk atau keluar dari direktori. Catatan: hanya berfungsi apabila menggunakan fungsi `defx#do_action('drop')`.

<br>
```vimscript
call defx#custom#column('icon', {
  \ 'directory_icon' : ' ',
  \ 'opened_icon'    : ' ',
  \ })
```

Baris di atas berfungsi untuk menghilangkan tanda panah yang secara default disertakan oleh Defx. Hal ini saya lakukan karena saya menggunakan plugin defx-icons yang akan memberikan icon-icon pada setiap direktori dan file.

<br>
```vimscript
call defx#custom#column('filename', {
  \ 'min_width': 40,
  \ 'max_width': 1000,
  \ })
```

Baris di atas bertujuan untuk menghandle minimal & maximal lebar dari window pane agar filename tidak terpotong (*truncated*).
<pre class="url">
ini adalah judul yang sangat...panjang sekali.md
</pre>

<br>
```vimscript
function! s:open_defx_if_directory()
  try
    let l:full_path = expand(expand('%:p'))
  catch
    return
  endtry

  if isdirectory(l:full_path)
    execute "Defx `expand('%:p')` | bd " . expand('%:r')
  endif
endfunction
```

Baris di atas bertujuan untuk mendefisikan fungsi `s:open_defx_if_directory()`. Fungsi ini digunakan untuk menghandle Defx agar terbuka ketika vim digunakan untuk membuka direktori --bukan file.

Catatan: masih terdapat banyak kekurangan pada fungsi ini.

<br>
```vimscript
function! s:defx_my_settings() abort
  ...
endfunction
```

Baris di atas bertujuan untuk mendefinisikan keyboard mapping yang digunakan.

Kita dapat merubah-rubah sesuai preferensi pribadi masing-masing.

# Konfigurasi Defx-icons

{% highlight_caption $HOME/.config/nvim/init.vim %}
{% highlight vimscript linenos %}
" defx-icons

let g:defx_icons_enable_syntax_highlight = 1
let g:defx_icons_column_length           = 2
let g:defx_icons_directory_icon          = ''
let g:defx_icons_mark_icon               = ''
let g:defx_icons_copy_icon               = ''
let g:defx_icons_move_icon               = ''
let g:defx_icons_parent_icon             = ''
let g:defx_icons_default_icon            = ''
let g:defx_icons_directory_symlink_icon  = ''

" Options below are applicable only when using 'tree' feature
let g:defx_icons_draw_tree_structure     = 1
let g:defx_icons_root_opened_tree_icon   = ''
let g:defx_icons_nested_opened_tree_icon = ''
let g:defx_icons_nested_closed_tree_icon = ''

" Define the default higlight color for defx-icons
hi default link DefxIconsMarkIcon         Statement
hi default link DefxIconsCopyIcon         WarningMsg
hi default link DefxIconsMoveIcon         ErrorMsg
hi default link DefxIconsDirectory        Directory
hi default link DefxIconsParentDirectory  Directory
hi default link DefxIconsSymlinkDirectory Directory
hi default link DefxIconsOpenedTreeIcon   Directory
hi default link DefxIconsNestedTreeIcon   Directory
hi default link DefxIconsClosedTreeIcon   Directory
{% endhighlight %}

# Konfigurasi defx-git

{% highlight_caption $HOME/.config/nvim/init.vim %}
{% highlight vimscript linenos %}
" defx-git

if exists('g:plugs["defx-git"]')
  call defx#custom#column('git', 'column_length', 1)

  call defx#custom#column('git', 'raw_mode', 0)

  call defx#custom#column('git', 'indicators', {
  \ 'Modified'  : 'M',
  \ 'Staged'    : '+',
  \ 'Untracked' : '*',
  \ 'Renamed'   : 'R',
  \ 'Unmerged'  : '=',
  \ 'Ignored'   : 'i',
  \ 'Deleted'   : 'X',
  \ 'Unknown'   : '?'
  \ })

  hi Defx_git_Untracked ctermfg=214 ctermbg=NONE
  hi Defx_git_Ignored   ctermfg=214 ctermbg=NONE
  hi Defx_git_Unknown   ctermfg=214 ctermbg=NONE
  hi Defx_git_Renamed   ctermfg=214 ctermbg=NONE
  hi Defx_git_Modified  ctermfg=214 ctermbg=NONE
  hi Defx_git_Unmerged  ctermfg=214 ctermbg=NONE
  hi Defx_git_Deleted   ctermfg=214 ctermbg=NONE
  hi Defx_git_Staged    ctermfg=214 ctermbg=NONE
endif
{% endhighlight %}


# Hasilnya

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/bJnLsY3b/gambar-01.png" onerror="imgError(this);"}{:class="myImg"}

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/BQStvYvQ/gambar-02.gif" onerror="imgError(this);"}{:class="myImg"}

Kalau diperhatikan, kenapa status bar saya dapat berbeda ketika berada di buffer Defx?

Jawabannya ada di post setelah ini.

# Credit

Terima kasih kepada [Elianiva](https://elianiva.github.io/post/defx-nvim/){:target="_blank"} dan [teh Tsara Fatma](https://tsarafatma.com/neovim/2020/02/08/defx-file-explorer-for-neovim){:target="_blank"}, untuk catatan di blognya.


# Pesan Penulis

Sepertinya, segini dulu yang dapat saya tuliskan.

Untuk konfigurasi Defx milik saya yang lebih terbaru, dapat teman-teman kunjungi [di sini](https://github.com/bandithijo/nvimrc/blob/master/plugin-config/defx.nvim.vim){:target="_blank"}.

Mudah-mudahan dapat bermanfaat.

Terima kasih.

(^_^)

# Referensi

1. [github.com/crow-translate/crow-translate](https://github.com/crow-translate/crow-translate){:target="_blank"}
<br>Diakses tanggal: 2020/10/27
