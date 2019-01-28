---
layout: 'post'
title: 'Bermigrasi dari Cloudflare ke Netlify'
date: 2019-01-28 01:18
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Jekyll', 'Web', 'Tips', 'Ulasan']
pin:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Prakata

Bermigrasi? Sepertinya untuk kasus saya, lebih pas kalau saya sebut "mencoba". Ya, belajar mencoba menggunakan platform lain.

Awalnya hanya ingin coba-coba, namun setelah berhasil dan merasakan ada "*something*" yang saya rasakan lebih baik dari Netlify ketimbang menggunakan Cloudflare, saya pun memutuskan untuk tetap menggunakan Netlify.

Kedua platform ini tidak dapat dibandingkan karena memiliki definisi dan fungsi yang berbeda.

[Apa itu Cloudflare?](https://www.cloudflare.com/){:target="_blank"}
<span style="font-size:14px;"><i>Cloudflare, Inc. is a U.S. company that provides content delivery network services, DDoS mitigation, Internet security and distributed domain name server services. Cloudflare's services sit between the visitor and the Cloudflare user's hosting provider, acting as a reverse proxy for websites. - Wikipedia</i></span>

[Apa itu Netlify?](https://www.netlify.com/){:target="_blank"}
<span style="font-size:14px;"><i>Netlify is a San Francisco-based cloud computing company that offers hosting and serverless backend services for static websites. It features continuous deployment from Git across a global application delivery network, serverless form handling,support for AWS Lambda functions, and full integration with Let's Encrypt. - Wikipedia</i></span>

Pokoknya, saat ini, saya hanya butuh konfigurasi DNS dan Nameservers-nya saja untuk dapat menghubungkan GitHub/GitLab dengan domain name yang saya beli dari Dewaweb.

# Proses Migrasi

Proses-proses di bawah ini tidak harus selalu berurutan. Saya mencoba menyusun dan mengurutkan berdasarkan hal-hal yang saya anggap paling mudah dilakukan terlebih dahulu.

## 1. Menghapus GitHub Page

1. Buka tab **Settings** pada repository GitHub.
![gambar_1]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/kgV8Y97C/gambar-01.png"}
2. Scrolling ke bawah, pada bagian "GitHub Pages". Ganti **Source** dari **master branch** menjadi **None**.
![gambar_2]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/6QnZw071/gambar-02.png"}
Kemudian, **Save**.

    Dengan begini, repository **bandithijo.github.io** sudah tidak lagi menjadi GitHub page.
3. Selanjutnya, rename repository dari **bandithijo.github.io** menjadi **bandithijo.com**.
![gambar_3]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/0QCJKy0Y/gambar-03.png"}
Kemudian **Rename**.
<br><br>
Setelah berhasil, nama dari repositori saya akan berubah.
![gambar_4]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/wvzmBmLx/gambar-04.png"}
Tujuannya hanya untuk menyamakan presepsi saja, bahwa sudah tidak ada lagi repository yang bernama **bandithijo.github.io**.

    Agar dikemudian hari tidak menimbulkan ambigu.

## 2. Mengganti Nama Direktori Root

1. Saya juga perlu mengganti nama direktori root yang ada di laptop.
```
$ mv bandithijo.github.io bandithijo.com
```
Tujuannya masih sama, agar tidak menimbulkan ambigu di kemudian hari.

## 3. Mengganti Alamat Git Remote

1. Ganti alamat GitHub **remote** yang lama dengan yang baru.
```
$ vim .git/config
```
Ganti pada section `[remote "origin"]`, `/bandithijo.github.io.git` menjadi `/bandithijo.com.git`.
    <pre>
...
...
[remote "origin"]
    url = git@github.com:bandithijo/<mark>bandithijo.com</mark>.git
	fetch = +refs/heads/*:refs/remotes/origin/*
...
...</pre>
Perubahan alamat remote ini adalah hal yang direkomendasikan oleh perintah `git` saat saya melakukan `git push -u origin master`.
![gambar_5]({{ site.lazyload.logo_blank }}){:data-echo="https://i.postimg.cc/jS5Cdr51/gambar-05.png"}

## 4. Menghapus CNAME

1. Hapus **CNAME** yang ada pada root direktori.
    <pre>
bandithijo.com
├── _drafts/
├── _includes/
├── _layouts/
├── _posts/
├── _site/
├── assets/
├── pages/
├── _config.yml
├── 404.html
├── <mark>CNAME</mark>  <-- Hapus aku
├── Gemfile
├── Gemfile.lock
└── index.html</pre>
```
$ rm CNAME
```





# Referensi

1. [](){:target="_blank"}
<br>Diakses tanggal: 2019/01/28

2. [](){:target="_blank"}
<br>Diakses tanggal: 2019/01/28

3. [](){:target="_blank"}
<br>Diakses tanggal: 2019/01/28


