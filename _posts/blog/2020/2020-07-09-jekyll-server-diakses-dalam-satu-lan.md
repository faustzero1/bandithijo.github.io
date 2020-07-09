---
layout: 'post'
title: "Jekyll Server Dapat Diakses oleh Perangkat dalam Satu LAN"
date: 2020-07-09 14:56
permalink: '/blog/:title'
author: 'BanditHijo'
license: true
comments: true
toc: true
category: 'blog'
tags: ['Tips', 'Rails']
pin:
hot:
---

# Sekenario Masalah

Saya sedang membangun atau memodifikasi layout dari sebuah web.

Selain mendesain untuk tampilan desktop, saya juga perlu mendesain untuk tampilan mobile.

Agar saya dapat merasakan secara langsung, seperti apa layout yang saya sedang kerjakan, lebih baik kalau saya dapat langsung membukanya secara langsung di *smartphone*.

# Pemecahan Masalah

Jekyll sudah menyediakan fitur untuk menjalankan server dengan mengganti Host yang kita definisikan.

Kita sama-sama tahu kalau *ip address* untuk broadcast di dalam *network* adalah `0.0.0.0`.

Sedangkan, Jekyll server menjalankan host secara default berada pada ip `127.0.0.1`, yang mana ini adalah *localhost*, sehingga hanya dapat diakses oleh kita sendiri dari Browser kita.

Maka, kita perlu mengganti ip address tersebut menjadi ip address untuk *broadcast*.

Caranya sangat mudah.

## Definisikan Host

### 1. Direct Command

Cara pertama, dengan langsung mendefinisikan dari *command* terminal.

Cukup tambahkan option `-H` atau `--host` diikuti dengan *broadcast ip address*.

<pre>
$ <b>bundle exec jekyll s -H 0.0.0.0</b>
</pre>

Atau,

<pre>
$ <b>bundle exec jekyll s --host 0.0.0.0</b>
</pre>

### 2. _config.yml

Cara kedua, dengan mendefinisikan `host:` pada file `_config.yml`.

{% highlight yml linenos %}
# _config.yml

...
...

# Deployment
host: 0.0.0.0
{% endhighlight %}

# Tambahan

## Mengganti Port

Apabila kita ingin mengganti port number yang defaultnya adalah `4000`.

Dapat menggunakan `-p` atau `--port` diikuti nomor portnya.

Atau, dapat pula mendefinisikan `port:` pada file `_config.yml`.

## LiveReload

Dengan LiveReload, kita tidak perlu lagi capek-capek untuk meakukan refresh halaman browser secara manual.

Fitur ini ditambahkan pada Jekyll versi [3.7.0](https://jekyllrb.com/news/2018/01/02/jekyll-3-7-0-released/){:target="_blank"}

Caranya, dapat menggunakan `-l` atau `--livereload` pada saat menjalankan Jekyll server.

<pre>
$ <b>bundle exec jekyll s -l</b>
</pre>

<pre>
$ <b>bundle exec jekyll s --livereload</b>
</pre>

## Incremental Regeneration (Build)

Saat catatan ini ditulis, fitur **incremental regeneration** masih dalam tahap eksperimen.

Teman-teman dapat membaca lebih jelas [di sini](https://jekyllrb.com/docs/configuration/incremental-regeneration/){:target="_blank"}.

Selama masa eksperimen ini, terdapat hal-hal:

**Yang tidak dapat dilakukan** oleh fitur ini, yaitu:

1. Memodifikasi CSS, tidak akan keluar hasilnya.
2. Membuat post/page baru, tidak akan keluar post/page nya.

**Yang berhasil dilakukan** oleh fitur ini, yaitu:

1. Untuk mengedit post atau page. Incremental regeneration akan bekerja dengan sangat baik dan lebih cepat dari proses build tanpa incremental regeneration.

Cara menggunakannya, cukup menambahkan `-I` atau `--incremental`.

Dengan menggunakan fitur ini, menulis Jekyll post menjadi kembali menyenangkan. =P






# Pesan Penulis

Catatan ini bukan merupakan tutorial, saya hanya ingin sharing tentang informasi yang saya dapat dan saya pergunakan selama menulis Blog menggunakan Jekyll.

Maka dari itu, apabila teman-teman ingin mendapatkan penjelasan yang lebih baik, silahkan mengunjungin dokumentasi dari Jekyll. Tentunya akan lebih *up to date* dari yang saya tulis di sini.

Saya rasa hanya ini yang dapat saya tuliskan saat ini.

Mudah-mudahan dapat bermanfaat untuk teman-teman.

Terima kasih.

(^_^)








# Referensi

1. [jekyllrb.com/news/2018/01/02/jekyll-3-7-0-released/](https://jekyllrb.com/news/2018/01/02/jekyll-3-7-0-released/){:target="_blank"}
<br>Diakses tanggal: 2020/07/09

2. [jekyllrb.com/docs/configuration/incremental-regeneration/](https://jekyllrb.com/docs/configuration/incremental-regeneration/){:target="_blank"}
<br>Diakses tanggal: 2020/07/09

3. [jekyllrb.com/docs/configuration/options/#serve-command-options](https://jekyllrb.com/docs/configuration/options/#serve-command-options){:target="_blank"}
<br>Diakses tanggal: 2020/07/09
