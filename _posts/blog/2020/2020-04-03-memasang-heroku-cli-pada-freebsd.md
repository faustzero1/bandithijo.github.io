---
layout: 'post'
title: "Memasang Heroku-CLI pada FreeBSD"
date: 2020-04-03 19:31
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'FreeBSD']
pin:
hot:
---

<!-- BANNER OF THE POST -->
<!-- <img class="post&#45;body&#45;img" src="{{ site.lazyload.logo_blank_banner }}" data&#45;echo="#" alt="banner"> -->

# Pendahuluan

Heroku adalah *Cloud Application Platform* (PAAS - *Platform as a Service*) dimana kita sebagai *web developer* dapat dengan mudah memasang aplikasi yang kita buat agar dapat diakses di internet.

# Permasalahan

Heroku CLI tidak menyediakan binary untuk FreeBSD. Di FreeBSD pkg & ports juga tidak ada.

# Pemecahan Masalah

Untuk mengatasi permasalahan tersebut, ada dua cara.

1. Instalasi manual dengan GitHub clone dan **yarn**
2. Instalasi dengan **node** dan **npm**

Saya akan mulai dari nomor satu.

## Instalasi manual dengan GitHub clone dan yarn

Pertama install **yarn**.

<pre>
$ <b>doas pkg install yarn</b>
</pre>

Lalu cloning repository GitHub heroku/cli.
<pre>
$ <b>git clone https://github.com/heroku/cli.git heroku-cli</b>
</pre>

Masuk ke dalam direktori hasil cloning.
<pre>
$ <b>cd heroku-cli</b>
</pre>

Install dengan menggunakan perintah yarn, proses ini akan mengenerate `bin/run` sebagai heroku cli.
<pre>
$ <b>yarn install</b>
</pre>

Kemudian, buat symbolic link agar dapat diakses dari mana saja.
<pre>
$ <b>doas ln -sf $(pwd)/bin/run /usr/local/bin/heroku</b>
</pre>

**Kekurangan** dari cara instalasi ini adalah waktu dari proses eksekusi yang lama.

Maka dari itu, saya merekomendasikan cara yang kedua.

## Instalasi dengan node dan npm

Pastikan teman-teman sudah memasang `node` dan `npm`.

Kemudian untuk memasang heroku CLI sangat mudah.

<pre>
$ <b>npm install -g heroku</b>
</pre>

**Saya lebih merekomendasikan untuk menggunakan cara kedua**, karena waktu proses eksekusi yang lebih cepat daripada menggunakan cara yang pertama.

Sekarang coba lakukan pengecekan versi.

<pre>
$ <b>heroku --version</b>
</pre>

```
heroku/7.39.2 freebsd-x64 node-v13.10.1
```

Sekian.

Mudah-mudahan dapat bermanfaat buat teman-teman.

Terima kasih.

(^_^)







# Referensi

1. [devcenter.heroku.com/articles/heroku-cli](https://devcenter.heroku.com/articles/heroku-cli){:target="_blank"}
<br>Diakses tanggal: 2020/04/03

2. [github.com/heroku/cli/issues/57#issuecomment-394142666](https://github.com/heroku/cli/issues/57#issuecomment-394142666){:target="_blank"}
<br>Diakses tanggal: 2020/04/03
