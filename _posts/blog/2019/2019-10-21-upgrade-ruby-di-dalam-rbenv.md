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

```
$ cd ~/.rbenv
$ git pull
```

## Update List of Available Ruby Versions

Setelah kita selesai mengupgrade Rbenv. Selanjutnya kita perlu meng-update daftar versi Ruby yang terbaru. Anggep aja ini semacam update metafile gitu deh kalo di repositori distro.

```
$ cd ~/.rbenv/plugins/ruby-build
$ git pull
```

Setelah proses selesai, coba periksa vesi Ruby yang baru, dengan perintah berikut ini.

```
$ rbenv install --list | grep 2.6.
```

Pasti sudah ada versi Ruby yang paling baru.

<pre>
2.6.0-dev
2.6.0-preview1
2.6.0-preview2
2.6.0-preview3
2.6.0-rc1
2.6.0-rc2
2.6.0
2.6.1
2.6.2
2.6.3
2.6.4
<mark>2.6.5</mark>
jruby-9.2.6.0
</pre>

Kalo sudah begini, tinggal kita install saja.

```
$ rbenv install 2.6.5
```

Nah, mudah kan.

Mudah-mudahan bermanfaat buat teman-teman.

Terima kasih (^_^)v


# Referensi

1. [github.com/rbenv/rbenv](https://github.com/rbenv/rbenv){:target="_blank"}
<br>Diakses tanggal: 2019/10/21

2. [rvm.io](https://rvm.io){:target="_blank"}
<br>Diakses tanggal: 2019/10/21
