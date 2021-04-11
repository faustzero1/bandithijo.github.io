---
layout: 'post'
title: "Catatan dalam Berinteraksi dengan Git"
date: 2021-04-08 15:09
permalink: '/note/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'note'
tags: ['Tips']
wip: true
pin:
contributors: []
description: "Catatan ini berisi hal-hal terkait dengan Git. Beberapa hal mungkin terlupakan karena tidak terlalu sering digunakan. Saya merasa perlu untuk menyimpan dan merangkumnya pada sebuah catatan."
---

# Prakata

Beberapa perintah Git yang tidak sering saya gunakan, cenderung terlupakan. Saya baru menyadari kalau saya melupakannya ketika ada teman yang bertanya, "Bagaimana mengkonfigurasi A?" Saya pun harus mencari-cari sejenak bagaimana cara saya melakukan "A" saat dulu.

Agar hal tersebut tidak perlu terjadi --lupa--, saya memutuskan untuk membuat catatan ini. Mungkin teman-teman yang baru mempelajari atau sudah lama menggunakan Git akan membutuhkannya.

# Konfigurasi

Sekedar pengetahuan, terdapat setidaknya 3 level konfigurasi.

|--------|--------------------------------------|
| Level  | Keterangan                           |
|--------|--------------------------------------|
| SYSTEM | All users                            |
| GLOBAL | All repositories of the current user |
| LOCAL  | The curent repository                |
|--------|--------------------------------------|

Pada catatan ini, saya lebih banyak mencontohkan pada level konfigurasi Global.

## Username & Email

Kita perlu untuk mendefinisikan setidaknya **nama** dan **email**.

{% shell_term $ %}
git config --global user.name "Rizqi Nur Assyaufi"
{% endshell_term %}

{% shell_term $ %}
git config --global user.email "bandithijo@gmail.com"
{% endshell_term %}

## Default editor

Definisikan text editor favorit kalian.

{% shell_term $ %}
git config --global core.editor "vim"
{% endshell_term %}

Ketika git memerlukan editor, akan menggunakan editor yang kita definisikan.

Misalkan pada perintah `$ git commit`.

## Membuka git config dengan editor

Selain mengeset config via `$ git config`, kita juga dapat mengesetnya via file config.

{% shell_term $ %}
git config --global -e
{% endshell_term %}

{% highlight_caption $HOME/.gitconfig %}
{% highlight conf linenos %}
[user]
  name = Rizqi Nur Assyaufi
  email = bandithijo@gmail.com
[core]
  editor = vim
[filter "lfs"]
  clean = git-lfs clean -- %f
  smudge = git-lfs smudge -- %f
  process = git-lfs filter-process
  required = true
{% endhighlight %}

## Konfigurasi End of Line

{% pre_whiteboard %}
# End of line on Windows

  a b c <border>\r</border> <border>\n</border>
        │   │
        │   └─> Line Feed
        │
        └─────> Carriage Return


# End of line on Linux/macOS

  a b c <border>\n</border>
        │
        └─> Line Feed
{% endpre_whiteboard %}

Kita perlu menghandle hal ini agar tidak terjadi issue yang aneh-aneh terkait end of line.

{% shell_term $ %}
git config --global core.autocrlf input
{% endshell_term %}

Jika kamu menggunakan Windows, ganti value **input** menjadi **true**.

## Bantuan untuk git config

Tentu saja untuk membaca manual help dapat menggunakan,

{% shell_term $ %}
git config --help
{% endshell_term %}

<kbd>q</kbd> untuk exit.

Kalau ingin ringkasannya,

{% shell_term $ %}
git config -h
{% endshell_term %}

# Tips & Trick

## Melihat isi dari staging area

Nama lain dari **staging area** adalah **index**, mungkin teman-teman akan menemukan beberapa dokumentasi yang menyebutkan staging area sebagai index.

Untuk melihat isi dari staging area,

{% shell_term $ %}
git ls-files
{% endshell_term %}

## Remove dir/file on staging area

Kasus ini biasanya terjadi apabila kita ingin menghapus dir/file yang sudah terlanjur masuk ke dalam repositori tetap terlambat masuk ke dalam gitignore. Tentu saja, akan diabaikan oleh gitignore, karena dir/file sudah lebih dulu masuk ke dalam repositori.

Untuk mengatasinya, kita gunakan,

{% shell_term $ %}
git rm --cached <nama_dir/file>
{% endshell_term %}












{% comment %}
# Referensi

1. [](){:target="_blank"}
2. [](){:target="_blank"}
3. [](){:target="_blank"}
{% endcomment %}
