---
layout: 'post'
title: "Mengupgrade Versi Ruby di dalam Rbenv"
date: 2019-10-21 09:25
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Ruby']
pin:
hot:
contributors: []
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Mulai 2019 ini saya masuk ke dalam dunia bahasa pemrograman yang baru saya kenal, yaitu Ruby.

Tujuan saya mempelajari Ruby, karena saya diterima sebagai Junior Backend Rails Developer.

Ya, Rails adalah sebuah Web Framework yang dapat kita gunakan untuk membuat WebApps (*Web Application*).

Untuk memudahkan kita dalam bekerja di dalam Ruby environment yang nyaman di sistem yang kita gunakan, dapat menggunakan [Rbenv](https://github.com/rbenv/rbenv){:target="_blank"}. Ada juga [RVM](https://rvm.io){:target="_blank"}, namun saya tidak familiar.


# Permasalahan

Akhir-akhir ini, saya memperhatikan pada beberapa project yang saya temui di GitHub, sudah menggunakan Ruby versi yang lebih baru. Saat tulisan ini dibuat Ruby 2.6.5

Sedangkan saat ini, pada sistem saya, masih menggunakan Ruby 2.6.3.

Saat saya check dengan `$ ruby install 2.6.` + <kbd>TAB</kbd>, tidak ada versi Ruby yang paling baru.

Disinilah baru saya menyadari, ada sesuatu yang kurang.

# Pemecahan Masalah

Selama ini yang saya lakukan untuk mengupgrade Ruby pada Rbenv ternyata keliru. Karena saya tidak benar-benar membaca petunjuk yang sudah sangat jelas disertakan pada REAMDE.md di halaman GitHub dari Rbenv.

Yang saya lakukan selama ini hanyalah mengupgrade Rbenv dan saya pikir, hanya dengan mengupgrade Rbenv, saya akan mendapatkan Ruby versi terbaru. Ternyata salah. Hehe.

Singkatnya, upgrade di sini ada 2.

1. Upgrade Rbenv
2. Update list of available Ruby versions

Sedangkan yang selama ini saya lakukan hanya nomor 1 saja. Hihihi. Pantesan gak dapet-dapet Ruby versi terbaru.

Nah, kalo sudah begini, tinggal kita jalankan secara berurutan saja.

Sebenarnya Rbenv tidak harus diupgrade sih, tapi yaa siapa yang tidak senang dengan upgrade, hihihi.

## Upgrade Rbenv

Saya memasang Rbenv menggunakan Git, maka proses upgrade tinggal melakukan git pull saja di dalam direktori dari Rbenv.

{% shell_user %}
cd ~/.rbenv
{% endshell_user %}

{% shell_user %}
git pull
{% endshell_user %}

## Update List of Available Ruby Versions

Setelah kita selesai mengupgrade Rbenv. Selanjutnya kita perlu meng-update daftar versi Ruby yang terbaru. Anggep aja ini semacam update metafile gitu deh kalo di repositori distro.

{% shell_user %}
cd ~/.rbenv/plugins/ruby-build
{% endshell_user %}

{% shell_user %}
git pull
{% endshell_user %}

Setelah proses selesai, coba periksa vesi Ruby yang baru, dengan perintah berikut ini.

**Melihat versi yang latest stable release**

{% shell_user %}
rbenv install --list
{% endshell_user %}

<pre>
2.5.8
2.6.6
2.7.2
jruby-9.2.14.0
mruby-2.1.2
rbx-5.0
truffleruby-20.3.0
truffleruby+graalvm-20.3.0

Only latest stable releases for each Ruby implementation are shown.
Use 'rbenv install --list-all / -L' to show all local versions.
</pre>

Maka, versi yang ditampilkan adalah versi terbaru dengan rilis stable.

Kalau ingin melihat semua versi, gunakan perintah di bawah ini.

{% shell_user %}
rbenv install --list
{% endshell_user %}

Maka yang tampil adalah semua versi.

Untuk menspesifikkan pada versi tertentu, kita dapat menggunakan `grep`.

{% shell_user %}
rbenv install --list-all | grep 2.7.
{% endshell_user %}

<pre>
2.7.0-dev
2.7.0-preview1
2.7.0-preview2
2.7.0-preview3
2.7.0-rc1
2.7.0-rc2
2.7.0
2.7.1
2.7.2
jruby-9.2.7.0
rbx-2.71828182
</pre>

Kalo sudah begini, tinggal kita install saja.

{% shell_user %}
rbenv install 2.7.2
{% endshell_user %}

Tunggu prosesnya hingga selesai.

<br>
Nah, mudah kan.

Mudah-mudahan bermanfaat buat teman-teman.

Terima kasih (^_^)v


# Referensi

1. [github.com/rbenv/rbenv](https://github.com/rbenv/rbenv){:target="_blank"}
<br>Diakses tanggal: 2019/10/21

2. [rvm.io](https://rvm.io){:target="_blank"}
<br>Diakses tanggal: 2019/10/21
