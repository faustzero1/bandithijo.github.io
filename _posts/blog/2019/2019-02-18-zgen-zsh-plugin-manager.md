---
layout: 'post'
title: 'Zgen, ZSH Plugin Manager'
date: 2019-02-18 12:15
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Ulasan', 'Tips', 'Terminal']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Sejak menggunakan macOS (dulunya OSX), saya sudah mengenal ZSH shell dalam keseharian menggunakan Terminal. Saat itu kira-kira sekitar tahun 2014. Namun, baru sekarang saya sadari ternyata ZSH juga memiliki *plugin manger*.

Berawal dari keinginan saya untuk menggunakan ZSH theme yang simpel, kemudian [Nanda Okitavera](https://okitavera.me/){:target="_blank"} mengenalkan ZSH theme bernama [**subnixr/minimal**](https://github.com/subnixr/minimal){:target="_blank"}. Proses instalasi ZSH theme ini menggunakan Zgen atau Antigen. Dari sinilah awal perkenalan saya dengan Zgen -- *A lightweight plugin manager for Zsh inspired by Antigen*.

# Alasan Menggunakan Zgen

Seperti namanya, *plugin manager*, tentunya berguna untuk memanajemen plugin. Mungkin teman-teman yang menggunakan Vim *text editor* akan langsung memahami, bahwa keberadaan *plugin manager* sangat memudahkan kita membongkar-pasang Vim plugin yang ingin atau tidak kita gunakan. Semudah memanajemen plugins/extensions pada *text editor* GUI seperti VSCode.

Penjelasan mengenai **Apa itu Zgen?** dapat dibaca sendiri pada halaman GitHub dari Zgen, [di sini](https://github.com/tarjoilija/zgen){:target="_blank"}.

# Instalasi

## Instalasi Zgen

1. Backup `.zshrc`.

    ```
    $ cp ~/.zshrc ~/.zshrc.old
    ```
    Atau bisa gunakan nama apa saja. `.bak`, `.backup`, dll.

2. Cloning repository Zgen.

    ```
    $ git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
    ```
    Hasil *cloning* di atas akan berada pada direktori `~/.zgen/`.

3. Tambahkan bari di bawah ini pada file `~/.zshrc`.

    ```bash
    # load zgen
    source "${HOME}/.zgen/zgen.zsh"
    ...
    ...
    ```
    Letakkan saja pada posisi paling atas dari `.zshrc`.

    Saran saya, hapus saja semua konfigurasi `oh-my-zsh` yang ada di dalam file `.zshrc`.

    Selesai. Proses pemasangan dan konfigurasi Zgen hanya seperti ini saja.

    Sangat mudah bukan?

    Selanjutnya, pemasangan `oh-my-zsh` sebagai plugin.

## Instalasi OH-MY-ZSH

1. Tambahkan di bagian bawah atau setelah baris kode `# load zgen` di atas.

    ```bash
    # if the init scipt doesn't exist
    if ! zgen saved; then
        echo "Creating a zgen save"

        zgen oh-my-zsh

        # plugins OH-MY-ZSH
        zgen oh-my-zsh plugins/git
        zgen oh-my-zsh plugins/sudo
        zgen oh-my-zsh plugins/gem
        zgen oh-my-zsh plugins/python
        zgen oh-my-zsh plugins/systemd
        zgen oh-my-zsh plugins/tmux
        zgen oh-my-zsh plugins/archlinux
        zgen oh-my-zsh plugins/command-not-found

        # theme
        zgen oh-my-zsh themes/avit

        # save all to init script
        zgen save
    fi
    ```
    Selesai. Hanya seperti ini saja cara pemasangannya.

2. Kemudian untuk penambahakn plugin lain seperti [**zsh-usrs/zsh-completions**](https://github.com/zsh-users/zsh-completions){:target="_blank"}, tingal menambahkan saja di bagian dalam dari `if ... fi`.

    ```bash
        ...
        ...
        # completions
        zgen load zsh-users/zsh-completions src
        ...
        ...
    ```

3. Satu contoh plugin lagi, misalnya plugin untuk theme, seperti [**subnixr/minimal**](https://github.com/subnixr/minimal){:target="_blank"}.

    ```bash
        ...
        ...
        # minimal themes
        zgen load subnixr/minimal
        ...
        ...
    ```
    Kemudian, tambahkan konfigurasi untuk **minimal** theme ini di bagian luar dari blok plugin.

    ```bash
    MNML_OK_COLOR=7
    MNML_ERR_COLOR=1
    MNML_USER_CHAR='$'
    MNML_INSERT_CHAR=''
    MNML_NORMAL_CHAR=''

    # Components on the left prompt
    MNML_PROMPT=(mnml_ssh mnml_status mnml_keymap)

    # Components on the right prompt
    MNML_RPROMPT=('mnml_cwd 2 0' mnml_git)

    # Components shown on info line
    MNML_INFOLN=(mnml_err mnml_jobs mnml_uhp mnml_files)

    # An additional array is used to configure magic enter's behavior:
    MNML_MAGICENTER=(mnml_me_dirs mnml_me_ls mnml_me_git)
    ```

# Hasilnya

Secara keseluruhan, isi dari kesemua komponan di atas yang ada di dalam file `~/.zshrc` saya akan seperti ini.

```bash
# -----------------------------------------------------------------ZGEN CONFIG
# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/gem
    zgen oh-my-zsh plugins/python
    zgen oh-my-zsh plugins/systemd
    zgen oh-my-zsh plugins/tmux
    zgen oh-my-zsh plugins/archlinux
    zgen oh-my-zsh plugins/command-not-found

    # completions
    zgen load zsh-users/zsh-completions src

    # theme
    zgen oh-my-zsh themes/avit

    # minimal themes
    zgen load subnixr/minimal

    # save all to init script
    zgen save
fi
# -------------------------------------------------------------END ZGEN CONFIG


# ---------------------------------------------------------------------MINIMAL
MNML_OK_COLOR=7          # default: 2
MNML_ERR_COLOR=1         # default: 1
MNML_USER_CHAR='$'       # default: λ
MNML_INSERT_CHAR=''      # default: ›
MNML_NORMAL_CHAR=''      # default: ·


# Components on the left prompt
MNML_PROMPT=(mnml_ssh mnml_pyenv mnml_status mnml_keymap)

# Components on the right prompt
MNML_RPROMPT=('mnml_cwd 2 0' mnml_git)

# Components shown on info line
MNML_INFOLN=(mnml_err mnml_jobs mnml_uhp mnml_files)

# An additional array is used to configure magic enter's behavior:
MNML_MAGICENTER=(mnml_me_dirs mnml_me_ls mnml_me_git)
# -----------------------------------------------------------------END MINIMAL
```

Untuk melihat isi dari `~/.zshrc` lebih lengkap, silahkan melihat pada repositori dotfiles milik saya, [**di sini**](https://github.com/bandithijo/dotfiles/blob/master/.zshrc){:target="_blank"}.

<!-- PERTANYAAN -->
<div class="blockquote-yellow">
<div class="blockquote-yellow-title">Mengapa saya menggunakan dua buah theme ?</div>
<p>Saya menggunakan <b>oh-my-zsh</b> theme yang bernama <b>avit</b> sebagai <i>fallback</i> apabila <b>minimal</b> theme yang saya gunakan mengalami kendala.</p>
<p>Ini juga hanya asumsi saya saja. Untuk mengantisipasi. Pada kenyataannya juga belum teruji. Karena selama ini, belum pernah menemui kendala dengan <b>minimal</b> theme.</p>
</div>


# Reset Konfigurasi

Setelah menambahkan atau menghapus plugin, jangan lupa untuk melakukan perintah *reset*.
```
$ zgen reset
```
```
-- zgen: Deleting `/home/bandithijo/.zgen/init.zsh` ...
```
Lalu exit dan buka kembali Terminal emulator kita.

Maka akan keluar *output* seperti di bawah.
```
Creating a zgen save
-- zgen: Creating `/home/bandithijo/.zgen/init.zsh` ...
-- zgen: Initializing completions ...
```
Selesai.

# Troubleshoting

## Perintah Terulang pada Output

**Maret 16, 2019**

Sebenarnya, sudah pernah mengalami hal ini, namun karena lupa melakukan pencatatan, dan ternyata mengalami untuk kedua kali, malah jadi kebingungan.

![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/1Xs2bb4M/gambar-02.gif"}

Dapat dilihat pada ilustrasi di atas, apapun perintah (*command*) yang saya tulisakan, akan ditampilkan kembali pada baris *output*.

![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/qR8WbpBz/gambar-01.png"}

Saya mengalami permasalah ini pada terminal URxvt dan Termite, namun tidak pada ST terminal yang sehari-hari saya pergunakan.

Namun, pada ST terminal, saat saya menggunakan `:terminal` di dalam Vim text editor, permasalahan yang sama mulai terlihat.

Untung saja ada group [BGLI (Belajar GNU/Linux Indonesia)](https://t.me/GNULinuxIndonesia){:target="_blank"}, jadi bisa menanyakan di sana.

>Terkadang perlu "sudut pandang" orang lain dalam menemukan "kata kunci" yang tepat untuk mencari solusi dari sebuah masalah.

![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/K8MfrJ8Y/gambar-03.png"}

<p class="img-caption">URL: <a href="https://stackoverflow.com/questions/30940299/zsh-repeats-command-in-output">ZSH repeats command in output</a></p>

Dari jawaban yang diberikan pada tautan di atas. Kita perlu menambahkan variabel milik OH-MY-ZSH, yaitu:

```
DISABLE_AUTO_TITLE="true"
```

Karena, saya belum memasukkan variabel-variabel milik OH-MY-ZSH pada file `~/.zshrc` milik saya.

Apabila ingin ditambahkan variabel-variabel milik OH-MY-ZSH secara komplit, kira-kira seperti ini.

<pre>
# -------------------------------------------------------------------OH-MY-ZSH
# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
<mark>DISABLE_AUTO_TITLE="true"</mark>

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# ---------------------------------------------------------------END OH-MY-ZSH
</pre>

Dengan begini permasalahan "Perintah Terulang pada Output" tidak terjadi lagi.

Terima kasih untuk **Karen Kishou @snowsu**.

# Pesan Penulis

Tulisan ini bukan merupakan tulisan tandingan dari dokumentasi resmi yang ditulis oleh developer dari Zgen, melainkan hanya sebagai ulasan mengenai bagaimana saya dalam menggunakan dan mengkonfigurasi Zgen ke dalam sistem yang saya miliki.

Apabila terdapat kekeliruan atau untuk penjelasan lebih detail, silahkan merujuk pada sumber-sumber referensi yang sudah saya sertakan di bawah.

Sepertinya ini saja. Mudah-mudahan dapat bermanfaat untuk teman-teman.


# Referensi

1. [github.com/tarjoilija/zgen](https://github.com/tarjoilija/zgen){:target="_blank"}
<br>Diakses tanggal: 2019/02/18

2. [github.com/subnixr/minimal](https://github.com/subnixr/minimal){:target="_blank"}
<br>Diakses tanggal: 2019/02/18

